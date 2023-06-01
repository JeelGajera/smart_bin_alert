class BinModel {
  String? id;
  int? fill;
  String? location;

  BinModel({this.id, this.fill, this.location});

  BinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fill = json['fill'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fill'] = fill;
    data['location'] = location;
    return data;
  }
}
