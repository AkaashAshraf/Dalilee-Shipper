import 'dart:convert';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/model/out_in_shipments.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShipmentApi {
  static String mass = '';
  static bool checkAuth = false;
  static Future<Data?> fetchShipemetData(String tab,
      {String limit: "0"}) async {
    var url = "$like/runsheet/listing";
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }, body: {
        "tab": "$tab",
        "offset": limit
      });

      if (response.statusCode == 200) {
        var data = outAndInShipmentModelFromJson(response.body);
        print('mshagdjsagdfhjsagfhjgdsjhfghdgfhd:' + limit);
        // print(data?.data!.requests!.length.toString());
        return data.data;
      } else if (response.statusCode == 401) {
        checkAuth = true;
        var err = json.decode(response.body);

        mass = '${err["message"]}';
        prefs.remove("loginData");
        prefs.remove("token");
        return null;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error';
    }
    return null;
  }
}
