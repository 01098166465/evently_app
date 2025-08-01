import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventsCollection() =>
      FirebaseFirestore.instance
          .collection("events")
          .withConverter<EventModel>(
            fromFirestore: (docSnapshot, _) =>
                EventModel.formJson(docSnapshot.data()!),
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

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventsCollection = getEventsCollection();
    DocumentReference<EventModel> doc = eventsCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventsCollection = getEventsCollection();
    QuerySnapshot<EventModel> querySnapshot = await eventsCollection
        .orderBy("timestamp")
        .get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
    );
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    await usersCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentSnapshot<UserModel> docSnapshot = await usersCollection
        .doc(credential.user!.uid)
        .get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}
