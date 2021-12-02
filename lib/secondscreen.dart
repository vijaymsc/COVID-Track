import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<covid> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://corona.lmao.ninja/v2/countries/India?yesterday%20=false'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return covid.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class covid {
  final int cases;
  final int todayCases;
  final int todayDeaths;
  final int todayRecovered;
  final int active;
  final int updated;
  covid({
    required this.cases,
    required this.todayCases,
    required this.todayDeaths,
    required this.todayRecovered,
    required this.active,
    required this.updated,
  });
  factory covid.fromJson(Map<String, dynamic> json) {
    return covid(
        cases: json['cases'],
        todayCases: json['todayCases'],
        todayDeaths: json['todayDeaths'],
        todayRecovered: json['todayRecovered'],
        active: json['active'],
        updated: json['updated']);
  }
}

class details extends StatefulWidget {
  const details({Key? key}) : super(key: key);

  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  //List coviddata = [];

  /* @override
  void initState() {
    super.initState();
    fetchdata();
  }*/

  /*fetchdata() async {
    var responce = await http.get(Uri.parse(
        "https://corona.lmao.ninja/v2/countries/India?yesterday =false"));
    print(responce.body);
    print(responce.headers);
    print(responce.request);
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      Map item = json.decode(responce.body);
      setState(() {
        coviddata = item['results'];
      });
    } else {
      coviddata = [];
    }
  }*/
  late Future<covid> futurecovid;

  @override
  void initState() {
    futurecovid = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<covid>(
      future: futurecovid,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Column(
              children: [
                /*Text(
                  snapshot.data!.cases.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),*/
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/covid19.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: double.infinity,
                          color: Colors.black54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Cases:',
                                style: TextStyle(
                                    color: Colors.yellow, fontSize: 20),
                              ),
                              Text(
                                snapshot.data!.cases.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          color: Colors.black54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Today case:',
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 20),
                              ),
                              Text(
                                snapshot.data!.todayCases.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          color: Colors.black54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Today deaths:',
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 20),
                              ),
                              Text(
                                snapshot.data!.todayDeaths.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          color: Colors.black54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Today recovery case:',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                              Text(
                                snapshot.data!.todayRecovered.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          color: Colors.black54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                ' Active Cases:',
                                style: TextStyle(
                                    color: Colors.purple, fontSize: 20),
                              ),
                              Text(
                                snapshot.data!.active.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'over all cases: ${snapshot.data!.updated}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
