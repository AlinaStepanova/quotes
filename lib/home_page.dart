import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quotes_app/api/rest_client.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.075),
              child: Container(
                width: width,
                height: height,
                child: (quote != null)
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.025),
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
                                  style: TextStyle(fontSize: width * 0.07),
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
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getRandomQuote() async {
    var quote1 = await API().client.getRandomQuote();
    setState(() {
      quote = quote1;
    });
  }
}
