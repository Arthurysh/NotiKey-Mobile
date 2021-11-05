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
      print(response.body);

      if (response.body != null) {
        userData = json.decode(response.body);
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
}
