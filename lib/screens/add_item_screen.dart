import 'package:flutter/material.dart';
import 'package:test_1/database/database_control.dart';
import 'package:test_1/database/items.dart';
import 'package:test_1/providers/item_provider.dart';

class AddItem extends StatelessWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a thing to do'),
        actions: [
          MaterialButton(
            onPressed: () {
              controller.text.isEmpty
                  ? null
                  : {
                      Navigator.pop(context, controller.text),
                    };
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          controller: controller,
        ),
      ),
    );
  }
}
