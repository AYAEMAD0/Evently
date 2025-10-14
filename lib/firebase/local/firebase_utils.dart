import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase/remote/firebase_utils_remote.dart';

import '../model/event_model_fire.dart';

class FireBaseUtils {
  static CollectionReference<EventModelFire> getEventCollection(String uid) {
    return
      FirebaseUtilsRemote.getUserCollection().doc(uid)
        .collection(EventModelFire.collectionName).
    withConverter<EventModelFire>(
        fromFirestore: (snapshot, options) =>
            EventModelFire.fromFirestore(snapshot.data()!),
        toFirestore: (value, options) => value.toFirestore());
  }

  static Future<void> addEventToFireStore(EventModelFire event,String uid) {
    CollectionReference<EventModelFire> collectionRef = getEventCollection(uid);
    DocumentReference<EventModelFire> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
  static Future<void> editEventToFireStore(EventModelFire event,String uid) {
    if (event.id == null || event.id!.isEmpty) {
      return Future.error("Cannot update event: Event ID is missing.");
    }
    CollectionReference<EventModelFire> collectionRef = getEventCollection(uid);
    DocumentReference<EventModelFire> docRef = collectionRef.doc(event.id);
    return docRef.update(event.toFirestore());
  }
  static Future<void> deleteEventToFireStore(EventModelFire event,String uid) {
    if (event.id == null || event.id!.isEmpty) {
      return Future.error("Cannot update event: Event ID is missing.");
    }
    CollectionReference<EventModelFire> collectionRef = getEventCollection(uid);
    DocumentReference<EventModelFire> docRef = collectionRef.doc(event.id);
    return docRef.delete();
  }
}
