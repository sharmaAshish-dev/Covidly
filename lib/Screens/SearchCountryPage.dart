import 'dart:convert';

import 'package:covidly/Screens/countryDetailPage.dart';
import 'package:covidly/model/countryCardModel.dart';
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:covidly/uTils/constAPIUrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchCountryPage extends StatefulWidget {
  @override
  _SearchCountryPageState createState() => _SearchCountryPageState();
}

class _SearchCountryPageState extends State<SearchCountryPage> {
  List<CountryModel> countries = [];
  List<CountryModel> countriesForDisplay = [];
  bool allowSearch = false;

  Future getCountries() async {
    var url = apiUrl.baseUrl + "summary";
    var response = await http.get(Uri.parse(url));
    dynamic data = jsonDecode(response.body);

    for (int i = 0; i < data['Countries'].length; i++) {
      CountryModel country = CountryModel(
        countryName: data['Countries'][i]['Country'],
        countryCode: data['Countries'][i]['CountryCode'],
        countrySlug: data['Countries'][i]['Slug'],
        totalCases: data['Countries'][i]['TotalConfirmed'],
      );
      countries.add(country);
    }

    countriesForDisplay = countries;

    return data;
  }

  @override
  void initState() {
    super.initState();
    getCountries().then((value) {
      setState(() {
        allowSearch = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 17),
        child: Column(
          children: [
            Expanded(
                child: ScrollConfiguration(
              behavior: NoScrollGlowBehaviour(),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return index == 0 ? _searchBar() : _listData(context, index - 1);
                },
                itemCount: countriesForDisplay.length + 1,
              ),
            )),
          ],
        ),
      ),
    );
  }

  _searchBar() {
    Size appSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AnimatedContainer(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
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
                  duration: Duration(seconds: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      enabled: allowSearch,
                      onChanged: (value) {
                        value = value.toLowerCase();
                        setState(() {
                          countriesForDisplay = countries.where((country) {
                            var countryTitle = country.countryName.toLowerCase();
                            return countryTitle.contains(value);
                          }).toList();
                        });
                      },
                      decoration: InputDecoration(hintText: "Search Country", border: InputBorder.none),
                      style: TextStyle(color: Colors.black, fontSize: appSize.width * 0.040, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: AnimatedContainer(
                    duration: Duration(seconds: 2),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 50,
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
                    child: Center(child: Text("Cancel")),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _listData(context, index) {
    Size appSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CountryDetailPage(
              countryName: countriesForDisplay[index].countryName,
              countryCode: countriesForDisplay[index].countryCode,
              countrySlug: countriesForDisplay[index].countrySlug,
              totalCases: countriesForDisplay[index].totalCases,
              fromSearch: true,
              flagPath: "https://www.countryflags.io/" + countriesForDisplay[index].countryCode + "/shiny/64.png",
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                Colors.white,
                Colors.white,
              ]),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
              ]),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          width: appSize.width,
          child: Row(
            children: [
              Image.network("https://www.countryflags.io/" + countriesForDisplay[index].countryCode + "/shiny/64.png", width: appSize.width * 0.11),
              SizedBox(width: 20),
              Text(countriesForDisplay[index].countryName),
            ],
          ),
        ),
      ),
    );
  }
}
