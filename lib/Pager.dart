import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';

import 'article.dart';
import 'article_engine.dart';

class Pager extends StatefulWidget {
  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  bool dataLoaded = false;
  List<Article> randomWordList = [];
  ArticleEngine articleEngine = ArticleEngine();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var htmlUnescape = HtmlUnescape();

  var gradients = getGradients();

  @override
  void initState() {
    super.initState();
    //randomWordList = articleEngine.articles;
    fetchArticles();
  }

  void fetchArticles() {
    int pageNumber = 1;
    //https://codinginfinite.com/flutter-future-builder-pagination
    Future<List<Article>> articlesFuture = articleEngine.getPosts(pageNumber);
    articlesFuture.then((articles) => setState(() {
          randomWordList.addAll(articles);
          dataLoaded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (dataLoaded) {
      return getMainPageView();
    } else {
      return getMainPageLoader();
    }
  }

  Widget getMainPageLoader() {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cloud_download,
                color: Colors.blue,
                size: 100.0,
              ),
              SizedBox(
                height: 100.0,
              ),
              SpinKitWave(
                color: Colors.grey,
                size: 50,
              ),
              SizedBox(
                height: 100.0,
              ),
              Text(
                "Downloading Content. Please wait...",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ],
          ),
        ));
  }

  Widget getMainPageView() {
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
                          children: getPostsLayout(position),
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

  List<Widget> getPostsLayout(int position) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                removeAllHtmlTags(randomWordList[position].title, false),
                overflow: TextOverflow.visible,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                fetchArticles();
              },
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
          removeAllHtmlTags(randomWordList[position].description, true),
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
    ];
  }

  String removeAllHtmlTags(String htmlString, bool truncate) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    if (truncate) {
      parsedString = parsedString.substring(0, 300);
      parsedString = parsedString.substring(0, parsedString.lastIndexOf(' '));
      parsedString += ' ...';
    }

    parsedString = htmlUnescape.convert(parsedString);
    return parsedString;
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
