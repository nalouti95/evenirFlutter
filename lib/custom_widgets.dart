import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final double imgheight;
  HeroImage({this.imgheight});

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Image.asset('assets/logo.png'),
        width: MediaQuery.of(context).size.width,
        height: imgheight

        );
  }
}

class CustomButton extends StatelessWidget {

  final String btnText ;
  final Function onBtnPressed;
  CustomButton({this.btnText, this.onBtnPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              btnText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 10),
            //Icon(Icons.arrow_forward)
          ],
        ),
      ),
      onPressed: onBtnPressed,
      color: Theme.of(context).primaryColor,
    );
  }
}



class SocialIcon extends StatelessWidget {
  final String iconname;
  SocialIcon({this.iconname});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(iconname),
      width: 40,
      height: 40,

    );
  }
}

class CustomButtonS extends StatelessWidget {

  final String btnText ;
  final Function onBtnPressed;
  CustomButtonS({this.btnText, this.onBtnPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              btnText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 10),
            //Icon(Icons.arrow_forward)
          ],
        ),
      ),
      onPressed: onBtnPressed,
      color: Theme.of(context).primaryColor,
    );
  }
}


