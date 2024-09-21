class StationListsModel {
  String stationName;
  String url;

  StationListsModel(this.stationName, this.url);

  // Named constructor to create an instance from a JSON object
  StationListsModel.fromJson(Map<String, dynamic> json)
      : stationName = json['stationName'],
        url = json['url'];

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() => {
    'stationName': stationName,
    'url': url,
  };
}