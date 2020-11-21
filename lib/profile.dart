
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'api.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {



  @override
  _ProfilePageState createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage> {

  String email = LoginPage.emailFinal;

  String fullNameProfil = '';
  String urlimgProfil = '';


  getInfoProfil ( String email) async {
    var resp = await getProfileinfo(email);

    if (resp.containsKey('success')) {
      if (resp['success'] == 1) {

        setState(() {
          fullNameProfil = resp['fullName'];
          urlimgProfil = resp['urlimg'];
        });

      }
      else {

        setState(() {

          fullNameProfil = 'no full Name';
          urlimgProfil = 'https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=373942950699871&height=50&width=50&ext=1607818552&hash=AeSt-1kTfgn0OXHrw7Y';

        });
      }
    }

  }

  @override
  void initState() {
    super.initState();

    this.getInfoProfil(email);
  }



  final facebookLogin = FacebookLogin();

  Widget textfield({@required String hintText}){
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),

      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            letterSpacing: 2,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          fillColor: const Color(0xFF95DEDE) ,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF95DEDE),
          elevation: 0.0,
        leading: new Container(),
        actions : <Widget> [
          Row(
            children: [
              Text("Log Out "),
              IconButton(icon: Icon(Icons.login_outlined),onPressed: ( ){

                facebookLogin.logOut();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {

                      return LoginPage();
                    })
                );
              }),
            ],
          ),

        ],


      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textfield(
                    hintText: fullNameProfil,
                  ),
                  textfield(
                    hintText: email ,
                  )


                ],
              ),
            )
          ],
        ),


          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

            ),
            painter: HeaderCurverContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Padding(padding: EdgeInsets.all(30),
             child: Text("My Profile", style: TextStyle(fontSize: 35,letterSpacing: 1.5,color: Colors.black,fontWeight: FontWeight.w600
             ),
             ),
             ),

              Container(
               padding: EdgeInsets.all(10.0),
               width: MediaQuery.of(context).size.width/2,
               height: MediaQuery.of(context).size.width/2,
               decoration: BoxDecoration(
                 border: Border.all(color: const Color(0xFFE3F6F5),width: 6),
                 shape: BoxShape.circle,
                 color: const Color(0xFF372B4B),

                 image: DecorationImage(
                     fit : BoxFit.cover,
                     image: NetworkImage(urlimgProfil),



                 )

               ),
              )

            ],
          ),

          //Padding(padding: null)
        ],
      ) ,
    );
  }
}
class HeaderCurverContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFF95DEDE);
    Path path = Path()
    ..relativeLineTo(0, 150)
    ..quadraticBezierTo(size.width/2, 255, size.width, 150)
    ..relativeLineTo(0, -150)
    ..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;



}
