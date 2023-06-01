import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smartbin_alert/models/user_model.dart';
import 'package:smartbin_alert/store/bindata_store.dart';
import 'package:smartbin_alert/utils/colors.dart';
import 'package:smartbin_alert/views/signup_screen.dart';
import 'package:smartbin_alert/widgets/home_card_widget.dart';
import 'package:smartbin_alert/widgets/request_sample_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final BinDataStore data = BinDataStore();
  late final UserModal user;

  @override
  void initState() {
    super.initState();
    data.getBinsData();
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
            // Sign out button
            IconButton(
              onPressed: () async {
                await SignupScreenState().signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: secondaryColor),
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
        body: TabBarView(
          children: <Widget>[
            // Dashboard Tab
            Observer(
                builder: (_) => data.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                          backgroundColor: tertiaryColor,
                        ),
                      )
                    : data.isError
                        ? Center(
                            child: Text(data.errorMessage),
                          )
                        : ListView.builder(
                            itemCount: data.bins.length,
                            itemBuilder: (context, index) {
                              return HomeCardWidget(
                                bin: data.bins[index],
                              );
                            },
                          )),
            // Request Tab
            Column(
              children: [
                const RequestSampleCard(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ElevatedButton(
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(8.0),
                      ),
                      onPressed: () {
                        openBottomSheet(context);
                      },
                      child: const Text(
                        "Create Request",
                        style: TextStyle(fontSize: 18.0, color: tertiaryColor),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> openBottomSheet(BuildContext context) async {
    String? selectedOption; // Variable to store the selected option

    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 400,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // DropdownButton
                  DropdownButton<String>(
                    value: selectedOption ?? 'Select Bin ID',
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue;
                      });
                      Navigator.pop(context); // Close the bottom sheet
                      if (selectedOption != null &&
                          selectedOption != 'Select Bin ID') {
                        // Show the thank you dialog
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Request Submit!'),
                              content:
                                  Text('Your selected Bin: $selectedOption'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    items: <String>[
                      'Select Bin ID',
                      'B-1011',
                      'B-1012',
                      'B-1013'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/bin.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
