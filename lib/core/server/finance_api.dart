import 'dart:convert';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/model/add_inqury_list_caterogry_model.dart';
import 'package:dalile_customer/model/bank_model.dart';
import 'package:dalile_customer/model/close_finance_model.dart';
import 'package:dalile_customer/model/enquiry_model.dart';
import 'package:dalile_customer/model/finance_open_model.dart';
import 'package:dalile_customer/model/manage_account_model.dart';
import 'package:dalile_customer/model/sub_cat_list_model.dart';
import 'package:dalile_customer/model/view_orders_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class FinanceApi {
  static String mass = '';
  static bool checkAuth = false;
  static Future<OpenData?> fetchopenData() async {
    var url = "$like/runsheet/open-finance";
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokenLo"
      });
      if (response.statusCode == 200) {
        var data = financeOpenModelFromJson(response.body);

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

  static Future<ViewOrderData?> fetchViewOrdersData({limit: '0'}) async {
    var url = "$like/runsheet/open-finance-orders?offset=${limit}";
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokenLo"
      });
      if (response.statusCode == 200) {
        var data = orderViewListModelFromJson(response.body);

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

  static Future<Data?> fetchManageAccountData() async {
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    String _url = "$like/bank-accounts";

    try {
      var response = await http.get(
        Uri.parse(_url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $tokenLo",
        },
      );
      if (response.statusCode == 200) {
        var data = manageAccountModelFromJson(response.body);

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

  static Future<List<EnquiryList>?> fetchEnquiryFinanceData() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';
    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());

    dynamic _id = resLogin['data']["store"]["user_id"] ?? '';

    var url = base_url + "/inquiry/customer/listing/$_id";
    // "https://shaheen-test2.dalilee.om/api/inquiry/customer/listing/$_id";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        var data = enquiryModelFromJson(response.body);
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
        mass = '${err["message"]}' + response.statusCode.toString();
        return null;
      }
    } catch (e) {
      mass = 'Network error';
      return null;
    }
  }

  static Future<bool?> fetchAddAccountData(String traderId, String bankID,
      String bankName, String bankNo, String name) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    var url = "$like/bank-accounts/store";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {
          "bank_name": "$bankName",
          "holder_name": name,
          "account_number": bankNo,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        var err = json.decode(response.body);

        mass = err["message"];

        return false;
      }
    } catch (e) {
      mass = 'Network error';

      return false;
    }
  }

  static Future<CloseData?> fetchCloseData() async {
    var url = "$like/runsheet/close-finance";
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokenLo"
      });
      if (response.statusCode == 200) {
        var data = closedFinanceListModelFromJson(response.body);

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

  static Future<String?> fetchPDFCloseData(id) async {
    var url = "$like/pickup/export-invoice-pdf";
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokenLo"
      }, body: {
        "invoice_id": "$id"
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return data["data"]["url"];
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

  static Future<List<CatList>?> fetchCatList() async {
    var _url = base_url + '/inquiry/main-category/listing';
    // "https://shaheen-test2.dalilee.om/api/inquiry/main-category/listing";
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic _tokenLo = resLogin['data']["access_token"] ?? '';
    try {
      var response = await http.get(
        Uri.parse(_url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $_tokenLo"
        },
      );
      if (response.statusCode == 200) {
        var data = addInquiryListCattModelFromJson(response.body);

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

  static Future download({url}) async {
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      ;
    }
  }

  static Future<List<SubCatList>?> fetchSubCatList(id) async {
    var _url = base_url + '/inquiry/sub-category/listing';
    // "https://shaheen-test2.dalilee.om/api/inquiry/sub-category/listing";
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic _tokenLo = resLogin['data']["access_token"] ?? '';
    try {
      var response = await http.post(Uri.parse(_url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $_tokenLo"
      }, body: {
        "id": "$id"
      });
      if (response.statusCode == 200) {
        var data = addInquiryListSubCattModelFromJson(response.body);

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

  static Future<List<BankListModel>?> fetchBankListData() async {
    Set<Map<String, Object>> bankList = {
      {"name": "Bank Muscat", "id": 1},
      {"name": "NBO", "id": 2},
      {"name": "Nizwa Bank", "id": 3},
      {"name": "BankDhofar", "id": 4},
      {"name": "Alizz Islamic Bank", "id": 5},
      {"name": "Oman Arab Bank", "id": 6},
      {"name": "Al-AhliBank", "id": 7},
      {"name": "Bank Sohar", "id": 8},
      {"name": "Other", "id": 9}
    };
    List<BankListModel> data = bankListModelFromJson(bankList);

    return data;
  }

  static Future<dynamic> fetchAddEnquiryData(
    cat,
    subcat,
    doc,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    var _url = base_url + '/inquiry/customre-inquiry/create';
    // "https://shaheen-test2.dalilee.om/api/inquiry/customre-inquiry/create";

    try {
      var response = await http.post(Uri.parse(_url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokenLo"
      }, body: {
        "selectedCategory": "$cat",
        "selectedSubcategory": "$subcat",
        "comment": "$doc",
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return data["status"];
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
}
