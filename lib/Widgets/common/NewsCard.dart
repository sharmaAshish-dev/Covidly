import 'package:covidly/Screens/NewsDetailsPage.dart';
import 'package:covidly/model/NewsArticle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewsCard extends StatefulWidget {
  final NewsArticle article;

  const NewsCard({Key key, this.article}) : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailsPage(
                article: widget.article,
              ),
            )),
        child: Container(
          width: appSize.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                Colors.white70,
                Colors.white70,
              ]),
              boxShadow: [
                BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.article.imageUrl,
                      width: appSize.width,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white.withOpacity(0.6)),
                            child: Text(
                              "Health",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white.withOpacity(0.6)),
                            child: Text(
                              "Covid-19",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.article.title,
                      style: TextStyle(fontWeight: FontWeight.w800),
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.article.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
