import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import '../../firebase/local/firebase_utils.dart';
import '../../firebase/model/event_model_fire.dart';
import '../../model/event_model.dart';

class EventProvider extends ChangeNotifier {
  List<EventModelFire> listAllEvent = [];
  List<EventModelFire> filterList = [];
  List<EventModelFire> filterFavouriteList = [];
  List<EventModel> eventsModel = EventModel.events;

  int selectedIndex = 0;

  void getAllEvent() async {
    //todo: get event
    QuerySnapshot<EventModelFire> query =
        await FireBaseUtils.getEventCollection().get();
    //todo: List<EventModelFire>   map  List<QueryDocumentSnapshot<EventModelFire>>
    listAllEvent = query.docs.map((e) => e.data()).toList();
    filterList = listAllEvent;
    //todo: sort event date
    filterList.sort(
      (event1, event2) => event1.dateEvent.compareTo(event2.dateEvent),
    );
    notifyListeners();
  }

  void getFilterEvent() async {
    //todo: get event
    QuerySnapshot<EventModelFire> query =
        await FireBaseUtils.getEventCollection().get();
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
  void changeIndex(index) async {
    selectedIndex = index;
    selectedIndex == 0 ? getAllEvent() : getFilterEvent();
  }

  void updateFavouriteEvent(EventModelFire event, BuildContext context) {
    //todo: update favourite event
    FireBaseUtils.getEventCollection()
        .doc(event.id)
        .update({'isFavourite': !event.isFavourite})
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(CustomSnackbar.show('event_update'));
          },
        );
    selectedIndex==0?getAllEvent():getFilterEvent();
    getAllFavouriteEvent();
    notifyListeners();
  }

  void getAllFavouriteEvent() async{
    //todo: filter favourite event
    QuerySnapshot<EventModelFire> query =
        await FireBaseUtils.getEventCollection().get();
    //todo: List<EventModelFire>   map  List<QueryDocumentSnapshot<EventModelFire>>
    listAllEvent = query.docs.map((e) => e.data()).toList();
    //todo:  filter favourite event
    filterFavouriteList = listAllEvent.where((element) {
      return element.isFavourite==true;
    }).toList();
    //todo: sort fav event date
    filterFavouriteList.sort(
          (event1, event2) => event1.dateEvent.compareTo(event2.dateEvent),
    );
    notifyListeners();
  }
}
