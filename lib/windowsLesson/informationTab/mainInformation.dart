import 'package:flutter/material.dart';

class MainInformation extends StatefulWidget {
  MainInformation({Key key}) : super(key: key);

  @override
  _MainInformationState createState() => _MainInformationState();
}

class _MainInformationState extends State<MainInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("class information"),
    );
  }
}
