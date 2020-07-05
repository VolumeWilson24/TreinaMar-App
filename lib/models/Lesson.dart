class Lesson {
  List<String> boat;
  String sId;
  String title;
  String level;
  String url;

  Lesson({this.boat, this.sId, this.title, this.level, this.url});

  Lesson.fromJson(Map<String, dynamic> json) {
    boat = json['boat'].cast<String>();
    sId = json['_id'];
    title = json['title'];
    level = json['level'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boat'] = this.boat;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['level'] = this.level;
    data['url'] = this.url;
    return data;
  }
}