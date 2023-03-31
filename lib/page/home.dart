import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:task_manager_v1/component/detailsForm.dart';
import 'package:task_manager_v1/component/inputForm.dart';
import 'package:task_manager_v1/component/listCard.dart';
import 'package:task_manager_v1/component/sideBar.dart';
import 'package:task_manager_v1/state/actions.dart';
import 'package:task_manager_v1/state/store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.home),
            SizedBox(
              width: 10,
            ),
            Text("Home")
          ],
        ),
      ),
      body: SizedBox(
        child: StoreConnector<AppState, List<Map<String, dynamic>>>(
          converter: (store) => store.state.data,
          builder: (context, vm) => ListView.builder(
            itemCount: store.state.data.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  store.dispatch(SetCurrentData(currentData: store.state.data[index]));
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => DetailsForm(
                      data: store.state.currentData,
                    ),
                  ).then((value) {
                    if (store.state.isEditing == true) {
                      store.dispatch(SetEditingStatus());
                    }
                  });
                },
                child: ListCard(
                  data: store.state.data[index],
                )),
          ),
        ),
      ),
      bottomNavigationBar: StoreConnector<AppState, MaterialColor>(
        converter: (store) => store.state.themeColor,
        builder: (context, vm) => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          color: store.state.themeColor,
          child: Container(
            height: 50,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            isScrollControlled: true,
            context: context,
            builder: (context) => const InputForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
