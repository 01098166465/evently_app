class UserModel {
  String name;
  String email;
  String id;
  List<String> favouriteEventsIds;

  UserModel({
    required this.email,
    required this.id,
    required this.name,
    required this.favouriteEventsIds,
  });
  UserModel.formJson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        favouriteEventsIds: json["favouriteEventsIds"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "favouriteEventsId": favouriteEventsIds,
  };
}
