class EventModelFire {
  String? id;
  String imageLightEvent;
  String imageDarkEvent;
  String nameCategoryEvent;
  String titleEvent;
  String descEvent;
  DateTime dateEvent;
  String timeEvent;
  //String mapEvent;
  bool? isFavourite;

  EventModelFire({
    this.id = '',
    required this.imageLightEvent,
    required this.imageDarkEvent,
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
  EventModelFire.fromFirestore(Map<String, dynamic> json)
    : this(
        id: json['id'],
        imageLightEvent: json['imageLightEvent'] ?? '',
        imageDarkEvent: json['imageDarkEvent'] ?? '',
        nameCategoryEvent: json['nameCategoryEvent'] ?? '',
        titleEvent: json['titleEvent'] ?? '',
        descEvent: json['descEvent'] ?? '',
        dateEvent: json['dateEvent'] != null
            ? DateTime.fromMicrosecondsSinceEpoch(json['dateEvent'])
            : DateTime.now(),
        timeEvent: json['timeEvent'] ?? '',
        isFavourite: json['isFavourite'] ?? false,
      );

  //todo me send for firebase object(convert object into json)
  //todo object=>json
  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "imageLightEvent": imageLightEvent,
      "imageDarkEvent": imageDarkEvent,
      "nameCategoryEvent": nameCategoryEvent,
      "titleEvent": titleEvent,
      "descEvent": descEvent,
      "dateEvent": dateEvent.microsecondsSinceEpoch,
      "timeEvent": timeEvent,
      "isFavourite": isFavourite,
    };
  }
}
