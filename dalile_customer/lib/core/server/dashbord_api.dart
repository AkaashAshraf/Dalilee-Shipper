import 'dart:convert';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/model/all_shipment.dart';
import 'package:dalile_customer/model/cancelled_shipment.dart';
import 'package:dalile_customer/model/delivered_shipment.dart';
import 'package:dalile_customer/model/finance_dashbord.dart';
import 'package:dalile_customer/model/return_shipment.dart';
import 'package:dalile_customer/model/to_be_delivered.dart';
import 'package:dalile_customer/model/to_be_picku.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class DashboardApi {
  static String mass = '';
  static bool checkAuth = false;
  static Future<FinanceDashbordData?> fetchFinanceDashData() async {
    var url = "$like/dashboard/finance";
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        var data = financeDashModelFromJson(response.body);

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

  static Future<AllDashbordModel?> fetchAllShipemetData(type) async {
    var url = "$like/dashboard/$type";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        var data = dashbordAllModelFromJson(response.body);

        return data;
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

  static Future<DeliveredDashbordModel?> fetchDeliveredShipemetData() async {
    var url = "$like/dashboard/delivered-shipments";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        var data = dashbordDeliveredShipmentModelFromJson(response.body);

        return data;
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

  static Future<RetrunDashbordModel?> fetchRetrunShipemetData() async {
    var url = "$like/dashboard/returned-shipments";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        var data = dashbordRetrunShipmentModelFromJson(response.body);

        return data;
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

  static Future<ToBeDeliveredDashbordModel?> fetchTobeDeliveredData() async {
    var url = "$like/dashboard/to-be-delivered";
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        var data = dashbordToBeDeliveredModelFromJson(response.body);

        return data;
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

  static Future<ToBePickupData?> fetchTobePickupData() async {
    var url = "$like/dashboard/to-be-pickups";
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        var data = toBePickUpdashbordModelFromJson(response.body);

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

  static Future<CancellDashbordModel?> fetchCancellShipemetData() async {
    var url = "$like/dashboard/cancel-shipments";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        var data = dashbordCancellModelFromJson(response.body);

        return data;
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
