import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_1/providers/item_provider.dart';
import 'package:provider/provider.dart';
import 'package:test_1/database/database_control.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//todo conver this entire page to stateful widget.get data formo add_itemscreen

class ListDisplay extends StatelessWidget {
  const ListDisplay({Key? key}) : super(key: key);

  void _floatingActionButtonOnClick(BuildContext context) async {
    final item = await Navigator.pushNamed(context, '/add_item_screen');
    context.read<Item>().add(item.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
        ),
        title: const Text('Thing to do'),
        actions: const [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: const ToDoItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _floatingActionButtonOnClick(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ToDoItems extends StatefulWidget {
  const ToDoItems({Key? key}) : super(key: key);

  @override
  State<ToDoItems> createState() => _ToDoItemsState();
}

class _ToDoItemsState extends State<ToDoItems> {
  @override
  void initState() {
    super.initState();
    refreshFromDB();
  }

  Future refreshFromDB() async {
    context.read<Item>().initList(
          await DatabaseHelper.instance.getAllItems(),
        );
    print("refreshFromDB: initList");
  }

  SizedBox insideCardView(int i) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[300],
            child: Text(
              context.watch<Item>().itemList[i].getItemName()[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          title: Text(context.watch<Item>().itemList[i].getItemName()),
        ),
      ),
    );
  }

  Slidable slidableList(int i) {
    return Slidable(
      key: ValueKey(i),
      endActionPane: ActionPane(motion: const BehindMotion(), children: [
        SlidableAction(
          onPressed: ((_) =>
              {context.read<Item>().remove(i), print('delete : $i')}),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        )
      ]),
      child: insideCardView(i),
    );
  }

  ListView ListViewDisplay() {
    return ListView.builder(
      itemCount: context.watch<Item>().itemList.length,
      itemBuilder: (context, i) {
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Theme.of(context).colorScheme.surfaceVariant,
            elevation: 10,
            child: slidableList(i));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: ListViewDisplay(),
    );
  }
}
