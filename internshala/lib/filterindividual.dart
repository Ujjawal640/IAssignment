import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class filterindividual extends StatefulWidget {
  final List<String> fields;
  final String field;

  filterindividual({required this.fields, required this.field});

  @override
  _filterindividual createState() => _filterindividual();
}

class _filterindividual extends State<filterindividual> {
  List<String> selected = [];
   List<String> sselected = [];
  late String heading;
  Map<String, bool> checkedValues = {}; // Map to track the checked state of each item


  void _updateDataAndPop() {
    // Update the data as needed

    Navigator.pop(context, selected); // Send back the updated data
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    heading = widget.field;
    sselected = widget.fields;
    print(sselected);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(heading),
        actions: [Row(
          children: [
            OutlinedButton(
                    onPressed: () {},
                    child: Text("Clear"),
                    style: OutlinedButton.styleFrom(
                      side:  BorderSide(color: Colors.blueAccent),
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                  ),
                  SizedBox(width: 10,),
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
          
        ],
      ),
      body: Column(
         children: sselected.map((e) {
      return CheckboxListTile(
        title: Text(e),
        value: checkedValues[e] ?? false, // Use the value from checkedValues, defaulting to false
        onChanged: (newValue) {
          setState(() {
            if (newValue!) {
              selected.add(e); // Add item to selected list if checkbox is checked
            } else {
              selected.remove(e); // Remove item from selected list if checkbox is unchecked
            }
            checkedValues[e] = newValue; // Update the checked state of the item
          });
        },
          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
      );
    }).toList(),
      ),
    );
  }
}
