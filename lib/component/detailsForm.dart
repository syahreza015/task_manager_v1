import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_v1/state/actions.dart';
import 'package:task_manager_v1/state/store.dart';

class DetailsForm extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailsForm({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: "${data['title']}");
    TextEditingController desController =
        TextEditingController(text: "${data['details']}");
    return StoreConnector<AppState, MaterialColor>(
      converter: (store) => store.state.themeColor,
      builder: (context, vm) => Container(
        decoration: BoxDecoration(
          color: store.state.themeColor,
        ),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            top: 8,
            left: 5,
            right: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autocorrect: false,
              enabled: store.state.isEditing,
              controller: titleController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              autocorrect: false,
              enabled: store.state.isEditing,
              maxLines: 8,
              controller: desController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: store.state.themeColor),
                onPressed: () {
                  if (store.state.isEditing == true) {
                    void updateData(Database database, String title, String details,
                        dynamic id) async {
                      await database.rawQuery(
                          "UPDATE task SET title='$title', details='$details' WHERE id=$id");
                      List<Map<String, dynamic>> newData =
                          await database.rawQuery("SELECT * FROM task");

                      store.dispatch(SetData(data: newData));
                    }

                    final snackBar = SnackBar(
                      backgroundColor: store.state.themeColor,
                      behavior: SnackBarBehavior.floating,
                      content: const Text(
                        'Saved',
                        style: TextStyle(color: Colors.white),
                      ),
                      dismissDirection: DismissDirection.endToStart,
                    );
                    updateData(store.state.database!, titleController.text,
                        desController.text, data['id']);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    store.dispatch(SetEditingStatus());
                  } else if (store.state.isEditing == false) {
                    store.dispatch(SetEditingStatus());
                    debugPrint("editing");
                  }
                },
                child: store.state.isEditing == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Save"),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.done)
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Edit"),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.edit)
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
