import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:task_manager_v1/component/sidebarItems.dart';
import 'package:task_manager_v1/state/store.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(top: 23),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                children: [
                  StoreConnector<AppState, MaterialColor>(
                    converter: (store) => store.state.themeColor,
                    builder: (context, vm) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                      height: 57,
                      decoration: BoxDecoration(
                          color: store.state.themeColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Task Manager",
                                  style: TextStyle(color: Colors.white, fontSize: 17),
                                ),
                                Text(
                                  "Version 1.0.0",
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                            const Icon(
                              Icons.book,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/settings");
                    },
                    child: StoreConnector<AppState, MaterialColor>(
                      converter: (store) => store.state.themeColor,
                      builder: (context, vm) => SideBarItem(
                          leading: Icon(
                            Icons.settings,
                            color: store.state.themeColor,
                          ),
                          title: "Settings"),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationIcon: StoreConnector<AppState, MaterialColor>(
                      converter: (store) => store.state.themeColor,
                      builder: (context, vm) => Icon(
                        Icons.book,
                        color: store.state.themeColor,
                      ),
                    ),
                    applicationName: "Task Manager",
                    applicationVersion: "Version 1.0.0",
                    applicationLegalese:
                        "Copyright 2023, Developed by Reza using flutter");
              },
              child: StoreConnector<AppState, MaterialColor>(
                converter: (store) => store.state.themeColor,
                builder: (context, vm) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  height: 52,
                  decoration: BoxDecoration(
                      color: store.state.themeColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Copyright 2023",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            "Made with flutter",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
