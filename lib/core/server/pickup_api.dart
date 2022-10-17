import 'dart:convert';
import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/http/FromDalilee.dart';
import 'package:dalile_customer/model/Pickup/PickupModel.dart';
import 'package:dalile_customer/model/muhafaza_model.dart';
import 'package:dalile_customer/model/pickup_deatils.dart';
import 'package:dalile_customer/model/region_model.dart';
import 'package:dalile_customer/model/wilayas_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PickupApi {
  static String mass = '';
  static String success = '';
  static bool checkAuth = false;
  static Future<PickupDetailsModel?> fetchPickupDetailsData(refid) async {
    try {
      var response =
          await dalileePost("/collectionOrders", {"collection_id": refid});
      if (response.statusCode == 200) {
        var data = pickupDetailsModelFromJson(response.body);

        return data;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error';
      return null;
    }
  }

  static Future<MuhafazaModel?> fetchMuhafazaData() async {
    var url = "$like/pickup/governates";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        var data = muhafazaModelFromJson(response.body);

        return data;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error';
      return null;
    }
  }

  static Future<bool> fetchlocationData(lat, lng) async {
    var url = "$like/pickup/create-pickup";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      }, body: {
        "lat": "$lat",
        "lng": "$lng"
      });
      // log(response.toString());
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        success = '${data["message"] ?? "has been added"}';

        return true;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return false;
      }
    } catch (e) {
      mass = 'Network error';
      return false;
    }
  }

  static Future<WilayasModel?> fetchWilayaData(muhafazaid) async {
    var url = "$like/pickup/wilaya-list";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }, body: {
        "governate_id": muhafazaid > 0 ? muhafazaid.toString() : ""
      });
      // print(response.body);
      if (response.statusCode == 200) {
        var data = wilayasModelFromJson(response.body);

        return data;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error';
      // print(e.toString());
      return null;
    }
  }

  static Future<Data?> fetchAllPickupData(String date,
      {bool isRefresh = false, int listLength = 0, required String tab}) async {
    var offset = listLength.toString();
    var limit = "50";
    if (isRefresh) {
      offset = "0";
      limit = "50";
    }

    try {
      var body = {
        "offset": offset,
        "limit": limit,
        "tab": tab,
      };
      // print(body);
      var response = await dalileePost("/traderPickup", body);
      if (response.statusCode == 200) {
        var data = pickupModelFromJson(response.body);

        return data.data;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error';
      return null;
    }
  }

  static Future<RegionModel?> fetchRegionData(wid) async {
    var url = "$like/pickup/area-list-by-wilaya";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }, body: {
        "wilaya_id": "$wid"
      });
      if (response.statusCode == 200) {
        var data = regionModelFromJson(response.body);

        return data;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';
        return null;
      }
    } catch (e) {
      mass = 'Network error';
      return null;
    }
  }

  static Future<dynamic> fetchPriceValueData(wid, weight) async {
    var url = "$like/runsheet/calculate-price";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      }, body: {
        "area_id": "$wid",
        "weight": "$weight",
        "type": "1",
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return data;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error';
    }
  }

  static Future<bool?> fetchPostRequestPickupData(storeId, wid, rId) async {
    var url = "$like/pickup/request-pickup";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }, body: {
        "store_id": "$storeId",
        "wilaya_id": "$wid",
        "area_id": "$rId",
      });
      if (response.statusCode == 200) {
        var mass = json.decode(response.body);
        if (mass['message'] == "The reference has been created") {
          return true;
        } else {
          var err = json.decode(response.body);

          mass = '${err["message"]}';

          return false;
        }
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return false;
      }
    } catch (e) {
      mass = 'Network error';

      return false;
    }
  }
}
