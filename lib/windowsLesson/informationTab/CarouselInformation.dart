import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

class CarouselInformation extends StatefulWidget {
  final List<List<String>> listImageDescription;
  CarouselInformation({Key key, this.listImageDescription}) : super(key: key);

  @override
  _CarouselInformationState createState() => _CarouselInformationState();
}

class _CarouselInformationState extends State<CarouselInformation> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.listImageDescription[0].map(
      (item) {
        return Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  item,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          Colors.black12,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      widget.listImageDescription[1]
                          [widget.listImageDescription[0].indexOf(item)],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).toList();
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            setState(
              () {
                _current = index;
              },
            );
          },
        ),
      ),
      Container(
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.listImageDescription[0].map((url) {
            int index = widget.listImageDescription[0].indexOf(url);
            return Column(
              children: [
                Container(
                  width: (_current == index) ? 11.0 : 8.0,
                  height: (_current == index) ? 11.0 : 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.white70 : Colors.black26,
                  ),
                ),
                SizedBox(
                  width: 19,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
