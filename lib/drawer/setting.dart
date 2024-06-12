import 'package:flutter/material.dart';
import '../constants/themes.dart';
class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  bool? isChecked1 = true;
  bool? isChecked2 = true;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text('My Settings',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(
                Icons.notification_add_rounded,
                size: 40,
                color: kSecondaryColor,
              ),
              title: Text(
                "Notification",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "Notification Mute or Off",
                style: TextStyle(fontSize: 15),
              ),
              trailing: Checkbox(
                tristate: true,
                activeColor: kSecondaryColor,
                value: isChecked1,
                onChanged: (value) {
                  setState(() {
                    isChecked1 = value;
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.auto_mode_sharp,
                size: 40,
                color: kSecondaryColor,
              ),
              title: Text(
                "Auto-Login",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "Allow access without registering your email again",
                style: TextStyle(fontSize: 15),
              ),
              trailing: Checkbox(
                activeColor: kSecondaryColor,
                value: isChecked2,
                onChanged: (value) {
                  setState(() {
                    isChecked2 = value;
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(
                  Icons.password,
                  size: 40,
                  color: kSecondaryColor,
                ),
                title: Text(
                  "Change Password",
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  "you Can Change the passwod from here",
                  style: TextStyle(fontSize: 15),
                ),
                trailing: MaterialButton(onPressed: (){},child: Text("Click here",style: TextStyle(color: Colors.white),),color: kSecondaryColor,)
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(
                  Icons.delete,
                  size: 40,
                  color: kSecondaryColor,
                ),
                title: Text(
                  "Delete Account",
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  "You can delete account from them, but can't restore it again",
                  style: TextStyle(fontSize: 15),
                ),
                trailing: MaterialButton(onPressed: (){

                },child: Text("Click here",style: TextStyle(color: Colors.white),),color: kSecondaryColor,)
            ),
          ),
        ],
      ),
    );
  }
}
