import 'dart:convert';
import 'dart:developer';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/http/FromDalilee.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/add_inqury_list_caterogry_model.dart';
import 'package:dalile_customer/model/bank_model.dart';
import 'package:dalile_customer/model/close_finance_model.dart';
import 'package:dalile_customer/model/crm/account_enquiries.dart';
import 'package:dalile_customer/model/crm/bank_accounts.dart';
import 'package:dalile_customer/model/crm/general_response.dart';
import 'package:dalile_customer/model/finance_open_model.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment_listing.dart';
import 'package:dalile_customer/model/sub_cat_list_model.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class FinanceApi {
  static String mass = '';
  static bool checkAuth = false;
  static Future<OpenData?> fetchopenData() async {
    try {
      final response = await post("/finance/open", {});
      if (response.statusCode == 200) {
        var data = financeOpenModelFromJson(response.body);

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

  static Future<Data?> fetchViewOrdersData(dynamic body,
      {required String url}) async {
    try {
      var response = await post(url, body);
      if (response.statusCode == 200) {
        var data = shipmentListAwsFromJson(response.body);

        return data?.data;
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

  static Future<Bankaccounts?> fetchManageAccountData() async {
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    String _url = "$crmBaseUrl/accounts/my_list";

    try {
      final prefs = await SharedPreferences.getInstance();
      String storeCode = prefs.getString('store_code') ?? '';
      var response = await http.post(
        Uri.parse(_url),
        body: {"trader_id": storeCode},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $tokenLo",
        },
      );
      if (response.statusCode == 200) {
        var data = bankaccountsFromJson(response.body);
        inspect(data);

        return data;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error' + e.toString();
    }
    return null;
  }

  static Future<List<Enquiry>?> fetchEnquiryFinanceData() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';
    String storeID = prefs.getString('store_code') ?? '';

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());

    dynamic _id = resLogin['data']["store"]["user_id"] ?? '';

    var url = crmBaseUrl + "/account-enq/fetch-all";
    // "https://shaheen-test2.dalilee.om/api/inquiry/customer/listing/$_id";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {"trader_id": storeID},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var data = accountEnquiriesFromJson(response.body);
        return data!.data;
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
    // inspect({
    //   "bank_id": bankID,
    //   "name": name,
    //   "account_type": "Payable",
    //   "account_no": bankNo,
    //   "trader_id": traderId
    // });
    // return false;
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    var url = "$crmBaseUrl/account/create";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {
          "bank_id": bankID,
          "name": name,
          "account_type": "Payable",
          "account_no": bankNo,
          "trader_id": traderId
        },
      );
      inspect(response);
      if (response.statusCode == 200) {
        return true;
      } else {
        var err = json.decode(response.body);

        mass = err["message"];

        return false;
      }
    } catch (e) {
      mass = 'Network error' + e.toString();

      return false;
    }
  }

  static Future<ClosingData?> fetchCloseData(dynamic body) async {
    try {
      final response = await post("/finance/close", body);
      inspect(response);
      if (response.statusCode == 200) {
        var data = closedFinanceListModelFromJson(response.body);

        return data.data;
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      mass = 'Network error' + e.toString();
    }
    return null;
  }

  static Future<String?> fetchPDFCloseData(id, {required String type}) async {
    var url = "$like/pickup/export-invoice-pdf";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print(token);
    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }, body: {
        "invoice_id": "$id",
        "type": type
      });
      inspect(response);
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

  static Future<String?> fetchCSVCloseData(id,
      {bool isAllOrders = false}) async {
    var url = isAllOrders
        ? "$like/dashboard/export?type=pdf&module=shipper_self_orders&email=0"
        : "$like/dashboard/export?type=csv&email=0&module=invoice_shipments&invoice_id=${id.toString()}";
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
      inspect(response);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return data["data"]["url"];
      } else {
        var err = json.decode(response.body);

        mass = '${err["message"]}';

        return null;
      }
    } catch (e) {
      print(e.toString());
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

  static Future<Crmgenralresponse> addEnquiryData({
    required String accountId,
    required String otp,
    required String description,
    required String amount,
    required BuildContext context,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    String userNAme = prefs.getString('name') ?? '';
    String mobile = prefs.getString('mobile') ?? '';
    String storeId = prefs.getString('store_code') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';

    var _url = crmBaseUrl + '/create/account/Enquiry';
    // "https://shaheen-test2.dalilee.om/api/inquiry/customre-inquiry/create";

    try {
      var response = await http.post(Uri.parse(_url), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokenLo"
      }, body: {
        "estimated_amount": amount,
        "trader_name": userNAme,
        "trader_contact": mobile,
        "otp": otp,
        "trader_id": storeId,
        "decription": description,
        "trader_account_id": accountId,
      });
      // inspect(response);
      if (response.statusCode == 200) {
        var data = crmgenralresponseFromJson(response.body);
        // if (data.status == 0)
        // {
        //   showDialog(
        //       barrierDismissible: true,
        //       barrierColor: Colors.transparent,
        //       context: context,
        //       builder: (BuildContext context) {
        //         return CustomDialogBoxAl(
        //           title: "done".tr,
        //           des: "enq_addedd".tr,
        //           icon: Icons.priority_high_outlined,
        //         );
        //       });
        // }
        // inspect(data);
        // showDialog(
        //     barrierDismissible: true,
        //     barrierColor: Colors.transparent,
        //     context: context,
        //     builder: (BuildContext context) {
        //       return Text(
        //         data["message_en"],
        //         style: TextStyle(color: Colors.red),
        //       );
        //     });
        // Get.snackbar('Failed'.tr, "jgchjdgchjdghcgdhjg", colorText: Colors.red);
        return data;
      } else {
        var err = json.decode(response.body);
        mass = '${err["message"]}';

        return Crmgenralresponse();
      }
    } catch (e) {
      mass = 'Network error' + e.toString();
      return Crmgenralresponse();
    }
  }

  static sendOtpForEnquiry() async {
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    // String mobile = prefs.getString('mobile') ?? '';
    String storeId = prefs.getString('store_code') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    String mobile = (resLogin['data']["store"]["country_code"] ?? "") +
        (resLogin['data']["store"]["mobile"] ?? "");
    var _url = crmBaseUrl + '/shipper/send-otp/$mobile/$storeId';
    print(_url);
    try {
      await http.post(Uri.parse(_url), headers: {
        "Accept": "application/json",
      }, body: {});
    } catch (e) {
      inspect(e);
    }
  }
}
