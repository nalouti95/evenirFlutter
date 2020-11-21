import 'dart:convert';

import 'package:evenirproject/login.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import 'allEvent.dart';
import 'api.dart';

class addEventPage extends StatefulWidget {
  String email;
  addEventPage({Key key, this.email}) : super(key: key);

  @override
  _addEventPageState createState() => _addEventPageState();
}

class _addEventPageState extends State<addEventPage> {
  final _formKey = GlobalKey<FormState>();

  var _categories = [
    'Culture & Entertainment',
    'Sport & Health-care',
    'Nature & Adventure',
    'Commercial',
    'Politics',
    'Other'
  ];
  var _curentCategorySelected = 'Other';
  var _typesEvent = [
    'Picnics',
    'Product launch',
    'Festival',
    'Manifestation',
    'Charity',
    'Conference',
    'Other'
  ];
  var _curentTypeSelected = 'Other';

  var _priceVisible = true;
  var _placeVisible = true;



  DateTime _dateTime ;
  TimeOfDay _timeOfDay ;
  DateTime _dateTime2 ;
  TimeOfDay _timeOfDay2 ;

  String message = '';

  double duree = 0.0;
  double longi = 0.0;
  double lat = 0.0;


  String user = LoginPage.emailFinal;
  String capaciteF ;
  String montantF ;
  String categorieF ;
  String typeF ;
  String DateDebEvent ;
  String timeDebEvent ;
  String DatefinEvent ;
  String timefinEvent ;

  String titreF ;
  String descriptionF ;
  String placeF ;



  final TitreController = TextEditingController();
  final descriptionController = TextEditingController();

  final montantController = TextEditingController();
  final capacityController = TextEditingController();
  final destinationController = TextEditingController();


  //upload img variables

  String status = '';
  String base64Img;
  String fileName;
  File tempFile;
  String errmsg = 'Error uploding image';

  Future<File> imageFile;



  @override
  void dispose() {
    TitreController.dispose();
    descriptionController.dispose();
    montantController.dispose();
    capacityController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  chooseImage() {
    setState(() {
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

          return Image.file(
            snapshot.data,
            //fit: BoxFit.fill,
            height: 200,
            width: 400,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error picking image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('uploding image .....');
    if (null == tempFile) {
      setStatus(errmsg);
      return;
    }
    fileName = tempFile.path.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Center(child: Text('Add event')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 10.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: TitreController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return ('The Event can not be without title');
                    } else if (value.length < 3) {
                      return 'Title must be at least 3 characters long ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'The title of the Event',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descriptionController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return ('The Event can not be without title');
                    } else if (value.length < 10) {
                      return 'Description must be at least 10 characters long ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'The Description of the Event',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      value: _curentCategorySelected,
                      items: _categories.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._curentCategorySelected = newValueSelected;
                        });
                      },
                    ),
                    SizedBox(width: 20),
                    DropdownButton<String>(
                      value: _curentTypeSelected,
                      items: _typesEvent.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._curentTypeSelected = newValueSelected;
                        });
                      },
                    ),
                  ],
                ),
              ),
              OutlineButton(
                onPressed: chooseImage,
                child: Text('Choose Image for the event'),
              ),
              SizedBox(height: 20),
              showImage(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LiteRollingSwitch(
                    value: false,
                    textOff: "Not Free",
                    textOn: "Free",
                    colorOff: Colors.redAccent,
                    colorOn: Colors.greenAccent,
                    iconOn: Icons.done,
                    iconOff: Icons.attach_money,
                    textSize: 18.0,
                    onChanged: (bool position) {

                      if (position == true) {
                        _priceVisible = false;
                        montantF = "free";
                       setState(() {});


                      } else{
                        _priceVisible = true;
                      //setState(() {});
                      }

                    },
                  ),
                  SizedBox(width: 60),
                  LiteRollingSwitch(
                    value: false,
                    textOff: "Place",
                    textOn: "No Limit",
                    colorOff: Colors.redAccent,
                    colorOn: Colors.greenAccent,
                    iconOn: Icons.landscape,
                    iconOff: Icons.place,
                    textSize: 15.0,
                    onChanged: (bool position) {
                      if (position == true) {
                        print("the button is $position");
                        _placeVisible = false ;
                        capaciteF = "No limit ";

                   setState(() {});

                      } else
                        {
                          _placeVisible = true ;
                         // setState(() {});

                        }



                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              Visibility(
                visible: _priceVisible,
                child:   TextFormField(
                   controller: montantController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return ('The Event can not be without price');
                  }

                  return null;
                },
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'The Price of the Event',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
      ),
              SizedBox(height: 20),

              Visibility(
                visible: _placeVisible,
                child:
                TextFormField(
                  controller: capacityController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return ('The Event can not be without place');
                  }

                  return null;
                },
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                    labelText: 'Capcity',
                    hintText: 'The Capcity of the Event',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),

              ),

              SizedBox(height: 20),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  RaisedButton( child: Text('Day of Opening ')
                  ,onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030),



                                    ).then((date) {
                                            setState(() {
                                                _dateTime = date;
                                                DateDebEvent = _dateTime.day.toString() + '/' + _dateTime.month.toString() + '/'+_dateTime.year.toString();

                                                        });
                                    });


                    },
                    color: const Color(0xFF95DEDE),
                  ),
                  SizedBox(width: 40),

                  RaisedButton( child: Text('Time of Opening')
                    ,onPressed: () {
                                    showTimePicker(context: context,
                                   initialTime: TimeOfDay.now()

                                    ).then((time) {
                                      setState(() {
                                        _timeOfDay = time ;
                                        timeDebEvent = _timeOfDay.hour.toString() + ':'+ _timeOfDay.minute.toString();


                                      });
                                    } );



                    },
                    color: const Color(0xFF95DEDE),
                  ),

                ],

              ),



              SizedBox(height: 40),




              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  //  Text(_dateTime == null ? 'Nothing has been picked yet' : _dateTime.toString()),
                  RaisedButton( child: Text('Day of Closure')
                    ,onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),



                      ).then((date) {
                        setState(() {
                          _dateTime2 = date;
                          DatefinEvent = _dateTime2.day.toString() + '/' + _dateTime2.month.toString() + '/'+_dateTime2.year.toString();

                        });
                      });


                    },    color: const Color(0xFF95DEDE),
                  ),

                  SizedBox(width: 40),
                  RaisedButton( child: Text(' Time of Closure')
                    ,onPressed: () {
                      showTimePicker(context: context,
                          initialTime: TimeOfDay.now()

                      ).then((time) {
                        setState(() {
                          _timeOfDay2 = time ;
                          timefinEvent = _timeOfDay2.hour.toString() + ':'+ _timeOfDay2.minute.toString();

                        });
                      } );



                    },
                    color: const Color(0xFF95DEDE),
                  ),

                ],

              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: destinationController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return ('The Event can not be without adress');
                    } else if (value.length < 3) {
                      return 'Adress must be at least 3 characters long ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.streetAddress,

                  decoration: InputDecoration(
                      labelText: 'Adress',
                      hintText: 'The Adress of the Event',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),



            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            //ici ajout de event

            categorieF = _curentCategorySelected;
            typeF = _curentTypeSelected;

            print (user);
            print(TitreController.text);

            print(descriptionController.text);
            print(categorieF);
            print(typeF);

            //img
            print(base64Img);
            //
            if(_placeVisible == true)
              {
                capaciteF = capacityController.text;

              }else {
              capaciteF = ' No limit';
            }
            if(_priceVisible == true)
            {
              montantF = montantController.text;

            }else {
              montantF = ' free';
            }

            print(capaciteF);
            print(montantF);
            print(DateDebEvent);
            print(timeDebEvent);
            print(DatefinEvent);
            print(timefinEvent);
            print(destinationController.text);
print(duree);

            var resp  = await addEventttt(TitreController.text, categorieF, typeF, base64Img, montantF, descriptionController.text, capaciteF, DateDebEvent, timeDebEvent,'', DatefinEvent, timefinEvent, destinationController.text, user, '', '') ;
            print(resp);

            print(resp);

            if (resp.containsKey('success')) {
              if (resp['success'] == 1) {
                Navigator.pop(context);

              }
              if (resp['success'] == -1) {
                Navigator.pop(context);

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
        child:

        Icon(Icons.done),
      ),
    );
  }
}
