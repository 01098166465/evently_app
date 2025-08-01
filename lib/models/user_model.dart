class UserModel {
  String name;
  String email;
  String id;
  UserModel({required this.email, required this.id, required this.name});
  UserModel.formJson(Map<String, dynamic> json)
    : this(id: json["id"], name: json["name"], email: json["email"]);
  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};
}
