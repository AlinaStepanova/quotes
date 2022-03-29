import 'package:flutter/material.dart';

import 'api/api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
    getRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      ),
    );
  }

  Future<void> getRandomQuote() async {
    var quote = await API().client.getRandomQuote();
    print(quote.quote.toString());
  }
}