import 'package:flutter/material.dart';
import 'package:task_manager_v1/state/store.dart';

class SideBarItem extends StatelessWidget {
  final Widget leading;
  final String title;
  const SideBarItem({super.key, required this.leading, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: store.state.themeColor,
      child: ListTile(
        leading: leading,
        title: Text(title),
        trailing: Icon(
          Icons.arrow_right,
          color: store.state.themeColor,
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final Widget leading;
  final String title;
  const SettingsItem({super.key, required this.leading, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: store.state.themeColor,
      child: ListTile(
          leading: leading, title: Text(title), trailing: const Icon(Icons.arrow_right)),
    );
  }
}
