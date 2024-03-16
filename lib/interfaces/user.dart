import 'package:flutter/foundation.dart';

import '../models/repo.dart';
import '../models/user.dart';
import '../utils/api/api_methods.dart';
import '../utils/api/api_request.dart';

class UserInterface {
  static Future<User?> fetchUser({required String username}) async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.GET,
          route: username);

      return User.fromJson(response);
    } catch (err) {
      return null;
    }
  }

  static Future<List<Repo>> fetchRepos({required String username}) async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.GET,
          route: "$username/repos");

      return Repo.convertToList(response);
    } catch (err) {
      return [];
    }
  }
}
