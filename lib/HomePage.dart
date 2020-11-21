import 'package:flutter/material.dart';

import 'addEvent.dart';
import 'allEvent.dart';
import 'favorit.dart';
import 'profile.dart';



class HomePage extends StatefulWidget {
  String emailFinalH ;
  HomePage({this.emailFinalH});




  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static  String email = emailFinalH ;
  int _currentIndex = 0 ;
  var mcontext ;
final tabs = [
  Center(
      child: gotoallEvent()),
  Center(child: gotoFavoris()),
  Center(child: gotoaddEvent()),
  Center(child: gotoProfile()),

];

  static String get emailFinalH => emailFinalH;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
        //Text('Hello it is Home Page ${widget.emailFinalH}',

      tabs[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex ,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF95DEDE),
        unselectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF372B4B),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
                                  title: Text('Home'),
                                 backgroundColor: const Color(0xFF95DEDE),



          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),
            title: Text('Favourites '),
            backgroundColor: const Color(0xFF95DEDE),


          ),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle),
            title: Text('Add Event'),
            backgroundColor: const Color(0xFF95DEDE),



          ),
          BottomNavigationBarItem(icon: Icon(Icons.person),
            title: Text('My Profile'),
            backgroundColor: const Color(0xFF95DEDE),


          ),
        ],

        onTap: (index) {
          setState(() {
            _currentIndex = index;
            mcontext = context;
          });
        } ,
      ) ,


    );

  }

  static gotoallEvent() {
    //Text('Hello it is Home Page ${widget.username}',
    return AllEvent();
    }

  static gotoaddEvent() {

    return addEventPage();
  }

  static gotoFavoris() {
    return fovorisPage();
  }

  static gotoProfile() {
    return ProfilePage();
  }


}


