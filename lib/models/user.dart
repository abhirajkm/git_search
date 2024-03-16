class User {
  late String name;
  late String bio;
  late int repos;
  late String image;
  late String profileUrl;



  User.fromJson(Map<String, dynamic> json)
      :name = json["name"] ?? "NA",
        bio = json["bio"] ?? "NA",
        image = json["avatar_url"] ?? "NA",
        profileUrl = json["html_url"] ?? "NA",
        repos = json["public_repos"] ?? 0 ;



  static List<User> convertToList(List<dynamic> list) {
    return list.map((e) =>User.fromJson(e)).toList();
  }
}