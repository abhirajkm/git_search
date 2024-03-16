import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:git_search/components/custom_textfield.dart';
import 'package:git_search/models/repo.dart';
import 'package:git_search/providers/user.dart';
import 'package:git_search/utils/apploader.dart';
import 'package:git_search/utils/text.dart';
import 'package:git_search/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffadadad),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: CustomAppBar(
            controller: _controller,
            userName: provider.userName,
          )),
      body: TabBarView(
        controller: _controller,
        children: const [ProfileTab(), RepoTab()],
      ),
    );
  }

  fetch() {
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.fetchUser(userName: provider.userName!);
  }
}

class RepoTab extends StatefulWidget {
  const RepoTab({
    super.key,
  });

  @override
  State<RepoTab> createState() => _RepoTabState();
}

class _RepoTabState extends State<RepoTab> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<UserProvider>(builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              CustomTextField(
                onChanged: (val) {
                  value.searchRepo(value: val);
                },
                controller: _searchController,
                hintText: textSearch,
                suffixIcon: const Icon(Icons.search),
              ),
              Column(
                children:
                    value.searchList.map((e) => RepoCard(userRepo: e)).toList(),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class RepoCard extends StatelessWidget {
  final Repo userRepo;
  const RepoCard({
    super.key,
    required this.userRepo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              margin: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                  child: Text(
                userRepo.name[0],
                style: const TextStyle(fontSize: 42.0),
              )),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userRepo.full_name,
                    style: const TextStyle(fontSize: 20.0),
                    maxLines: 12,
                  ),
                  Text("Language : ${userRepo.language}"),
                  Text(
                    "Clone_url : ${userRepo.projectUrl}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  InkWell(
                    onTap: () {
                      _launchUrl();
                    },
                    child: const Text(
                      "Click to Open in Browser ",
                      style: TextStyle(
                          color: Colors.red,
                          wordSpacing: 1.3,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(userRepo.projectUrl);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      final user = value.searchUser;
      return user != null
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 150,
                        backgroundImage: NetworkImage(user.image),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.name,
                      style: profileNameStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.bio,
                      style: bioStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Total Repositories : ${user.repos}",
                      style: repoStyle,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            )
          : const AppLoader();
    });
  }
}

class CustomAppBar extends StatelessWidget {
  final TabController? controller;
  final String? userName;
  const CustomAppBar({super.key, this.controller, this.userName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          )),
      bottom: TabBar(
        controller: controller,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicatorColor: Colors.black,
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white, width: 3.0),
          ),
        ),
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(
            text: profileTab,
          ),
          Tab(
            text: repository,
          ),
        ],
      ),
      title: Text(
        userName!.toUpperCase(),
        style: appbarTextStyle,
      ),
    );
  }
}
