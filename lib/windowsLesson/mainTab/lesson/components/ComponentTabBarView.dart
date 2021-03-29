import 'package:flutter/material.dart';

class ComponentTabBarView extends StatefulWidget {
  final int caseTabBarView;
  final Widget body;
  final TabController tabController;

  ComponentTabBarView(
      {Key key, this.caseTabBarView, this.body, this.tabController})
      : super(key: key);

  @override
  _ComponentTabBarViewState createState() => _ComponentTabBarViewState();
}

Widget _textBody(
        String text, double sizeText, FontWeight weightText, Color colorText) =>
    Text(
      text,
      style: TextStyle(
        fontSize: sizeText,
        fontWeight: weightText,
        color: colorText,
      ),
    );

class _ComponentTabBarViewState extends State<ComponentTabBarView> {
  @override
  Widget build(BuildContext context) {
    Widget _buttonController(String textButton, double sizeText,
            FontWeight weightText, Color colorText, bool isNext) =>
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
            ),
            child: _textBody(textButton, sizeText, weightText, colorText),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                if (isNext) {
                  widget.tabController
                      .animateTo((widget.tabController.index + 1));
                } else {
                  widget.tabController
                      .animateTo((widget.tabController.index - 1));
                }
              });
            });
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              Divider(
                height: 2.0,
                thickness: 1.0,
                color: Colors.grey,
              ),
              widget.body,
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        alignment: (widget.caseTabBarView == 0)
            ? Alignment.bottomLeft
            : ((widget.caseTabBarView == 2)
                ? Alignment.bottomRight
                : Alignment.bottomCenter),
        child: (widget.caseTabBarView == 0)
            ? _buttonController(
                "ATRAS", 20.0, FontWeight.w900, Colors.blue[400], false)
            : ((widget.caseTabBarView == 1)
                ? () {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonController("ATRAS", 20.0, FontWeight.w900,
                            Colors.blue[400], false),
                        _buttonController("SIGUIENTE", 20.0, FontWeight.w900,
                            Colors.blue[400], true)
                      ],
                    );
                  }()
                : _buttonController("SIGUIENTE", 20.0, FontWeight.w900,
                    Colors.blue[400], true)),
      ),
    );
  }
}
