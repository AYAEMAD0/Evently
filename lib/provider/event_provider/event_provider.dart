import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../firebase/local/firebase_utils.dart';
import '../../firebase/model/event_model_fire.dart';
import '../../model/event_model.dart';

class EventProvider extends ChangeNotifier {
  List<EventModelFire> listAllEvent = [];
  List<EventModelFire> filterList = [];
  List<EventModel> eventsModel = EventModel.events;

  int selectedIndex = 0;

  void getAllEvent(String uid) async {
    //todo: get event
    QuerySnapshot<EventModelFire> query =
        await FireBaseUtils.getEventCollection(uid).get();
    //todo: List<EventModelFire>   map  List<QueryDocumentSnapshot<EventModelFire>>
    listAllEvent = query.docs.map((e) => e.data()).toList();
    filterList = listAllEvent;
    //todo: sort event date
    filterList.sort(
      (event1, event2) => event1.dateEvent.compareTo(event2.dateEvent),
    );
    notifyListeners();
  }

  void getFilterEvent(String uid) async {
    //todo: get event
    QuerySnapshot<EventModelFire> query =
        await FireBaseUtils.getEventCollection(uid).get();
    //todo: List<EventModelFire>   map  List<QueryDocumentSnapshot<EventModelFire>>
    listAllEvent = query.docs.map((e) => e.data()).toList();
    //todo: filter event
    filterList = listAllEvent.where((element) {
      return element.nameCategoryEvent.toLowerCase() ==
          eventsModel[selectedIndex].eventName.toLowerCase();
    }).toList();
    //todo: sort event date
    filterList.sort(
      (event1, event2) => event1.dateEvent.compareTo(event2.dateEvent),
    );
    notifyListeners();
  }

  //todo: change index for tabs
  void changeIndex(index,String uid) async {
    selectedIndex = index;
    selectedIndex == 0 ? getAllEvent(uid) : getFilterEvent(uid);
  }
}
