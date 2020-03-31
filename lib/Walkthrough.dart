import 'package:flutter/material.dart';

class Walkthrough extends StatelessWidget {
  final String textContent;
  final String imagePath;
  final String textTitle;
  Walkthrough({this.textTitle, this.textContent, this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/16),
              child: Text(
                textTitle,textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Baloo", fontSize: 54,
                  shadows: [
                    Shadow( // bottomLeft
                        offset: Offset(-1.5, -1.5),
                        color: Colors.white
                    ),
                    Shadow( // bottomRight
                        offset: Offset(1.5, -1.5),
                        color: Colors.white
                    ),
                    Shadow( // topRight
                        offset: Offset(1.5, 1.5),
                        color: Colors.white
                    ),
                    Shadow( // topLeft
                        offset: Offset(-1.5, 1.5),
                        color: Colors.white
                    ),
    ])),),

          Stack(children: <Widget>[
            Center(child:Container(height: MediaQuery.of(context).size.height/2.7,width: MediaQuery.of(context).size.height/2.7,
                decoration: BoxDecoration(color: Colors.black12,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red,width: 5))),),
            Center(child:Container(margin:EdgeInsets.only(top:MediaQuery.of(context).size.height/20),child: Image.asset(imagePath), height: MediaQuery.of(context).size.height/4, width: MediaQuery.of(context).size.height/4))
          ]),
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/16),
              child: Text(textContent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Roboto",
                      color: Colors.black,

                      fontSize: 30,fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow( // bottomLeft
                          offset: Offset(-0.5, -0.5),
                          color: Colors.white
                      ),
                      Shadow( // bottomRight
                          offset: Offset(0.5, -0.5),
                          color: Colors.white
                      ),
                      Shadow( // topRight
                          offset: Offset(0.5, 0.5),
                          color: Colors.white
                      ),
                      Shadow( // topLeft
                          offset: Offset(-0.5, 0.5),
                          color: Colors.white
                      ),
                    ],
                      )))
        ]);
  }
}
