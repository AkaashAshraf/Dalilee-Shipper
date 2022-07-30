import 'dart:convert';
import 'package:dalile_customer/core/view_model/ticket_details_model_vew.dart';
import 'package:dalile_customer/model/complain_type_model.dart';
import 'package:dalile_customer/model/complian_model.dart';
import 'package:dalile_customer/model/ticket_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class ComplainApi {
  static String mass = '';
  static bool checkAuth = false;
  static Future<List<Ticket>?> fetchComplainData(stats) async {
    var url = "https://shaheen-test2.dalilee.om/api/tickets/list-tickets";
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    try {
      var response = await http.post(Uri.parse(url), body: {
        "user_id": "1",
        "offset": "0",
        "limit": "10000000",
        "status": "$stats"
      }, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        var data = complainListModelFromJson(response.body);

        if (data.tickets == null) return null;

        return data.tickets;
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

  static Future<TicketTypeModel?> fetchTypeListData() async {
    try {
      var url = "https://shaheen-test2.dalilee.om/api/tickets/list-categories";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = ticketTypeModelFromJson(response.body);

        return data;
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

  static Future<dynamic> fetchCreateComplainData(
      orderId, complianID, nameType, dsec) async {
    var url = "https://shaheen-test2.dalilee.om/api/tickets/create-ticket";
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    String token = prefs.getString('token') ?? '';

    dynamic cratorId = resLogin['data']["store"]["user_id"] ?? '';

    try {
      var response = await http.post(Uri.parse(url), body: {
        "category_id": "$complianID",
        "subject": "$orderId $nameType", // order num + cat name
        "status": "1",
        "priority": "1",
        "creator_id": "$cratorId",

        "user_id": "$cratorId",
        "description": "$dsec",
        if (orderId.isEmpty) "order_id": "$orderId",
      }, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['success'];
      } else if (response.statusCode == 401) {
        checkAuth = true;
        var err = json.decode(response.body);

        mass = '${err["message"]}';
        prefs.remove("loginData");
        prefs.remove("token");
        return null;
      } else {
        var err = json.decode(response.body);
        mass = '${err["error"]["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error';

      return null;
    }
  }

  static Future<dynamic> fetchCreateCommentData(
      String ticketId, String bodyText, List<ImageFile> file) async {
    var url = "http://shaheen-test2.dalilee.om/api/tickets/create-comment";
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    try {
      var req = http.MultipartRequest("POST", Uri.parse(url));
      req.fields["ticket_id"] = "7";
      req.fields["body"] = "$bodyText";
      req.headers["Authorization"] = "Bearer $token";
      for (int x = 0; x < file.length; x++) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          "files[$x]",
          file[x].file.path,
          filename: file[x].name,
        );
        req.files.add(multipartFile);
      }

      final responseb = await req.send();

     
      if (responseb.statusCode == 200) {
     
        return true;
      } else {
        mass = 'filed uplode';

        return null;
      }
    } catch (e) {
      mass = 'Network error';

      return null;
    }
  }

  static Future<TicketDetailsModel?> fetchTicketDetailsData(stats) async {
    var url = "https://shaheen-test2.dalilee.om/api/tickets/ticket-details";

    try {
      var response = await http.post(Uri.parse(url), body: {
        "id": "$stats"
      }, headers: {
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        var data = ticketDetailsModelFromJson(response.body);

        return data;
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
