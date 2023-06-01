import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartbin_alert/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late final UserModal user;

  @override
  void initState() {
    super.initState();
    user = UserModal(
      displayName: FirebaseAuth.instance.currentUser!.displayName ?? "",
      email: FirebaseAuth.instance.currentUser!.email ?? "",
      photoURL: FirebaseAuth.instance.currentUser!.photoURL ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hi, ${user.displayName}!'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Dashboard",
                icon: Icon(Icons.dashboard_customize),
              ),
              Tab(
                text: "Request",
                icon: Icon(Icons.pending_actions_outlined),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
