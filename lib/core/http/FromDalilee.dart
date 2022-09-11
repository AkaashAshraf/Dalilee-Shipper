import 'package:dalile_customer/constants.dart';
import 'package:http/http.dart' as http;

Future<dynamic> dalileePost(String url, dynamic _body) async {
  var _url = dalileeOldBaseUrl + url;
  var body = {
    ..._body,
    "key": "shaheen-api090078601",
    "store_username": "dubai"
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
    return e;
  }
}
