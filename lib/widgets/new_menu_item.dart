import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:restaurant_app/models/menu_item.dart';
import 'package:restaurant_app/models/menu_item_type.dart';

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
  var _selectedMenuItemType = MenuItemType.entree;
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
            'type': _selectedMenuItemType,
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
            glutenFree: _selectedIsGlutenFree),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu Item'),
      ),
      // Add Form
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
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
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Price'),
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
                    child: DropdownButtonFormField(
                      value: _selectedMenuItemType,
                      items: [
                        for (final type in MenuItemType.values)
                          DropdownMenuItem(
                            value: type,
                            child: Row(
                              children: [
                                Text(type.name),
                              ],
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
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedIsKids,
                      items: const [
                        DropdownMenuItem(
                          value: false,
                          child: Text('Not Kids'),
                        ),
                        DropdownMenuItem(
                          value: true,
                          child: Text('Is Kids'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedIsKids = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedIsGlutenFree,
                      items: const [
                        DropdownMenuItem(
                          value: false,
                          child: Text('Gluten Free'),
                        ),
                        DropdownMenuItem(
                          value: true,
                          child: Text('Has Gluten'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedIsGlutenFree = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _isSending ? null : _saveMenuItem,
                child: _isSending
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Add Item'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
