import 'dart:convert';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/model/branch_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BranchApi {
  static bool checkAuth = false;
  static String mass = '';
  static Future<BData?> fetchBranchData() async {
    var url = "$like/runsheet/branches";
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    // dynamic resLogin = json.decode(fromString!.toString());
    // dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        var data = branchListModelFromJson(response.body);

      
        if (data.data != null) {
          return data.data;
        } else if (response.statusCode == 401) {
        checkAuth = true;
         var err = json.decode(response.body);

        mass = '${err["message"]}';
         return null;
      } else {
          var err = json.decode(response.body);

          mass = '${err["message"]}';
        
          return null;
        }
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
