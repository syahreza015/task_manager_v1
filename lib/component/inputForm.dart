import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_v1/state/actions.dart';
import 'package:task_manager_v1/state/store.dart';

class InputForm extends StatelessWidget {
  const InputForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController desController = TextEditingController();
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
              controller: titleController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.black)),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              autocorrect: false,
              maxLines: 7,
              controller: desController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Description",
                  labelStyle: TextStyle(color: Colors.black)),
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
                  void insertData(
                      Database database, String title, String description) async {
                    await database.rawQuery(
                        "INSERT INTO task (title, details) VALUES ('$title', '$description')");
                    List<Map<String, dynamic>> newData =
                        await database.rawQuery("SELECT * FROM task");
                    store.dispatch(SetData(data: newData));
                  }

                  insertData(
                      store.state.database!, titleController.text, desController.text);
                  final snackBar = SnackBar(
                    backgroundColor: store.state.themeColor,
                    behavior: SnackBarBehavior.floating,
                    content: const Text(
                      'Data Ditambahkan',
                      style: TextStyle(color: Colors.white),
                    ),
                    dismissDirection: DismissDirection.endToStart,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Add"),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.done)
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
