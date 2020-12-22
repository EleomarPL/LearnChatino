import 'package:flutter/material.dart';
import 'BackgroundWindow.dart';
import 'FormRegister.dart';

class MainWindow extends StatefulWidget {
  @override
  _MainWindowState createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Crear cuenta'),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundWindow(),
            Opacity(
              opacity: 0.7,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black,
              ),
            ),
            ListView(
              padding: EdgeInsets.all(15.0),
              children: [
                Column(
                  children: [
                    FormRegister(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
