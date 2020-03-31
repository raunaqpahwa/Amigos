import 'package:flutter/material.dart';
import './Walkthrough.dart';
import 'package:dots_indicator/dots_indicator.dart';
import './Strings.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import './builtin_transformers.dart';
class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OnBoardingState();
  }
}
class _OnBoardingState extends State {
  int currentIndexPage;
  int pageLength;
  List<String> title = [
    Strings.OnBoardPageOneTitle,
    Strings.OnBoardPageTwoTitle,
    Strings.OnBoardPageThreeTitle
  ];
  List<String> images = [
    Strings.LogoOnePath,
    Strings.LogoTwoPath,
    Strings.LogoThreePath
  ];
  List<String> content = [
    Strings.OnBoardPageOneContent,
    Strings.OnBoardPageTwoContent,
    Strings.OnBoardPageThreeContent
  ];
  @override
  void initState() {
    currentIndexPage = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      floatingActionButton: GestureDetector(onVerticalDragUpdate:(dragUpdateDetails){
        Navigator.pushNamed(context,'login');
      },child:FloatingActionButton(
          tooltip: "Drag up",
          onPressed: null,
          child: Hero(child:Padding(child:Image.asset(Strings.LoginScreen),padding: EdgeInsets.all(5.0),),tag: 'logohero',),
          backgroundColor: Colors.black87,
          foregroundColor: Colors.redAccent)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: MediaQuery.of(context).size.height/14,
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: DotsIndicator(
                      numberOfDot: pageLength,
                      position: currentIndexPage,
                      dotColor: Colors.black,
                      dotActiveColor: Colors.redAccent,
                      dotActiveSize: const Size(18.0, 9.0),
                      dotActiveShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))))
            ],
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        TransformerPageView(onPageChanged: (value) {
          setState(() {
            currentIndexPage = value;
          });},
            loop: false,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: Walkthrough(
                      textTitle: title[currentIndexPage],
                      imagePath: images[currentIndexPage],
                      textContent: content[currentIndexPage]));
            },
            itemCount: 3,
            transformer: ZoomOutPageTransformer(),

            ),
      ]),
    );
  }
}
