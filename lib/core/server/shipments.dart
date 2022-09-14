import 'dart:convert';

import 'package:dalile_customer/core/http/FromDalilee.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';

class ShipmentApi {
  static String mass = '';
  static bool checkAuth = false;
  static Future<Data?> fetchShipemetData(dynamic body) async {
    try {
      var response = await dalileePost("/shipmentsInOut", body);

      if (response.statusCode == 200) {
        var data = shipmentListingFromJson(response.body);
        return data.data;
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
