import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store_management/models/firestore.dart';
import 'package:store_management/models/sql_helper.dart';
import 'package:store_management/screens/item_code.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final firestore = FireStore();
  String _catagory = '';
  String _quantity = '';
  String _measurment = '';
  String _name = '';
  String? _local;
  bool readOnlyQuantity = true;
  bool readOnlyMeasurment = true;

  _updateCatagory(String catagory) {
    setState(() {
      _catagory = catagory;
    });
  }

  _updateName(String name) {
    _name = name;
  }

  _updateLocation(local) {
    _local = local;
  }

  _updateQuantity(String quantity) {
    setState(() {
      if (quantity == 'Others') {
        readOnlyQuantity = false;
      } else {
        readOnlyQuantity = true;
      }
      _quantity = quantity;
    });
  }

  _updateMeasurment(String measurement) {
    setState(() {
      if (measurement == 'Others') {
        readOnlyMeasurment = false;
      } else {
        readOnlyMeasurment = true;
      }
      _measurment = measurement;
    });
  }

  _push(route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent[100],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Add Items to Store',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.purple[500],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.purple[500],
                              ),
                              value: _catagory,
                              onChanged: (value) {
                                _updateCatagory(value!);
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: '',
                                  child: Text('Select Catagory'),
                                ),
                                DropdownMenuItem(
                                  value: 'Electronics',
                                  child: Text('Electronics'),
                                ),
                                DropdownMenuItem(
                                  value: 'Furniture',
                                  child: Text('Furniture'),
                                ),
                                DropdownMenuItem(
                                  value: 'Metal',
                                  child: Text('Metal'),
                                ),
                                DropdownMenuItem(
                                  value: 'Stationary',
                                  child: Text('Stationary'),
                                ),
                                DropdownMenuItem(
                                  value: 'Others',
                                  child: Text('Others'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter item name',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.list),
                          ),
                          onChanged: (value) => _updateName(value),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.purple[500],
                                    ),
                                    value: _quantity,
                                    onChanged: (value) {
                                      _updateQuantity(value!);
                                    },
                                    items: const [
                                      DropdownMenuItem(
                                        value: '',
                                        child: Text('Select Quantity'),
                                      ),
                                      DropdownMenuItem(
                                        value: '1',
                                        child: Text('1'),
                                      ),
                                      DropdownMenuItem(
                                        value: '2',
                                        child: Text('2'),
                                      ),
                                      DropdownMenuItem(
                                        value: '3',
                                        child: Text('3'),
                                      ),
                                      DropdownMenuItem(
                                        value: '4',
                                        child: Text('4'),
                                      ),
                                      DropdownMenuItem(
                                        value: '5',
                                        child: Text('5'),
                                      ),
                                      DropdownMenuItem(
                                        value: '6',
                                        child: Text('6'),
                                      ),
                                      DropdownMenuItem(
                                        value: '7',
                                        child: Text('7'),
                                      ),
                                      DropdownMenuItem(
                                        value: '8',
                                        child: Text('8'),
                                      ),
                                      DropdownMenuItem(
                                        value: '9',
                                        child: Text('9'),
                                      ),
                                      DropdownMenuItem(
                                        value: '10',
                                        child: Text('10'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Others',
                                        child: Text('Others'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.purple[500],
                                    ),
                                    value: _measurment,
                                    onChanged: (value) {
                                      _updateMeasurment(value!);
                                    },
                                    items: const [
                                      DropdownMenuItem(
                                        value: '',
                                        child: Text('Select measurment'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'units',
                                        child: Text('units'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'dozens',
                                        child: Text('dozens'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Meter',
                                        child: Text('Meter'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Killograms',
                                        child: Text('Killograms'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Liters',
                                        child: Text('Liters'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Others',
                                        child: Text('Others'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'if selected Others',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(
                                      Icons.production_quantity_limits),
                                ),
                                keyboardType: TextInputType.number,
                                readOnly: readOnlyQuantity,
                                onChanged: (value) => _updateQuantity(value),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'if selected Others',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(Icons.four_mp_rounded),
                                ),
                                keyboardType: TextInputType.number,
                                readOnly: readOnlyMeasurment,
                                onChanged: (value) => _updateMeasurment(value),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'LocalLocation(optional)',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.add_location),
                          ),
                          onChanged: (value) => _updateLocation(value),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _addToStore();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Book Now',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validate() {
    if (_catagory.isEmpty ||
        _name.isEmpty ||
        _quantity.isEmpty ||
        _measurment.isEmpty ||
        _quantity == 'Others' ||
        _measurment == 'Others') {
      SnackBar snackBar = const SnackBar(
          content: Text('fill the blanks or choose from alternatives'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  void _addToStore() {
    if (validate()) {
      if (kIsWeb) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  contentPadding: const EdgeInsets.all(10),
                  title: const Text('Alert!!'),
                  content: const Text('your data will be saved on cloud'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        _saveOnCloud();
                      },
                      child: const Text('Confirm'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: const Text('cancel'),
                    ),
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  contentPadding: const EdgeInsets.all(10),
                  title: const Text('Add Items'),
                  content: const Text('where you want to save this data'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        _saveLocally();
                      },
                      child: const Text('Locall'),
                    ),
                    TextButton(
                        onPressed: () async {
                          _saveOnCloud();
                        },
                        child: const Text('Cloud firestore')),
                  ],
                ));
      }
    }
  }

  void _saveLocally() async {
    Navigator.of(context).pop();
   var result= await SQLHelper.createItem(
        _name, _catagory, _quantity, _measurment, _local);
        if (result != 0) {
      _push(ItemCode(
        code: result,
        name: _name,
        quantity: _quantity,
        measurement: _measurment,
        localAddress: _local,
      ));
    }
  }

  void _saveOnCloud() async {
    Navigator.of(context).pop();

    var result = await firestore.updateItemData(
        _name, _catagory, _quantity, _measurment, _local);
    if (result != null) {
      _push(ItemCode(
        code: result,
        name: _name,
        quantity: _quantity,
        measurement: _measurment,
        localAddress: _local,
      ));
    }
  }
}
