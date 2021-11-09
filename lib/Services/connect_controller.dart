import 'dart:convert';
import 'package:http/http.dart' as http;

class ConnectController {
  Future<Map> sendData(url, data) async {
    Map userData = {};
    try {
      var response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {"content-type": "application/json"},
      );
      print("Status: ${response.statusCode}");
      // print(response.body);

      if (response.body != null) {
        userData = json.decode(response.body);
        print(json.decode(response.body));
      }
      return userData;
    } catch (error) {
      print(error);
    }
    return userData;
  }

  Future<Map> startMethod(url, data) async {
    return await sendData(url, data);
  }

  Future<Map> getData(String url, data) async {
    Map userData = {};

    String parametrs = '?';

    data.forEach((key, value) {
      if (data.keys.length == 1) {
        parametrs += '$key=$value';
      } else {
        parametrs += '$key=$value&';
      }
    });

    print(url + parametrs);

    try {
      var response = await http.get(
        url + parametrs,
      );
      print("Status: ${response.statusCode}");

      if (response.body != null) {
        userData = json.decode(response.body)[0];
      }
      return userData;
    } catch (error) {
      print(error);
    }
    return userData;
  }

  Future<Map> startGetMethod(String url, data) async {
    return await getData(url, data);
  }
}
