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

  static Future<void> addEventTOFireStore(EventModelFire event) {
    CollectionReference<EventModelFire> collectionRef = getEventCollection();
    DocumentReference<EventModelFire> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}