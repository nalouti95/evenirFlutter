import 'dart:ffi';
import 'package:evenirproject/DataBaseHelper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'api.dart';
import 'login.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;



class AllEvent extends StatefulWidget {

  String email ;
  AllEvent({Key key,this.email}): super(key: key);


  @override
  _AllEventState createState() => _AllEventState();
}

class _AllEventState extends State<AllEvent> {

  String memail = LoginPage.emailFinal;

  Future< List<Event> > _getUsers() async {


    var jsonData = await getAllEventApi(memail);

    //print(jsonData[0]["titre"]);

    List<Event> events = [];

    for (var i = 0 ; i < jsonData.length ; i++ )
      {
        var u = jsonData[i];
        Event event = Event(int.parse(u["id"]), u["titre"], u["categorie"], u["type"], u["imgEvent"], u["montant"], u["description"], u["capacite"], u["dateDebEvent"], u["timeDebEvent"], u["duree"], u["dateFin"], u["timeFinEvent"], u["lieuEvent"], u["userMail"], u["latitude"], u["longtitude"]);
        events.add(event);

      }

    print(events.length);

    return events;

  }



  @override
  Widget build(BuildContext context) {
    return Container(

      child: FutureBuilder(

        future: _getUsers() ,

        builder: (BuildContext context, AsyncSnapshot snapshot ){
          //res is in snapshot


          if(snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Loading ..."),
              ),
            );
          }else{

          return ListView.builder(
              itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context , int index) {
                return ListTile(
                  leading:
                  Hero(
                    tag: snapshot.data[index],
                    child:  CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data[index].imgEvent),
                  ),
                  ),

                  title: Text(snapshot.data[index].titre),
                  subtitle: Text("From : "+snapshot.data[index].dateDebEvent + " ,To : "+ snapshot.data[index].dateFin),
                  onTap: () {
                    
                    Navigator.push(context, 
                    new MaterialPageRoute(builder: (context) => DetailEventPage(snapshot.data[index]) )
                    );
                    
                  },


                );
            } ,


             );
          }
        },


      ) ,





    );
  }
}

class DetailEventPage extends StatelessWidget {
  final Event event;
  DetailEventPage(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.titre),
        backgroundColor: const Color(0xFF372B4B),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
            children: <Widget>[
              Hero(
                tag: event,
                child: Image.network(event.imgEvent,width: 350)
              ),
             // Center(child: Image.network(event.imgEvent,width: 350)),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Text("description : " + event.description),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Text("category : " + event.categorie),
              SizedBox(height: 10),
              SizedBox(height: 10),

              Text("Type : " + event.type),
              SizedBox(height: 10),
              SizedBox(height: 10),

              Text("Price : " + event.montant),
              SizedBox(height: 10),
              SizedBox(height: 10),

              Text("Start : " + event.dateDebEvent + " at : "+ event.timeDebEvent),
              SizedBox(height: 10),
              SizedBox(height: 10),

              Text("End  : " + event.dateFin + " at : "+ event.timeFinEvent),
              SizedBox(height: 10),
              SizedBox(height: 10),

              Text("Place  : " + event.lieuEvent),
              SizedBox(height: 10),
              SizedBox(height: 10),

             // Text("Duration " + event.duree.toString()),
              SizedBox(height: 10),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,

                children: <Widget>[

                  FlatButton(
                    child: Text('Add to Favorite'),
                    color: const Color(0xFF95DEDE),
                    textColor: Colors.white,

                    onPressed: () async {

                      //ajout a la base de donnee interne

                      int i = await DatabaseHelper.instance.insert({

                        DatabaseHelper.columtitre : event.titre ,
                       DatabaseHelper.columimg : event.imgEvent

                      });

                      print('the inserted id is $i');

                      Alert(
                        context: context,
                        type: AlertType.success,
                        title: "Success",
                        desc: "this event is in now available in your favorits ",
                        style: AlertStyle(backgroundColor:  const Color(0xFF372B4B)),
                        buttons: [
                          DialogButton(
                            child: Text("ok ",style: TextStyle(color: Colors.black,fontSize: 20)
                            ),

                            onPressed: () => Navigator.pop(context),
                            width: 50,
                          )
                        ],

                      ).show();


                    },
                  ),
                  SizedBox(width: 150),

                  FlatButton(
                    child: Text('Contact'),
                    color: const Color(0xFF95DEDE),
                    textColor: Colors.white,

                    onPressed: () {
                      Alert(
                        context: context,
                        type: AlertType.success,
                        title: "Contact",
                        desc: "Contact this Mail : " +event.userMail + "  to get more info",
                        style: AlertStyle(backgroundColor:  const Color(0xFF372B4B)),
                        buttons: [
                          DialogButton(
                            child: Text("Ok",style: TextStyle(color: Colors.black,fontSize: 20)
                          ),
                              onPressed: () => Navigator.pop(context),
                          width: 50,
                          )
                        ],

                      ).show();


                    },
                  ),
                ],

              )





            ]

        ),
      ),

    );
  }
}



 class Event {
    final int id ;
    final String titre ;
    final String categorie ;
    final String type ;
    final String imgEvent ;
    final String montant ;
    final String description ;
    final String capacite ;
    final String dateDebEvent ;
    final String timeDebEvent ;
    final String duree ;
    final String dateFin ;
    final String timeFinEvent ;
    final String lieuEvent ;
    final String userMail ;
    final String latitude ;
    final String longtitude ;
    //final String dateAjout ;

    Event(this.id,this.titre,this.categorie,this.type,this.imgEvent,this.montant,this.description,this.capacite,this.dateDebEvent,this.timeDebEvent, this.duree,this.dateFin,this.timeFinEvent,this.lieuEvent,this.userMail,this.latitude,this.longtitude);

 }