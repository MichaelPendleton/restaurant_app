import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:restaurant_app/models/menu_item.dart';
import 'package:restaurant_app/models/menu_item_type.dart';
import 'package:restaurant_app/data/types.dart';

class NewMenuItem extends StatefulWidget {
  const NewMenuItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewMenuItemState();
  }
}

class _NewMenuItemState extends State<NewMenuItem> {
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;
  var _enteredName = '';
  var _enteredPrice = 0.0;
  var _selectedMenuItemType = types[MenuItemTypes.entree]!;
  var _selectedIsKids = false;
  var _selectedIsGlutenFree = false;

  void _saveMenuItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https(
          'csc322-restaurant-app-default-rtdb.firebaseio.com', 'menu.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredName,
            'price': _enteredPrice,
            'type': _selectedMenuItemType.title,
            'isKids': _selectedIsKids,
            'isGlutenFree': _selectedIsGlutenFree,
          },
        ),
      );

      final Map<String, dynamic> resData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
        MenuItem(
          id: resData['name'],
          name: _enteredName,
          price: _enteredPrice,
          type: _selectedMenuItemType,
          isKids: _selectedIsKids,
          glutenFree: _selectedIsGlutenFree,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 163, 163, 211),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    // flex: 2,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 163, 163, 211),
                          ),
                        ),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null ||
                            double.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredPrice = double.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    // flex: 3,
                    child: DropdownButtonFormField(
                      value: _selectedMenuItemType,
                      items: [
                        for (final menuItemType in types.entries)
                          DropdownMenuItem(
                            value: menuItemType.value,
                            child: Text(
                              menuItemType.value.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 163, 163, 211),
                              ),
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedMenuItemType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'For Kids',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 163, 163, 211),
                        ),
                      ),
                      value: _selectedIsKids,
                      onChanged: (newValue) {
                        setState(
                          () {
                            _selectedIsKids = !_selectedIsKids;
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Gluten Free',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 163, 163, 211),
                        ),
                      ),
                      value: _selectedIsGlutenFree,
                      onChanged: (newValue) {
                        setState(
                          () {
                            _selectedIsGlutenFree = !_selectedIsGlutenFree;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 150,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isSending
                      ? null
                      : () {
                          _saveMenuItem();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 160, 197, 172),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 8.0,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    shadowColor: Colors.grey,
                  ),
                  child: _isSending
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Add Item',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
