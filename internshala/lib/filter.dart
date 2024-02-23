import 'package:flutter/material.dart';
import 'package:internshala/filterindividual.dart';

class filter extends StatefulWidget {
  final List<dynamic> internships;

  filter({required this.internships});

  @override
  _filterState createState() => _filterState();
}

class _filterState extends State<filter> {
  late List<dynamic> updatedinternships;
  List<dynamic> filter = [];
  List<String> profilefields = [];
  List<String> cityfields = [];
  var duration;

  List<String> profilefieldsdata = ["data", "web", "mobile"];
  List<String> cityfieldsdata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filter = List.from(widget.internships);
  }

  void _updateDataAndPop() {
    updatedinternships = filter.where((e) {
      if (profilefields.contains(e["profile_name"]) ||
          e["duration"] == duration ||
          e["location_names"].any((city) => cityfields.contains(city))) {
        return true;
      }
      return false;
    }).toList();
    print(updatedinternships);
    // Update the data as needed
    Navigator.pop(context, updatedinternships); // Send back the updated data
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Filter")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [Text("Profile",style: TextStyle(fontSize: 20),)],
                    ),
                    Row(
                      children: profilefields.isEmpty
                          ? [
                              TextButton.icon(
                                  onPressed: () async {
                                    final pselected =
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    filterindividual(
                                                      field: 'Profiles',
                                                      fields: [
                                                        "Data Science",
                                                        "Administration",
                                                        "Business Analytics",
                                                        "Android App Development",
                                                        "Product Management"
                                                      ],
                                                    ))));

                                    if (pselected != null) {
                                      setState(() {
                                        profilefields = pselected;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.add),
                                  label: Text("Profile",style: TextStyle(fontSize: 18)))
                            ]
                          : profilefields.map((e) {
                              return Card(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                profilefields.remove(e);
                                              });
                                            },
                                            icon: Icon(Icons.close),
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [Text("City",style: TextStyle(fontSize: 20))],
                      ),
                      Row(
                        children:cityfields.isEmpty? [
                          TextButton.icon(
                              onPressed: () async {
                                final pselected = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: ((context) => filterindividual(
                                              field: 'Cities',
                                              fields: ["Delhi","Munnar","Lucknow","Tarn Taran","Banga (Philippines)","Parbhani","Kera"],
                                            ))));

                                if (pselected != null) {
                                  setState(() {
                                                                    cityfields = pselected;

                                  });
                                }
                              },
                              icon: Icon(Icons.add),
                              label: Text("City",style: TextStyle(fontSize: 18)))
                        ]
                        :
                        cityfields.map((e){
                           return Card(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              e,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  cityfields.remove(e);
                                                });
                                              },
                                              icon: Icon(Icons.close),
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        }).toList()
                        ,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [Text("Maximum Duration(in months)",style: TextStyle(fontSize: 20))],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4, right: 16),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                    color: Colors
                                        .grey), // Define your border properties here
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  iconSize:40,
                                 // itemHeight:20,
                                  value: duration,
                                  isDense: true,
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("1"),
                                      value: "1",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("2"),
                                      value: "2",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("3"),
                                      value: "3",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("4"),
                                      value: "",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("5"),
                                      value: "5",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("6"),
                                      value: "6",
                                    ),
                                  ], // Add your dropdown items here
                                  onChanged: (value) {
                                    setState(() {
                                      duration = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text("Clear"),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blueAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
              OutlinedButton(
                onPressed: () {
                  _updateDataAndPop();
                },
                child: Text(
                  "Apply",
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ],
          ),
        ));
  }
}
