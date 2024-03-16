import 'package:flutter/material.dart';
import 'package:git_search/components/button.dart';
import 'package:git_search/components/custom_textfield.dart';
import 'package:git_search/providers/user.dart';
import 'package:git_search/screens/search.dart';
import 'package:git_search/utils/text.dart';
import 'package:git_search/utils/theme.dart';
import 'package:git_search/utils/view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const HomeBgScreen(
      body: UserSearchInput(),
    );
  }
}

class HomeBgScreen extends StatelessWidget {
  final Widget body;
  final String? image;

  const HomeBgScreen({super.key, required this.body, this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.withOpacity(.35),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
        title: const Text(
          textUserSearch,
          style: appbarTextStyle,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/bg.jpeg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          body
        ],
      ),
    );
  }
}

class UserSearchInput extends StatefulWidget {
  const UserSearchInput({super.key});

  @override
  State<UserSearchInput> createState() => _UserSearchInputState();
}

class _UserSearchInputState extends State<UserSearchInput> {
  final searchController = TextEditingController();
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const GitImageWidget(),
            SizedBox(
              height: fullHeight(context) * .1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomTextField(
                      controller: searchController,
                      validator: (value) => value!.isEmpty ? errorText : null,
                      hintText: textEnterUserName),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    title: textSearch,
                    loading: _loading,
                    width: 150,
                    onPressed: () async {
                      if (await ViewUtils.isInternetConnected()) {
                        if (_formKey.currentState!.validate()) {
                          search();
                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void search() {
    setState(() {
      _loading = true;
    });
    Provider.of<UserProvider>(context, listen: false)
        .fetchSearch(searchController.text)
        .then((value) => Navigator.pushNamed(context, SearchScreen.routeName));
    setState(() {
      _loading = false;
    });
  }
}

class GitImageWidget extends StatelessWidget {
  const GitImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fullHeight(context) / 3,
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/gitbg.png"), fit: BoxFit.contain)),
    );
  }
}
