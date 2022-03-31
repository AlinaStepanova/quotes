import 'package:flutter/material.dart';
import 'package:quotes_app/api/rest_client.dart';
import 'package:quotes_app/utils/constants.dart';
import 'package:share_plus/share_plus.dart';
import '../services/quotes_repository.dart';
import '../widgets/icon_with_action.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
        child: (quote != null)
            ? Stack(
                children: [
                  if (!kIsWeb)
                    Padding(
                      padding: EdgeInsets.only(
                          top: width * 0.05, right: width * 0.05),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconWithAction(
                          Icons.share,
                          () => _onShare(context),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.075, vertical: height * 0.05),
                    child: Container(
                        alignment: Alignment.center,
                        width: width,
                        height: height * 0.9,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      quote?.quote ?? "",
                                      key: Key('quote'),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: kIsWeb
                                              ? width * 0.03
                                              : width * 0.06),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.025),
                                    child: kIsWeb
                                        ? Icon(Icons.format_quote_rounded,
                                            size: width * 0.25,
                                            color: Constants.primaryColor)
                                        : Text(
                                            "\u275e",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: width * 0.25,
                                                color: Constants.primaryColor),
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
                                        fontSize: kIsWeb
                                            ? width * 0.02
                                            : width * 0.04,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  buildNextQuoteButton(width, height),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Padding buildNextQuoteButton(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: height * 0.1,
        right: width * 0.075,
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconWithAction(
            Icons.arrow_forward_ios_rounded, () => loadNextQuote(),
            size: kIsWeb ? height * 0.15 : width * 0.15,
            iconSize: kIsWeb ? height * 0.1 : width * 0.1,
            key: Key('nextQuote')),
      ),
    );
  }

  void loadNextQuote() {
    setState(() => quote = null);
    getRandomQuote();
  }

  Future<void> getRandomQuote() async {
    var randomQuote = await QuotesRepository().getQuote();
    setState(() => quote = randomQuote);
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(Constants.appName,
        subject: quote?.quote ?? "",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
