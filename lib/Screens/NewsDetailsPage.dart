import 'package:covidly/Widgets/Buttons/backButton.dart';
import 'package:covidly/model/NewsArticle.dart';
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsPage extends StatefulWidget {
  final NewsArticle article;

  const NewsDetailsPage({Key key, this.article}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      height: appSize.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Stack(
            children: [
              Container(
                height: appSize.height * 0.45,
                child: ClipRRect(
                  child: Image.network(
                    widget.article.imageUrl,
                    width: appSize.width,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 50),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: backButton(
                    borderColor: Colors.white,
                    containerColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              width: appSize.width,
              height: appSize.height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: ScrollConfiguration(
                behavior: NoScrollGlowBehaviour(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.article.title,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: appSize.width * 0.044),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          formatISODate(widget.article.date),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: appSize.width * 0.034),
                        ),
                        Text(
                          "Source: " + widget.article.sourceName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: appSize.width * 0.034),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.article.content,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () => _launchURL(widget.article.sourceUrl),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                              child: Text(
                                'Read full article',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  String formatISODate(String isoDate) {
    if (isoDate == null) {
      return "N/A";
    }

    isoDate = isoDate.split("+")[0];

    DateTime updateTime = DateTime.parse(isoDate);
    return DateFormat('dd-MMM-yyyy').add_jm().format(updateTime);
  }
}
