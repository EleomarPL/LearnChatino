import 'package:flutter/material.dart';

import 'ComponentTabBarView.dart';

// ignore: must_be_immutable
class ComponentBody extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  final int lengthTabBar;
  List<String> listTabBar;
  List<Widget> listTabBarView;
  ComponentBody(
      {Key key,
      this.numLevel,
      this.numLesson,
      this.listTabBar,
      this.listTabBarView,
      this.lengthTabBar})
      : super(key: key);

  @override
  _ComponentBodyState createState() => _ComponentBodyState();
}

Widget _textTabBar(String text) => Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w900,
      ),
    );

class _ComponentBodyState extends State<ComponentBody>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Widget _textBody(String text, double sizeText, FontWeight weightText,
          Color colorText) =>
      Text(
        text,
        style: TextStyle(
          fontSize: sizeText,
          fontWeight: weightText,
          color: colorText,
        ),
      );
  Widget _buttonController(String textButton, double sizeText,
          FontWeight weightText, Color colorText, bool isNext) =>
      RaisedButton(
          elevation: 0,
          color: Colors.white,
          child: _textBody(textButton, sizeText, weightText, colorText),
          onPressed: () {
            setState(() {
              if (isNext) {
                _tabController.animateTo((_tabController.index + 1));
                _tabController.indexIsChanging;
              } else {
                _tabController.animateTo((_tabController.index - 1));
              }
            });
          });
  Widget containerTabBarView(int caseTabBarView, Widget bodyWidget) => Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            bodyWidget,
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          alignment: (caseTabBarView == 0)
              ? Alignment.bottomLeft
              : ((caseTabBarView == 2)
                  ? Alignment.bottomRight
                  : Alignment.bottomCenter),
          child: (caseTabBarView == 0)
              ? _buttonController(
                  "ATRAS", 20.0, FontWeight.w900, Colors.blue[400], false)
              : ((caseTabBarView == 1)
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

  @override
  void initState() {
    _tabController = TabController(
        length: widget.lengthTabBar, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listTab = widget.listTabBar.map((String titleBar) {
      return _textTabBar(titleBar);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: TabBar(
          controller: _tabController,
          labelColor: Colors.red[600],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.white,
          labelPadding: const EdgeInsets.only(right: 8.0, left: 8.0),
          tabs: listTab,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.listTabBarView.map((Widget child) {
          /*
            attribute CaseTabBarView from ComponentTabBarView
            ** 0 only the back (ATRAS) bottom
            ** 1 back (ATRAS) and next (SIGUIENTE) bottom
            ** 2 only the next (SIGUIENTE) bottom
          */
          int caseTabView = (widget.listTabBarView.indexOf(child) == 0)
              ? 2
              : (((widget.lengthTabBar - 1) ==
                      widget.listTabBarView.indexOf(child))
                  ? 0
                  : 1);
          return ComponentTabBarView(
            caseTabBarView: caseTabView,
            body: child,
            tabController: _tabController,
          );
        }).toList(),
      ),
    );
  }
}
