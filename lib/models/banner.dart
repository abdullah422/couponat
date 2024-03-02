class Banner {
  late int id;
  late String name;
  late String image;

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
