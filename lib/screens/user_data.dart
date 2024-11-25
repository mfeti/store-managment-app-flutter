import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_management/models/firestore.dart';
import 'package:store_management/models/sql_helper.dart';
import 'package:store_management/models/update.dart';

class UserData extends StatefulWidget {
  final bool Local;
  const UserData({super.key, required this.Local});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  List<bool> _isExpanded = [];
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;
  final firestore = FireStore();
  String _store = '';
  // This function is used to fetch all data from the database
  void _refreshItems() async {
    final data = await SQLHelper.getItems();
    _isExpanded = List.filled(data.length, false);
    setState(() {
      _items = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _store = widget.Local ? 'SQLite Database' : 'Cloud FireStore';
    _isLoading = widget.Local;
    _refreshItems(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) => Card(
        color: Colors.orange[200],
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListTile(
                title: Text(
                  _items[index]['Name'],
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                // subtitle: Text(_journals[index]['Name']),
                trailing: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ExpandIcon(
                              isExpanded: _isExpanded[index],
                              color: Colors.white,
                              expandedColor: Colors.black,
                              onPressed: (bool isExpanded) {
                                setState(() {
                                  _isExpanded[index] = !isExpanded;
                                });
                              })
                        ],
                      ),
                    ),
                  ],
                )),
            if (_isExpanded[index])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: Text(
                      _items[index]['Catagory'],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Text(_items[index]['Quantity']),
                        const Text(' '),
                        Text(_items[index]['Measurment']),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(_items[index]['localArea'] ?? ''),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showForm(_items[index]['ID']);
                          }),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteItem(_items[index]['ID'].toString());
                          }),
                    ],
                  )
                ],
              ),
          ],
        ),
      ),
    );
    var strem = StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Items').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        _isLoading = false;
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  color: Colors.orange[200],
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                            data['name'],
                            style: const TextStyle(
                                fontSize: 20, color: Colors.green),
                          ),
                          // subtitle: Text(_journals[index]['Name']),
                          trailing: Column(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ExpandIcon(
                                        isExpanded: false, //_isExpanded[index],
                                        color: Colors.white,
                                        expandedColor: Colors.black,
                                        onPressed: (bool isExpanded) {
                                          setState(() {
                                            // _isExpanded[index] = !isExpanded;
                                          });
                                        })
                                  ],
                                ),
                              ),
                            ],
                          )),
                      // if (_isExpanded[index])
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.only(left: 10, bottom: 15),
                      //         child: Text(
                      //           data['Catagory'],
                      //           style: const TextStyle(fontSize: 15),
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(left: 15),
                      //         child: Row(
                      //           children: [
                      //             Text(data['Quantity']),
                      //             const Text(' '),
                      //             Text(data['Measurment']),
                      //             const SizedBox(
                      //               width: 30,
                      //             ),
                      //             Text(data['localArea'] ?? ''),
                      //           ],
                      //         ),
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           IconButton(
                      //               icon: const Icon(Icons.edit),
                      //               onPressed: () {
                      //                 _showForm(data['ID']);
                      //               }),
                      //           IconButton(
                      //               icon: const Icon(Icons.delete),
                      //               onPressed: () {
                      //                 _deleteItem(data['ID'].toString());
                      //               }),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                    ],
                  ),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Data from $_store'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(child: widget.Local ? listView : strem));
  }

  // Delete an item
  void _deleteItem(String id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted an Item!'),
    ));
    _refreshItems();
  }

  // Update an existing journal
  // Future<void> _updateItem(int id) async {
  //   // await SQLHelper.updateItem(id);
  //   _refreshItems();
  // }

  _showForm(int id) {
    showDialog(context: context, builder: (context) => const Update());
  }
}









// scaffold(
//         body: _isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : ListView.builder(
//                 itemCount: _items.length,
//                 itemBuilder: (context, index) => Card(
//                   color: Colors.orange[200],
//                   margin: const EdgeInsets.all(15),
//                   child: Column(
//                     children: [
//                       ListTile(
//                           title: Text(
//                             _items[index]['Name'],
//                             style: const TextStyle(
//                                 fontSize: 20, color: Colors.green),
//                           ),
//                           // subtitle: Text(_journals[index]['Name']),
//                           trailing: Column(
//                             children: [
//                               SizedBox(
//                                 width: 150,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     ExpandIcon(
//                                         isExpanded: _isExpanded[index],
//                                         color: Colors.white,
//                                         expandedColor: Colors.black,
//                                         onPressed: (bool isExpanded) {
//                                           setState(() {
//                                             _isExpanded[index] = !isExpanded;
//                                           });
//                                         })
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           )),
//                       if (_isExpanded[index])
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 10, bottom: 15),
//                               child: Text(
//                                 _items[index]['Catagory'],
//                                 style: const TextStyle(fontSize: 15),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 15),
//                               child: Row(
//                                 children: [
//                                   Text(_items[index]['Quantity']),
//                                   const Text(' '),
//                                   Text(_items[index]['Measurment']),
//                                   const SizedBox(
//                                     width: 30,
//                                   ),
//                                   Text(_items[index]['localArea'] ?? ''),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                     icon: const Icon(Icons.edit),
//                                     onPressed: () {
//                                       _showForm(_items[index]['ID']);
//                                     }),
//                                 IconButton(
//                                     icon: const Icon(Icons.delete),
//                                     onPressed: () {
//                                       _deleteItem(
//                                           _items[index]['ID'].toString());
//                                     }),
//                               ],
//                             )
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//               ));
//   }
