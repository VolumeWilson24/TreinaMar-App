class Boat {
  String sId;
  String name;
  String imageUrl;

  Boat({this.sId, this.name, this.imageUrl});

  Boat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    return data;
  }
}