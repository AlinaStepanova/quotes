import 'package:flutter/material.dart';
import 'package:quotes_app/api/rest_client.dart';
import 'package:quotes_app/constants.dart';
import 'package:share_plus/share_plus.dart';
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
              padding: EdgeInsets.only(right: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        splashColor: Colors.lightBlueAccent[200],
                        onTap: () {},
                        child: SizedBox(
                            width: 44,
                            height: 44,
                            child:
                                Icon(Icons.star_outline, color: Colors.black)),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        splashColor: Colors.lightBlueAccent[200],
                        onTap: () => _onShare(context),
                        child: SizedBox(
                            width: 44,
                            height: 44,
                            child: Icon(Icons.share, color: Colors.black)),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                                Flexible(
                                  child: Text(
                                    quote?.quote ?? "",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: width * 0.06),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.025),
                                  child: Text(
                                    "\u275e",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: width * 0.25),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
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
      padding: EdgeInsets.only(
        bottom: height * 0.2,
        right: width * 0.075,
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ClipOval(
          child: Material(
            color: Colors.white,
            child: InkWell(
              splashColor: Colors.lightBlueAccent[200],
              onTap: () {
                setState(() => quote = null);
                getRandomQuote();
              },
              child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 36, color: Colors.black)),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getRandomQuote() async {
    var randomQuote = await API().client.getRandomQuote();
    setState(() => quote = randomQuote);
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(Constants.appName,
        subject: quote?.quote ?? "",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
