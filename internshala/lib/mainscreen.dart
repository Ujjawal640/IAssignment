import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshala/homescreen.dart';
import 'package:internshala/searchscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class mainscreen extends StatefulWidget {
  const mainscreen({Key? key}) : super(key: key);

  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  int selectedpageindex = 1;

  void _selectpage(int index) {
    setState(() {
      selectedpageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activepage = homescreen();
    String title = "Internshala";

    if (selectedpageindex == 1) {
      activepage = searchscreen();
      title = "Internships";
    }
    if (selectedpageindex == 2) {
      activepage = searchscreen();
      title = "Jobs";
    }
    if (selectedpageindex == 3) {
      activepage = searchscreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close the drawer
                    },
                    
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update UI based on drawer item 1
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update UI based on drawer item 2
              },
            ),
            // Other ListTiles...
          ],
        ),
      ),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: Colors.white, // <-- This works for fixed
        selectedItemColor: Colors.blueAccent,
        unselectedLabelStyle:TextStyle(color: Colors.black),
        onTap: (value) {
          _selectpage(value);
        },
        currentIndex: selectedpageindex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                selectedpageindex == 0 ? Icons.home : Icons.home_outlined,
                color:
                    selectedpageindex == 0 ? Colors.blueAccent : Colors.black,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: FaIcon(selectedpageindex == 1 ? FontAwesomeIcons.solidPaperPlane : FontAwesomeIcons.paperPlane,color:selectedpageindex == 1 ? Colors.blueAccent:Colors.black ,),
              label: "Internship"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.cases_outlined,
                color: Colors.black,
              ),
              label: "Jobs"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.tv_off_outlined,
                color: Colors.black,
              ),
              label: "Courses")
        ],
      ),
    );
  }
}
