import 'package:flutter/foundation.dart';
import 'package:git_search/models/repo.dart';
import 'package:git_search/utils/view.dart';

import '../interfaces/user.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? searchUser;
  String? userName;
  List<Repo> userRepoList = [];
  List<Repo> searchList = [];

  Future<User?> fetchUser({required String userName}) async {
    searchUser = await UserInterface.fetchUser(username: userName);

    notifyListeners();

    return searchUser;
  }

  Future<List<Repo>> fetchRepositories({required String userName}) async {
    if(userRepoList.isNotEmpty){
      userRepoList.clear();
    }

    final data = await UserInterface.fetchRepos(username: userName);
    userRepoList.clear();
    searchList.clear();
    userRepoList.addAll(data);
    searchList.addAll(userRepoList);
    notifyListeners();

    return userRepoList;
  }

  setUser(String name){
    userName=name;
    notifyListeners();
  }

  Future<void> searchRepo({String? value})async{
  if(await ViewUtils.isInternetConnected()){
    searchList = userRepoList.where((repo) {
      var rName = repo.name.toLowerCase();
      return rName.contains(value as Pattern) ;
    }).toList();

      notifyListeners();


  }

  }

  Future<void> fetchSearch(String userName)async {
    fetchUser(userName: userName);
    fetchRepositories(userName: userName);
    setUser(userName);
  }
}
