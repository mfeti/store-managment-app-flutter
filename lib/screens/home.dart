import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store_management/models/auth.dart';
import 'package:store_management/models/firestore.dart';
import 'package:store_management/screens/add_items.dart';
import 'package:store_management/screens/messages.dart';
import 'package:store_management/screens/request_items.dart';
import 'package:store_management/screens/settings.dart';
import 'package:store_management/screens/user_data.dart';
import 'package:store_management/screens/utlized.dart';
import 'package:quickalert/quickalert.dart';

class Home extends StatefulWidget {
  final String uid;

  const Home({super.key, required this.uid});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firestore = FireStore();
  final _mAuth = Auth();
  var name = 'User Name';
  var email = 'User Email';
  int _selectedIndex = 1;
  static const List _tabPages = [
    Utilized(),
    AddItems(),
    Messages(),
    Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _push(context, route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: firestore.getUserData(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            name = data.get('Name');
            email = data.get('Email');
          }
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(name),
                    accountEmail: Text(email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        name.substring(0, 2),
                        style: const TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text("User Data"),
                    onTap: () {
                      (kIsWeb)
                          ? _push(
                              context,
                              const UserData(
                                Local: false,
                              ))
                          : showDialog(
                              context: context,
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AlertDialog(
                                      title: const Text('UserData'),
                                      content: const Text(
                                          'select which data to see'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _push(
                                                  context,
                                                  const UserData(
                                                    Local: true,
                                                  ));
                                            },
                                            child: const Text('Local')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _push(
                                                  context,
                                                  const UserData(
                                                    Local: false,
                                                  ));
                                            },
                                            child:
                                                const Text('Cloud Firestore')),
                                      ],
                                    ),
                                  ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.request_page),
                    title: const Text("Request Items"),
                    onTap: () {
                      _push(context, const RequestItems());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {
                      _push(context, const Setting());
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text("Store Management"),
              backgroundColor: Colors.blue[400],
              elevation: 0,
              actions: [
                TextButton.icon(
                    onPressed: () {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        text: 'Do you want to logout',
                        confirmBtnText: 'Yes',
                        cancelBtnText: 'No',
                        confirmBtnColor: Colors.green,
                        onConfirmBtnTap: () => _mAuth.signOut(),
                      );
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.purple[500],
                    ),
                    label: Text('Logout',
                        style: TextStyle(
                          color: Colors.purple[500],
                        )))
              ],
            ),
            body: Center(
              child: _tabPages[_selectedIndex],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.blue[500],
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.remove_circle_outlined,
                      color: Colors.white,
                    ),
                    label: 'Utilize Item'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_to_photos, color: Colors.white),
                    label: 'Add Items'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message, color: Colors.white),
                    label: 'Messages',
                    backgroundColor: Colors.white),
              ],
            ),
          );
        });
  }
}
