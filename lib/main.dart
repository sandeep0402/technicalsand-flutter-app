import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';
import 'package:technicalsand/contact_us.dart';
import 'article.dart';
import 'article_engine.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'TechnicalSand';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        drawer: Drawer(
            child: myDrawer(
                context: context) // Populate the Drawer in the next step.
            ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            _title,
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          backgroundColor: Colors.black,
        ),
        body: ContactForm(),
      ),
    );
  }

  Drawer myDrawer({@required BuildContext context}) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Contact us'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('Contact Us'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/contact');
            },
          ),
        ],
      ),
    );
  }
}

class Pager extends StatefulWidget {
  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  List<Article> randomWordList = [];
  ArticleEngine articleEngine = ArticleEngine();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  var gradients = getGradients();

  @override
  void initState() {
    super.initState();
    randomWordList = articleEngine.articles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: PageView.builder(
        itemBuilder: (context, position) {
          return Stack(
            children: [
              SwipeGestureRecognizer(
                onSwipeLeft: () {
                  setState(() {
                    print('left swipe');
                    _handleURLLoading(context, randomWordList[position].url);
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      randomWordList[position].title,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        randomWordList[position].imageUrl,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AutoSizeText(
                                randomWordList[position].description,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Text(
                              "Swipe Left for full Article >",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getSwipeUpDownButtons(
                              position, randomWordList.length),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    gradient: gradients[position % gradients.length],
                  ),
                ),
              ),
            ],
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: randomWordList.length,
      ),
    );
  }

  List<Widget> getSwipeUpDownButtons(int position, int length) {
    List<Widget> widgets = [];
    if (position > 0) {
      widgets.add(Icon(
        Icons.keyboard_arrow_up,
        color: Colors.white,
      ));
      widgets.add(SizedBox(
        width: 8.0,
      ));
    }
    widgets.add(Text(
      "Swipe",
      style: TextStyle(color: Colors.white),
    ));
    print('position is $position and length is $length');
    if (position < length - 1) {
      widgets.add(SizedBox(
        width: 8.0,
      ));
      widgets.add(Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ));
    }
    return widgets;
  }

  static List<LinearGradient> getGradients() {
    return [
      LinearGradient(
        colors: [
          Colors.blue,
          Colors.green,
        ],
        stops: [
          0.0,
          1.0,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      LinearGradient(
        colors: [
          Colors.deepPurple,
          Colors.deepPurpleAccent,
        ],
        stops: [
          0.0,
          1.0,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      LinearGradient(
        colors: [
          Colors.teal,
          Colors.cyan,
        ],
        stops: [
          0.0,
          1.0,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      LinearGradient(
        colors: [
          Color(0xffcc2b5e),
          Color(0xff753a88),
        ],
        stops: [
          0.0,
          1.0,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      LinearGradient(
        colors: [
          Color(0xff56ab2f),
          Color(0xffa8e063),
        ],
        stops: [
          0.0,
          1.0,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    ];
  }

  void _handleURLLoading(BuildContext context, String url) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => myWebView(url)));
  }
}

class myWebView extends StatefulWidget {
  var url;

  myWebView(this.url);

  @override
  createState() => _myWebViewState(this.url);
}

class _myWebViewState extends State<myWebView> {
  var _url;
  num _stackToView = 1;

  _myWebViewState(this._url);

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: IndexedStack(
          index: _stackToView,
          children: <Widget>[
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _url,
                onPageFinished: _handleLoad,
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Please wait...',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SpinKitCubeGrid(
                      color: Colors.blue,
                      size: 150,
                    ),
                    Text(
                      'Technicalsand.com',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }


}

