import 'package:flutter/material.dart';
import 'package:task_manager_v1/component/sidebarItems.dart';
import 'package:task_manager_v1/state/store.dart';
import 'package:task_manager_v1/state/actions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String currentvalue = "theme";
    MaterialColor currentTheme = store.state.themeColor;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.settings),
            SizedBox(
              width: 10,
            ),
            Text("Settings")
          ],
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            child: SettingsItem(
                leading: Icon(
                  Icons.palette,
                  color: store.state.themeColor,
                ),
                title: "Theme"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    content: DropdownButton(
                  elevation: 8,
                  value: currentTheme,
                  items: const [
                    DropdownMenuItem(
                      value: Colors.blueGrey,
                      child: Text('Blue Grey'),
                    ),
                    DropdownMenuItem(
                      value: Colors.red,
                      child: Text(
                        'Red',
                      ),
                    ),
                    DropdownMenuItem(
                      value: Colors.brown,
                      child: Text('Brown'),
                    ),
                  ],
                  onChanged: (value) async {
                    store.dispatch(SetTheme(themeColor: value!));
                    if (value == Colors.blueGrey) {
                      setState(() {
                        currentvalue = "Blue Grey";
                      });
                    } else if (value == Colors.red) {
                      setState(() {
                        currentvalue = "Red";
                      });
                    } else if (value == Colors.brown) {
                      setState(() {
                        currentvalue = "Brown";
                      });
                    }
                    Navigator.pop(context);
                  },
                )),
              );
            },
          )
        ],
      ),
    );
  }
}
