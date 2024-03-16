class Repo {
  late String name;
  late String full_name;
  late String avatar_url;
  late String projectUrl;
  late String language;

  Repo.fromJson(Map<String, dynamic> json)
      : name = json["name"] ?? "",
        full_name = json["full_name"] ?? "",
        avatar_url = json["owner"]["avatar_url"] ?? "",
        projectUrl = json["html_url"] ?? "",
        language = json["language"] ?? "";

  static List<Repo> convertToList(List<dynamic> list) {
    return list.map((e) => Repo.fromJson(e)).toList();
  }
}
