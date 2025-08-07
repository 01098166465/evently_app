import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventsCollection() =>
      FirebaseFirestore.instance
          .collection("events")
          .withConverter<EventModel>(
            fromFirestore: (docSnapshot, _) =>
                EventModel.fromFirestore(docSnapshot),
            toFirestore: (event, _) => event.toJson(),
          );

  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance
          .collection("users")
          .withConverter<UserModel>(
            fromFirestore: (docSnapshot, _) =>
                UserModel.formJson(docSnapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  static Future<void> createEvent(EventModel event) async {
    final eventsCollection = getEventsCollection();
    final doc = eventsCollection.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  static Future<void> updateEvent(EventModel event) async {
    final eventsCollection = getEventsCollection();

    if (event.id == null) {
      throw Exception("Event ID is required to update the event.");
    }

    await eventsCollection.doc(event.id).set(event);
  }

  static Future<void> deleteEvent(String eventId) async {
    final eventsCollection = getEventsCollection();
    final usersCollection = getUsersCollection();

    await eventsCollection.doc(eventId).delete();

    final usersSnapshot = await usersCollection.get();
    for (var userDoc in usersSnapshot.docs) {
      final user = userDoc.data();
      if (user.favouriteEventsIds.contains(eventId)) {
        await userDoc.reference.update({
          "favouriteEventsIds": FieldValue.arrayRemove([eventId]),
        });
      }
    }
  }

  static Future<List<EventModel>> getEvents() async {
    final eventsCollection = getEventsCollection();
    final querySnapshot = await eventsCollection.orderBy("timestamp").get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      favouriteEventsIds: [],
    );

    final usersCollection = getUsersCollection();
    await usersCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final usersCollection = getUsersCollection();
    final docSnapshot = await usersCollection.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<void> addEventToFavourites(String eventId) async {
    final usersCollection = getUsersCollection();
    final userDoc = usersCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    return userDoc.update({
      "favouriteEventsIds": FieldValue.arrayUnion([eventId]),
    });
  }

  static Future<void> removeEventToFavourites(String eventId) async {
    final usersCollection = getUsersCollection();
    final userDoc = usersCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    return userDoc.update({
      "favouriteEventsIds": FieldValue.arrayRemove([eventId]),
    });
  }

  static Future<UserModel> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'sign-in-cancelled',
        message: 'User cancelled Google sign-in',
      );
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    final user = userCredential.user!;
    final usersCollection = getUsersCollection();

    final doc = await usersCollection.doc(user.uid).get();

    if (!doc.exists) {
      final newUser = UserModel(
        id: user.uid,
        name: user.displayName ?? "Unnamed",
        email: user.email ?? "",
        favouriteEventsIds: [],
      );
      await usersCollection.doc(newUser.id).set(newUser);
      return newUser;
    } else {
      return doc.data()!;
    }
  }
}
