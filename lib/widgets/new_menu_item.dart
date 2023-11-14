import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewMenuItem extends StatefulWidget {
  const NewMenuItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewMenuItemState();
  }
}

class _NewMenuItemState extends State<NewMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu Item'),
      ),
      // Add Form
    );
  }
}
