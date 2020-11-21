import 'package:http/http.dart' as http ;
import 'dart:convert';

Future LoginUser(String email, String password) async {

  String url = 'http://192.168.1.100/mesWebServices/login.php';
  final response =  await http.post(url,
    headers: {"Accept": "Application/json" },
    body: { 'email': email, 'password': password }

  );
  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson ;

}

Future SignInUser(String email, String password, String fullName, String image) async {

  String url = 'http://192.168.1.100/mesWebServices/addUserImg.php';
  final response =  await http.post(url,
      headers: {"Accept": "Application/json" },
      body: { 'email': email, 'password': password,'fullName': fullName, 'image': image }

  );
  var convertedDatatoJson2 = jsonDecode(response.body);
  return convertedDatatoJson2 ;

}
Future SignInUserFb(String email, String password, String fullName, String image) async {

  String url = 'http://192.168.1.100/mesWebServices/addUser.php';
  final response =  await http.post(url,
      headers: {"Accept": "Application/json" },
      body: { 'email': email, 'password': password,'fullName': fullName, 'image': image }

  );
  var convertedDatatoJson3 = jsonDecode(response.body);
  return convertedDatatoJson3 ;

}
Future getProfileinfo(String email) async {

  String url = 'http://192.168.1.100/mesWebServices/selectUsername.php';
  final response =  await http.post(url,
      headers: {"Accept": "Application/json" },
      body: { 'email': email}

  );
  var convertedDatatoJson3 = jsonDecode(response.body);
  return convertedDatatoJson3 ;

}

Future getAllEventApi(String email) async {

  String url = 'http://192.168.1.100/mesWebServices/selectAllEvent.php';
  final response =  await http.post(url,
      headers: {"Accept": "Application/json" },
      body: { 'email': email}

  );
  var convertedDatatoJson5 = jsonDecode(response.body);
  return convertedDatatoJson5 ;

}


Future addEventttt(String titre, String categorie, String type, String imgEvent, String montant, String description, String capacite, String dateDebEvent, String timeDebEvent, String duree, String dateFin, String timeFinEvent, String lieuEvent, String userMail, String latitude, String longtitude) async {

  String url = 'http://192.168.1.100/mesWebServices/addEvent.php';
  final response =  await http.post(url,
      headers: {"Accept": "Application/json" },
      body: { 'titre' : titre, 'categorie': categorie, 'type' :type, 'imgEvent' : imgEvent, 'montant' :montant, 'description' : description, 'capacite' :capacite, 'dateDebEvent' : dateDebEvent, 'timeDebEvent': timeDebEvent, 'duree' : duree, 'dateFin' : dateFin, 'timeFinEvent' : timeFinEvent, 'lieuEvent': lieuEvent, 'userMail' : userMail, 'latitude' : latitude, 'longtitude' :longtitude}

  );
  var convertedDatatoJson33 = jsonDecode(response.body);
  return convertedDatatoJson33 ;

}