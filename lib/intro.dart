import 'package:flutter/material.dart';

import 'custom_widgets.dart';
import 'login.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget> [

        Positioned(
            top: 0,
            child: HeroImage(
              imgheight: MediaQuery.of(context).size.height * 0.7,
            )),

        Positioned(
            bottom: 5,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                padding: EdgeInsets.fromLTRB(20,10,20,10),

                child: Column(
                  children: <Widget>[
                    Text('Expect the unexpected !!!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6),

                    Text('Achieve the unachievable!!!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 20),

                    CustomButton(btnText: 'Getting started',onBtnPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) {

                        return LoginPage();
                      })
                      );
                    },)
                  ],
                )))
      ],
    ));
  }
}
