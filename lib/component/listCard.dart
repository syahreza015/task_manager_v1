import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_v1/state/actions.dart';
import 'package:task_manager_v1/state/store.dart';

class ListCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const ListCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.blueGrey,
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.arrow_right),
        ),
        title: Text("${data['title']}"),
        subtitle: Text("${data['details']}"),
        trailing: IconButton(
          onPressed: () {
            void deleteData(Database database, dynamic id) async {
              await database.rawQuery("DELETE FROM task WHERE id = $id");
              List<Map<String, dynamic>> newData =
                  await database.rawQuery("SELECT * FROM task");
              store.dispatch(SetData(data: newData));
            }

            deleteData(store.state.database!, data['id']);
            final snackBar = SnackBar(
              backgroundColor: store.state.themeColor,
              behavior: SnackBarBehavior.floating,
              content: const Text(
                'Data Dihapus',
                style: TextStyle(color: Colors.white),
              ),
              dismissDirection: DismissDirection.endToStart,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          icon: StoreConnector<AppState, MaterialColor>(
            converter: (store) => store.state.themeColor,
            builder: (context, vm) => Icon(
              Icons.delete,
              color: store.state.themeColor,
            ),
          ),
          color: store.state.themeColor,
        ),
      ),
    );
  }
}
