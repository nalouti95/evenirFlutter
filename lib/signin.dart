import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

import 'HomePage.dart';
import 'api.dart';
import 'custom_widgets.dart';
import 'login.dart';

import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameontroller = TextEditingController();

  String message = '';

  //upload img variables

  String status = '';
String base64Img ;
  String fileName;
File tempFile;
String errmsg = 'Error uploding image';



Future<File> imageFile;
  chooseImage()  {

    setState(()  {
      imageFile = ImagePicker.pickImage(source: ImageSource.gallery);

    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tempFile = snapshot.data;

          base64Img = base64Encode(snapshot.data.readAsBytesSync());


          return  Image.file(

              snapshot.data,
             //fit: BoxFit.fill,
              height: 100,
              width: 100,
            );


        }
        else if (null != snapshot.error){
          return const Text('Error picking image',textAlign: TextAlign.center,);

        }else {
          return const Text('No Image selected',textAlign: TextAlign.center,);

        }
      },
    );
  }
setStatus(String message ) {

  setState(() {
    status = message;
  });

  }

  startUpload() {

setStatus('uploding image .....');
    if(null == tempFile){
      setStatus(errmsg);
      return ;
    }
     fileName = tempFile.path.split('/').last;

  }







  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullnameontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: Column(
        children: <Widget>[

          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Form(
                    key: _formKey,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'FullName',
                              labelStyle: TextStyle(fontSize: 20)),
                          controller: fullnameontroller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),

                        //ici ajout bouton upload img
                        OutlineButton(
                          onPressed: chooseImage,
                          child: Text('Choose Image'),
                        ),
                        SizedBox(height: 20),

                        showImage(),

                        SizedBox(height: 20),

                        Text(
                          status,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                        CustomButton(
                          onBtnPressed: () async {
                            //signin  action

                            if (_formKey.currentState.validate()) {
                              var email = emailController.text;
                              var password = passwordController.text;
                              var fullName = fullnameontroller.text;
                              setState(() {
                                message = 'Please wait ...';
                              });
                              var resp = await SignInUser(email,password,fullName,base64Img);

                              print(resp);

                              if (resp.containsKey('success')) {
                                if (resp['success'] == 1) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  }));
                                }
                                if (resp['success'] == -1) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  }));

                                  //

                                  setState(() {
                                    message = 'already exist';
                                  });
                                }
                              } else {
                                setState(() {
                                  message = 'Login Failed !!';
                                });
                              }
                            }
                          },
                          btnText: 'SignIn',
                        ),
                        SizedBox(height: 10),
                        Text(message),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Already Member?'),
                            FlatButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return LoginPage();
                                      }));
                                },
                                child: Text(
                                  'just Login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor),
                                ))
                          ],
                        ),



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
