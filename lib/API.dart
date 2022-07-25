import 'dart:convert';

import 'package:http/http.dart' as http;
import '../API.dart';

class CallApi{
  final String _url = "http://10.0.2.2:5000/";
      //"https://arabic-sentimental.herokuapp.com/";
  postData(data) async{
    var fullUrl = _url;
   return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders()=>{
    'Content-type':'application/json',
    'Accept':'application/json',
  };
}