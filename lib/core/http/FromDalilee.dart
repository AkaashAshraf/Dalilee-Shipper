import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/model/login_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> dalileePost(String url, dynamic _body) async {
  var _url = dalileeOldBaseUrl + url;
  final prefs = await SharedPreferences.getInstance();

  var jsonString = prefs.getString('username');

  // final logindataModel = logindataModelFromJson(jsonString!);
  // print(logindataModel.data!.store!.userName);
  var body = {
    ..._body,
    "key": "shaheen-api090078601",
    "store_username": jsonString
  };
  try {
    var response = await http.post(Uri.parse(_url), body: body, headers: {
      "Accept": "application/json",
    });
    // print(response.body.toString());
    if (response.statusCode == 200) {
      return response;
    } else {
      return response;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}
