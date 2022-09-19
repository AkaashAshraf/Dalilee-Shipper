import 'dart:convert';
import 'dart:developer';
import 'package:dalile_customer/core/http/FromDalilee.dart';
import 'package:dalile_customer/model/Dashboard/FinanceDashboardModel.dart';
import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';

abstract class DashboardApi {
  static String mass = '';
  static bool checkAuth = false;
  static Future<FinanceStats?> fetchFinanceDashData() async {
    try {
      var response = await dalileePost("/storeFinanceDashboard", {});
      if (response != null) {
        var data = financeMainDashboardModelFromJson(response.body);
        return data.data!.stats!;
      }
    } catch (e) {
      mass = 'Network error';
      return null;
    }
    return null;
  }

  static Future<ShipmentListing?> fetchShipmentList(dynamic body) async {
    try {
      var response = await dalileePost("/getStoresOrders", body);
      if (response.statusCode == 200) {
        var data = shipmentListingFromJson(response.body);

        return data;
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
    } catch (e) {
      print(e.toString());
      mass = 'Network error' + e.toString();
    }
    return null;
  }

// ////main dashboard data
  static Future<MainDashboard?> fetchMainDashBoardData(type) async {
    try {
      final response = await dalileePost("/getStoresOrdersCount", {});
      log("------------>$response");
      if (response != null) {
        var data = mainDashboardFromJson(response.body);

        return data;
      }
    } catch (e) {
      mass = 'Network error';
    }
    return null;
  }
}
