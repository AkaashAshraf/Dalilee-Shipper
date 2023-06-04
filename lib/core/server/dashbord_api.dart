import 'dart:convert';
import 'dart:developer';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/Dashboard/FinanceDashboardModel.dart';
import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment_listing.dart';

abstract class DashboardApi {
  static String mass = '';
  static bool checkAuth = false;
  static Future<FinanceStats?> fetchFinanceDashData() async {
    try {
      var response = await get(
        "/dashboard/finance",
      );
      // print("--------------------");
      inspect(response);
      if (response != null) {
        var data = financeMainDashboardModelFromJson(response.body);
        // inspect(data.data!.stats);
        return data.data!.stats!;
      }
    } catch (e) {
      mass = 'Network error';
      return null;
    }
    return null;
  }

  static fetchShipmentList(dynamic body) async {
    var response = await post("/dashboard/shipments", body);
    if (response == null) return;
    if (response.statusCode == 200) {
      var data = shipmentListAwsFromJson(response.body);

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
    // } catch (e) {
    //   print(e.toString());
    //   mass = 'Network error' + e.toString();
    // }
    // return null;
  }

// ////main dashboard data
  static Future<MainDashboard?> fetchMainDashBoardData(type) async {
    try {
      final response = await get("/dashboard/shipments-count");
      inspect(response);
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
