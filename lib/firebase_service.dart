import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventsCollection() =>
      FirebaseFirestore.instance
          .collection("events")
          .withConverter<EventModel>(
            fromFirestore: (docSnapshot, _) =>
                EventModel.formJson(docSnapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
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
}
