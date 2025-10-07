class EventModelFire {
  String? id;
  String imageEvent;
  String nameCategoryEvent;
  String titleEvent;
  String descEvent;
  DateTime dateEvent;
  String timeEvent;
  //String mapEvent;
  bool? isFavourite;

  EventModelFire({
    this.id='',
    required this.imageEvent,
    required this.nameCategoryEvent,
    required this.titleEvent,
    required this.descEvent,
    required this.dateEvent,
    required this.timeEvent,
    this.isFavourite = false,
  });
  static const String collectionName = 'Event';
  //todo firebase return json(convert json into object)
  //todo json=>object
  EventModelFire.fromFirestore(Map<String, dynamic> json) :this(
       id: json['id'],
       imageEvent: json['imageEvent'],
     nameCategoryEvent: json['titleEvent'],
     titleEvent: json['titleEvent'],
     descEvent: json['descEvent'],
     dateEvent: DateTime.fromMicrosecondsSinceEpoch(json['dateEvent']),
     timeEvent: json['timeEvent'],
     isFavourite: json['isFavourite'],
   );

  //todo me send for firebase object(convert object into json)
  //todo object=>json
  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "imageEvent": imageEvent,
      "nameCategoryEvent": nameCategoryEvent,
      "titleEvent": titleEvent,
      "descEvent": descEvent,
      "dateEvent": dateEvent.microsecondsSinceEpoch,
      "timeEvent": timeEvent,
      "isFavourite": isFavourite,
    };
  }
}
