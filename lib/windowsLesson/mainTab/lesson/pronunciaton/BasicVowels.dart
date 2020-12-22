import 'package:flutter/material.dart';

class BasicVowels extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  BasicVowels({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _BasicVowelsState createState() => _BasicVowelsState();
}

Widget _textTabBar(String text) => Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w900,
      ),
    );

class _BasicVowelsState extends State<BasicVowels>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
    _tabController.addListener(
      () {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          labelPadding: const EdgeInsets.all(8.0),
          tabs: [
            Tab(child: _textTabBar("aa")),
            Tab(child: _textTabBar("ee")),
            Tab(child: _textTabBar("ii")),
            Tab(child: _textTabBar("oo")),
            Tab(child: _textTabBar("uu")),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              Divider(
                color: Colors.black,
              ),
              Text('a'),
              RaisedButton(
                child: Text('siguiente'),
                onPressed: () {
                  setState(() {
                    setState(() {
                      _tabController.indexIsChanging;
                      _tabController.index = _tabController.index++;
                    });
                    //print(_tabController.previousIndex);
                  });
                },
              ),
            ],
          ),
          Text('2'),
          Text('3'),
          Text('2'),
          Text('3'),
        ],
      ),
    );
  }
}
