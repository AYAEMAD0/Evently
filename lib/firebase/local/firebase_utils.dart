import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/event_model_fire.dart';

class FireBaseUtils {
  static CollectionReference<EventModelFire> getEventCollection() {
    return FirebaseFirestore
        .instance
        .collection(EventModelFire.collectionName).
    withConverter<EventModelFire>(
        fromFirestore: (snapshot, options) =>
            EventModelFire.fromFirestore(snapshot.data()!),
        toFirestore: (value, options) => value.toFirestore());
  }

  static Future<void> addEventToFireStore(EventModelFire event) {
    CollectionReference<EventModelFire> collectionRef = getEventCollection();
    DocumentReference<EventModelFire> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
  static Future<void> editEventToFireStore(EventModelFire event) {
    if (event.id == null || event.id!.isEmpty) {
      return Future.error("Cannot update event: Event ID is missing.");
    }
    CollectionReference<EventModelFire> collectionRef = getEventCollection();
    DocumentReference<EventModelFire> docRef = collectionRef.doc(event.id);
    return docRef.update(event.toFirestore());
  }
  static Future<void> deleteEventToFireStore(EventModelFire event) {
    if (event.id == null || event.id!.isEmpty) {
      return Future.error("Cannot update event: Event ID is missing.");
    }
    CollectionReference<EventModelFire> collectionRef = getEventCollection();
    DocumentReference<EventModelFire> docRef = collectionRef.doc(event.id);
    return docRef.delete();
  }
}