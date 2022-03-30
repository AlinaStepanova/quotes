import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quotes_app/api/rest_client.dart';
import 'package:quotes_app/constants.dart';
import 'api/api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Quote? quote = null;

  @override
  void initState() {
    super.initState();
    getRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.075,
                  right: width * 0.075,
                  top: height * 0.05,
                  bottom: height * 0.05),
              child: Container(
                alignment: Alignment.center,
                width: width,
                height: height * 0.8,
                child: (quote != null)
                    ? SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: width * 0.025),
                                  child: Text(
                                    "\u275d",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: width * 0.25),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    quote?.quote ?? "",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: width * 0.06),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                  quote?.author ?? "",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: width * 0.04,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Center(child: Text("Loading...")),
                      ),
              ),
            ),
            buildNextQuoteButton(width, height),
          ],
        ),
      ),
    );
  }

  Padding buildNextQuoteButton(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.2),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0.5,
              side: BorderSide.none,
              textStyle: TextStyle(
                  fontSize: width * 0.05,
                  fontFamily: Constants.defaultFontFamily),
              padding: EdgeInsets.symmetric(
                  vertical: width * 0.04, horizontal: width * 0.1),
              shape: StadiumBorder()),
          onPressed: () {
            getRandomQuote();
          },
          child: const Text('Next Quote'),
        ),
      ),
    );
  }

  Future<void> getRandomQuote() async {
    var randomQuote = await API().client.getRandomQuote();
    setState(() {
      quote = randomQuote;
    });
  }
}
