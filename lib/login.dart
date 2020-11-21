import 'package:evenirproject/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'HomePage.dart';
import 'api.dart';
import 'signin.dart';

class LoginPage extends StatefulWidget {
  static String emailFinal = '';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';
  String fbName = '';
  String fbemail = '';
  String fbpass = '';
  String Fburlimg = '';


//fb variables
  bool isLoggedInFb = false;
  Map userProfile ;
  final facebookLogin = FacebookLogin();
  _loginWithFb() async{
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        //info
        fbName = profile['name'];
        fbemail = profile['email'];
        fbpass = profile['id'];
        Fburlimg = profile['picture']['data']['url'];

        print(Fburlimg);
        await SignInUserFb(fbemail,fbpass,fbName,Fburlimg);


        setState(() {
          userProfile = profile;
          isLoggedInFb = true;
          LoginPage.emailFinal = fbemail ;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => isLoggedInFb = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => isLoggedInFb = false );
        break;
    }

  }

  _logOut()
  {
    facebookLogin.logOut();
    setState(() {
      isLoggedInFb = false;
    });
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: Column(
        children: <Widget>[
          HeroImage(
            imgheight: MediaQuery.of(context).size.height * 0.35,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 20)),
                          controller: emailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 20)),
                          controller: passwordController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        CustomButton(
                          onBtnPressed: () async {
                            //login action
                            if (_formKey.currentState.validate()) {
                              var email = emailController.text;
                              var password = passwordController.text;
                              setState(() {
                                message = 'Please wait ...';
                              });

                              var resp = await LoginUser(email, password);
                              print(resp);

                              if (resp.containsKey('success')) {

                                setState(() {
                                  LoginPage.emailFinal = email;
                                  message = email + "is connected !!" ;
                                });


                                if (resp['success'] == 1) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return HomePage(emailFinalH: LoginPage.emailFinal);

                                  }));

                                }

                              } else {
                                setState(() {
                                  message = 'Login Failed !!';
                                });
                              }
                            }
                          },
                          btnText: 'Login',
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('new user?'),
                            FlatButton(
                                onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return SigninPage();

                                  }));


                                },
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor),
                                ))
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(message),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            //login fb

                          IconButton  (
                              icon: Image.asset('assets/fbb.png'),
                              iconSize: 40,
                              onPressed: () async {
                                _loginWithFb();
                              await  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return HomePage(emailFinalH: LoginPage.emailFinal);
                                    }));

                              },

                          ),


                            SizedBox(width: 10),
                            IconButton(
                              icon: Image.asset('assets/g+.png'),
                              iconSize: 40,
                              onPressed: () {
                              },

                            ),



                            SizedBox(width: 10),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
