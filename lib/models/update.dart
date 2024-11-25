import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  String _catagory = '';
  String _quantity = '';
  String _measurment = '';
  String _name = '';

  _updateCatagory(String catagory) {
    setState(() {
      _catagory = catagory;
    });
  }

  _updateName(String name) {
    _name = name;
  }

  _updateQuantity(String quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  _updateMeasurment(String measurement) {
    setState(() {
      _measurment = measurement;
    });
  }

  // _push(route) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => route),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
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
                'Update to Store',
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _update();
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
    );
  }

  bool validate() {
    if (_catagory.isEmpty ||
        _name.isEmpty ||
        _quantity.isEmpty ||
        _measurment.isEmpty) {
      SnackBar snackBar = const SnackBar(
          content: Text('fill the blanks or choose from alternatives'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  void _update() {}
}
