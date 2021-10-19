import 'dart:convert';

import 'package:examnumber3/list_of_flag/list_of_flag.dart';
import 'package:examnumber3/models/currency_data.dart';
import 'package:examnumber3/screens/exchange_currency.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Valyuta kursi",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 0),
                child: Text(
                  "Valyuta ayriboshlash",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25.0),
                height: 700.0,
                width: double.infinity,
                color: Colors.grey[300],
                child: FutureBuilder(
                        future: _getInfoFromApi(),
                        builder: (context, AsyncSnapshot<List<Currency>> snap) {
                          var data = snap.data;
                          return snap.hasData
                              ? ListView.builder(
                                  itemCount: data!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/images/" +
                                              Flag.Country_Names[index] +
                                              ".png",
                                        ),
                                      ),
                                      title: Text(
                                        data[index].title.toString(),
                                      ),
                                      subtitle: Text(
                                        data[index].date.toString(),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            data[index].code.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan[600],
                                            ),
                                          ),
                                          Text(
                                            data[index].cbPrice.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: CupertinoActivityIndicator(),
                                );
                        },
                      ),
              ),
              Positioned(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExchangeCurrency(),
                      ),
                    );
                  },
                  child: Text(
                    "Exchange Page",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                bottom: 20.0,
                right: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Currency>> _getInfoFromApi() async {
    final _response =
        await http.get(Uri.parse("https://nbu.uz/uz/exchange-rates/json/"));
    if (_response.statusCode == 200) {
      return (json.decode(_response.body) as List)
          .map((e) => Currency.fromJson(e))
          .toList();
    } else {
      throw Exception("Error Api is not coming!!!");
    }
  }
}
