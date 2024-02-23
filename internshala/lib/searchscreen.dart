import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internshala/filter.dart';

class searchscreen extends StatefulWidget {
  _searchscreenState createState() => _searchscreenState();
}

class _searchscreenState extends State<searchscreen> {
  List<dynamic> internships = [];

  void search() async {
    final url = Uri.parse("https://internshala.com/flutter_hiring/search");
    http.Response response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      internships = extractInternshipObjects(response.body);
    });
    print(internships);
  }

  List<dynamic> extractInternshipObjects(String jsonData) {
    List<dynamic> internshipObjects = [];
    Map<String, dynamic> data = jsonDecode(jsonData);
    Map<String, dynamic> internshipsMeta = data['internships_meta'];
    if (internshipsMeta != null) {
      // Iterate over the values associated with the keys directly
      internshipsMeta.forEach((key, value) {
        internshipObjects.add(value);
      });
    }
    return internshipObjects;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        onPressed: () async {
                          final updatedinternships = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: ((context) =>
                                      filter(internships: internships))));

                          if (updatedinternships != null) {
                            print("search $updatedinternships");
                            setState(() {
                              internships = updatedinternships;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.filter_alt_outlined,
                        ),
                        label: Text("Filters"),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Colors.blue), // Change outline color here
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text("${internships.length} total internships")],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: PageScrollPhysics(),
              child: Column(
                  children: internships.map((e) {
                String title = e["title"];
                String company = e["company_name"];
                List<dynamic> locations = e["location_names"];
                int salary = e["stipend"]["salaryValue1"];
                String scale = "month";
                String label = e["labels"][0]["label_value"][0];
                String start = e["start_date"];
                String duration = e["duration"];
                bool wfh = e["work_from_home"];
                return InkWell(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, bottom: 8.0),
                                    child: Text(
                                      company,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ))
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              children: wfh
                                  ? [
                                      Icon(Icons.home),
                                      Row(
                                        children: [
                                          Text(
                                            "Work From Home ",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ]
                                  : [
                                      Icon(Icons.location_on_outlined),
                                      Row(children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${locations.join(', ')}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              children: [
                                Icon(Icons.play_circle_outline_outlined),
                                Row(
                                  children: [
                                    Text(" $start ",
                                        style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 15),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20,
                                    ),
                                    Text(" $duration",
                                        style: TextStyle(fontSize: 20)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.moneyBill,
                                  size: 15,
                                ),
                                Text("  ₹ $salary /$scale",
                                    style: TextStyle(fontSize: 20))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              children: [
                                Container(
                                    color: Colors.grey[300],
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        label,
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 15),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "View details",
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 20),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),
            ),
          )
        ],
      ),
    );
  }
}
