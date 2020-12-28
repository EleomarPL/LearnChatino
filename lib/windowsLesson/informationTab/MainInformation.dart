import 'package:flutter/material.dart';
import 'CarouselInformation.dart';

class MainInformation extends StatefulWidget {
  MainInformation({Key key}) : super(key: key);

  @override
  _MainInformationState createState() => _MainInformationState();
}

Widget _textInformation(String text, double sizeText, FontWeight weightText) =>
    Text(
      text,
      style: TextStyle(
        fontSize: sizeText,
        fontWeight: weightText,
      ),
      textAlign: TextAlign.justify,
      //textScaleFactor: 5.0,
    );
Widget _textWithPadding(String text, double size, FontWeight weight) => Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: _textInformation(text, size, weight),
    );

class _MainInformationState extends State<MainInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              CarouselInformation(
                //warning: the number of images and description must be the same
                listImageDescription: [
                  [
                    'assets/informationTab/slider0.jpg',
                    'assets/informationTab/slider1.jpg',
                    'assets/informationTab/slider2.png',
                    'assets/informationTab/slider3.png',
                    'assets/informationTab/slider4.jpg',
                    'assets/informationTab/slider5.jpg',
                    'assets/informationTab/slider6.png',
                    'assets/informationTab/slider7.jpg',
                    'assets/informationTab/slider8.jpg',
                  ],
                  [
                    'La lengua materna',
                    'Lenguas indígenas de México',
                    'Grupos indígenas de Oaxaca',
                    'Los chatinos',
                    'Rescatemos nuestra lengua materna',
                    'Las lenguas del mundo',
                    'Oaxaca un estado pluricultural y plurilingüe',
                    'Chiapas, segundo ligar en diversidad lingüística',
                    'Difundamos nuestra lengua'
                  ]
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textInformation(
                          'LA LENGUA MATERNA', 26, FontWeight.w900),
                      _textInformation('Fuente: INALI 2008 México/INEGI', 16,
                          FontWeight.normal),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textInformation('Lenguas indígenas nacionales de México',
                          18, FontWeight.w700),
                      SizedBox(
                        height: 20,
                      ),
                      _textWithPadding(
                        'México es considerado uno de los 10 países con mayor diversidad lingüistica,'
                        ' es decir que se hablan muchas lenguas, de acuerdo a los datos del Instituto'
                        ' Nacional de Lenguas Indígenas (INALI) se hablan 68 lenguas con variantes '
                        'lingüisticas.\n\nOaxaca es el estado de la República Mexicana con mayor diversidad '
                        'lingüistica y cultural, está formado por 570 municipios, donde conviven más de 16 '
                        'grupos culturales con tradiciones y costumbres totalmente distintas entre sí.\n',
                        16,
                        FontWeight.normal,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: _textInformation(
                            "El chatino\n", 17, FontWeight.bold),
                      ),
                      _textWithPadding(
                        'El chatino o cha´jna´a es una agrupación lingüistica que pertenece a la familia '
                        'oto-mangue. Se habla en el estado de Oaxaca. Es muy cerca a la agrupación lingüistica '
                        'zapoteco. Actualmente, en base al catálogo nacional de lenguas indígenas de México '
                        '(2009), existen 6 variantes del chatino y son: \n\n'
                        '1. Chatino occidental alto/ cha´ jna´a (occidental alto) no inmediato\n2. Chatino '
                        'occidental bajo/ cha´ jna´a (occidental bajo) mediano\n3. Chatino central/ cha´ jna´a '
                        '(central)\n4. Chatino oriental bajo/ cha´ jna´a (oriental bajo)mediano\n5. Chatino '
                        'oriental alto/ cha´ jna´a (oriental alto)\n6. Chatino de Zacatepec/ cha´ jna´a '
                        '(de Zacatepec)',
                        16,
                        FontWeight.normal,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
