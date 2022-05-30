import 'dart:convert';
import 'dart:ui';

import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:covidly/Widgets/common/NewsCard.dart';
import 'package:covidly/Widgets/errorScreens/Something_went_wrong.dart';
import 'package:covidly/Widgets/loadings/CustomLoadingDialog.dart';
import 'package:covidly/model/NewsArticle.dart';
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

dynamic globalNewsData;

class NewsUpdatePage extends StatefulWidget {
  const NewsUpdatePage({Key key}) : super(key: key);

  @override
  _NewsUpdatePageState createState() => _NewsUpdatePageState();
}

class _NewsUpdatePageState extends State<NewsUpdatePage> with AutomaticKeepAliveClientMixin {
  bool isDataLoaded = false;
  bool isTab1 = true;
  bool isTab2 = false;

  Future fetchNews() async {
    var url = Uri.parse('https://newsapi.org/v2/everything?qInTitle=(Covid%20OR%20Corona)%20NOT%20+alcohol&language=en&apiKey=5bdee0d2641c4e6092827ab728d8b9d3');
    var response = await http.get(url);
    dynamic data = jsonDecode(response.body);

    isDataLoaded = true;

    return data;
  }

  @override
  void initState() {
    super.initState();
    globalNewsData = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size appSize = MediaQuery.of(context).size;

    Future<void> reloadScreen() async {
      setState(() {
        globalNewsData = fetchNews();
      });
    }

    Widget _contentArea(context, snapshot) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: reloadScreen,
          child: ScrollConfiguration(
            behavior: NoScrollGlowBehaviour(),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 40, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Covid-19",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.060, color: LightTheme.greyishBlack),
                                ),
                                Text(
                                  "Global News",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.076, fontWeight: FontWeight.w600, color: LightTheme.black),
                                ),
                              ],
                            ),
                            Stack(children: [
                              Opacity(child: Image.asset('assets/images/news.png', height: MediaQuery.of(context).size.height * 0.24, color: Colors.black), opacity: 0.28),
                              ClipRect(
                                  child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), child: Image.asset('assets/images/news.png', height: MediaQuery.of(context).size.height * 0.24)))
                            ]),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: appSize.height,
                      child: ListView.builder(
                          itemCount: snapshot.data['articles'].length,
                          itemBuilder: (context, index) {
                            String newsContent = snapshot.data['articles'][index]['content'];
                            String dummyContent = "";
                            for (int i = 0; i < 3; i++) {
                              dummyContent += newsContent.split("…")[0];
                              if (i != 1) dummyContent += "\n\n";
                            }
                            return NewsCard(
                              article: NewsArticle(
                                  title: snapshot.data['articles'][index]['title'],
                                  description: snapshot.data['articles'][index]['description'],
                                  imageUrl: snapshot.data['articles'][index]['urlToImage'],
                                  content: dummyContent,
                                  date: snapshot.data['articles'][index]['publishedAt'],
                                  sourceName: snapshot.data['articles'][index]['source']['name'],
                                  sourceUrl: snapshot.data['articles'][index]['url']),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: fetchNews(),
          // ignore: missing_return
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text("Unable To Connect"));
                break;
              case ConnectionState.active:
                return Text("Please wait...");
              case ConnectionState.waiting:
                return CustomLoadingDialog();
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Stack(
                      children: [
                        SomethingWentWrongScreen(),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.15,
                          left: MediaQuery.of(context).size.width * 0.3,
                          right: MediaQuery.of(context).size.width * 0.3,
                          child: FlatButton(
                            color: LightTheme.primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            onPressed: reloadScreen,
                            child: Text(
                              "Try Again".toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return _contentArea(context, snapshot);
                }
                break;
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
