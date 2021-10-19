import 'dart:convert';
import 'package:examnumber3/list_of_flag/list_of_flag.dart';
import 'package:examnumber3/models/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ExchangeCurrency extends StatefulWidget {
  @override
  _ExchangeCurrencyState createState() => _ExchangeCurrencyState();
}

class _ExchangeCurrencyState extends State<ExchangeCurrency> {
  List _results = [];
  String dropdownValue = '\$ Tanlang';
  String dropdownValue2 = '\$ Tanlang';
  String dropdownValue3 = '\$ Tanlang';
  String miqdori = "";
  String chiqqanqiymat = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      //App_Bar_Section________________//_______//
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "Valyuta Kursi",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      //Body_Bar_Section________________//_______//
      body: Column(
        children: [
          FutureBuilder(
            future: _getData(),
            builder: (context, AsyncSnapshot<List<Currency>> snap) {
              var data = snap.data;
              return snap.hasData
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 150.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              //Drop_Down_1_Bar_Section________________//_______//
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: Colors.white,
                                  ),
                                  iconSize: 34,
                                  style: const TextStyle(
                                      backgroundColor: Colors.blue,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '\$ Tanlang',
                                    'USD',
                                    'UZS',
                                    'RUB',
                                    'AED',
                                    'CNY'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            //Exchange_Section________________//_______//
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dropdownValue = dropdownValue2;
                                  dropdownValue2 = dropdownValue3;
                                  dropdownValue3 = dropdownValue;
                                });
                              },
                              child: Container(
                                width: 60.0,
                                height: 60.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(
                                    50.0,
                                  ),
                                ),
                                child: Icon(
                                  Icons.change_circle_outlined,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            //Drop_Down_2_Bar_Section________________//_______//
                            Container(
                              alignment: Alignment.center,
                              width: 150.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue2,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: Colors.white,
                                  ),
                                  iconSize: 34,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue2 = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '\$ Tanlang',
                                    'USD',
                                    'UZS',
                                    'RUB',
                                    'AED',
                                    'CNY'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //Money_Amount_input_Section________________//_______//
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 90,
                              alignment: Alignment.center,
                              width: 190.0,
                              child: TextField(
                                onChanged: (v) {
                                  miqdori = v;
                                },
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[700],
                                  labelText: 'Valyuta Miqdori',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            //Result_Section________________//_______//
                            Container(
                              child: Text(
                                chiqqanqiymat,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ),
                              alignment: Alignment.center,
                              width: 190.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //Result_Tap_Section________________//_______//
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (dropdownValue == "USD" &&
                                  dropdownValue2 == "UZS") {
                                chiqqanqiymat = (int.parse(miqdori) *
                                        double.parse(data![23].code.toString()))
                                    .toStringAsFixed(2)
                                    .toString();
                              } else if (dropdownValue == "RUB" &&
                                  dropdownValue2 == "UZS") {
                                chiqqanqiymat = (int.parse(miqdori) *
                                        double.parse(
                                            data![18].cbPrice.toString()))
                                    .toStringAsFixed(2)
                                    .toString();
                              } else if (dropdownValue == "UZS" &&
                                  dropdownValue2 == "RUB") {
                                chiqqanqiymat = (int.parse(miqdori) /
                                        double.parse(
                                            data![18].cbPrice.toString()))
                                    .toStringAsFixed(2)
                                    .toString();
                              } else if (dropdownValue == "UZS" &&
                                  dropdownValue2 == "USD") {
                                chiqqanqiymat = (int.parse(miqdori) /
                                        double.parse(
                                            data![23].cbPrice.toString()))
                                    .toStringAsFixed(2)
                                    .toString();
                              } else if (dropdownValue == "RUB" &&
                                  dropdownValue2 == "USD") {
                                chiqqanqiymat = (int.parse(miqdori) *
                                        double.parse(
                                            data![23].cbPrice.toString()))
                                    .toStringAsFixed(2)
                                    .toString();
                              } else if (dropdownValue == "USD" &&
                                  dropdownValue2 == "RUB") {
                                chiqqanqiymat = (int.parse(miqdori) /
                                        double.parse(
                                            data![18].cbPrice.toString()))
                                    .toStringAsFixed(2)
                                    .toString();
                              }
                            });
                            _results.add({
                              "from": {
                                "name": data![23].code,
                                "price": miqdori,
                              },
                              "to": {
                                "name": data[18].code,
                                "price": chiqqanqiymat,
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 370.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            child: Text(
                              "Pul Ayriboshlash",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0),
                            ),
                          ),
                        ),
                        //Main_Data_List_Section________________//_______//
                        Container(
                          height: 200.0,
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                trailing: Text(_results[index]["from"]["name"].toString(),),
                                leading: Text(_results[index]["to"]["price"].toString(),),
                              );
                            },
                            itemCount: _results.length,
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: CupertinoActivityIndicator(),
                    );
            },
          ),
        ],
      ),
    );
  }

  Future<List<Currency>> _getData() async {
    Uri url = Uri.parse("https://nbu.uz/uz/exchange-rates/json/");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => Currency.fromJson(e))
          .toList();
    } else {
      throw Exception("Xato Bor : ${res.statusCode}");
    }
  }
}
