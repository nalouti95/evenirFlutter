import 'package:evenirproject/DataBaseHelper.dart';
import 'package:flutter/material.dart';
class fovorisPage extends StatefulWidget {
  String email ;
  fovorisPage({Key key,this.email}): super(key: key);

  @override
  _fovorisPageState createState() => _fovorisPageState();
}

class _fovorisPageState extends State<fovorisPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(

        future: _getEvents() ,

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
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data[index]['img']),
                  ),
                  title: Text(snapshot.data[index]['titre']),
                  trailing: IconButton(icon:  Icon(Icons.delete),
                  onPressed: () async {
                    int rowsEffected = await DatabaseHelper.instance.Delete(snapshot.data[index]['_id']);
                    if(rowsEffected != null)
                        {
                          setState(() {

                          });
                        }

                  },

                  ),





                );
              } ,


            );
          }
        },


      ) ,
    );
  }

  Future <List<Map<String,dynamic >>> _getEvents()  async {

    List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.QueryAll();
    return queryRows;



  }
}
