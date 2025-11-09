import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase/model/user_model.dart';

class FirebaseUtilsRemote{
  static CollectionReference<UserModel> getUserCollection(){
    return FirebaseFirestore.instance.collection(UserModel.collectionName).
    withConverter<UserModel>(
      fromFirestore: (snapshot, options) => UserModel.fromFirebase(snapshot.data()!),
      toFirestore: (value, options) => value.toFirebase(),);
  }
  Future<void> addUserToFirebase(UserModel user){
    return FirebaseUtilsRemote.getUserCollection().doc(user.id).set(user);
  }
  Future<UserModel?> getUserFromFirebase(String id)async{
    var query =await FirebaseUtilsRemote.getUserCollection().doc(id).get();
    return query.data();
  }
}