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
import 'package:dalile_customer/model/enquiry_model.dart';
import 'package:dalile_customer/model/finance_open_model.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment_listing.dart';
import 'package:dalile_customer/model/sub_cat_list_model.dart';
import 'package:flutter/material.dart';
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

  static Future<CloseData?> fetchCloseData(dynamic body) async {
    try {
      final response = await dalileePost("/closeFinance", body);
      if (response.statusCode == 200) {
        var data = closedFinanceListModelFromJson(response.body);

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

  static Future<String?> fetchPDFCloseData(id, {required String type}) async {
    var url = "$like/pickup/export-invoice-pdf";
    final prefs = await SharedPreferences.getInstance();

    dynamic fromString = prefs.getString('loginData') ?? '';

    dynamic resLogin = json.decode(fromString!.toString());
    dynamic tokenLo = resLogin['data']["access_token"] ?? '';
    try {
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxNyIsImp0aSI6ImFhOGJlOTFkNzU5MDhiOGE4ZjllYTc5OWQ5YWQ3YWU5N2E5MzQ1MWVkNzA5OWRjMTgwMjM4ZmYxNWM3ZDYwZWQwZWFmYjhmYzZkZWM5YjRkIiwiaWF0IjoxNjczNzMyNDY5LCJuYmYiOjE2NzM3MzI0NjksImV4cCI6MTcwNTI2ODQ2OSwic3ViIjoiMTQ1ODIyIiwic2NvcGVzIjpbXX0.EDn8f3RAEQorGsPdF8rLClLirtNgA685bjCRuGzzl6Ay5OuEKerWpIdTTd4ebAiuLsUTGw3-zKd5NkIyzeWZSP70_effGPpBXcrkNGzS5Kq-iLzSXdrGvkWB5NdBeazYONl2_QG119vaa27BuFVfIZ4lD8uTbBLqLDXU1kdhTVktZeEBAxFCX_dyKjOejguU8rCWCeIDGqLgXVmSp5ON0CtOPjo7uSeFo5bcZ6_iW4x0IBJYizr_beBnG3_gGuH9M0t9wEaCEtJ-FvvLsGz_S36YgvspsPoOh2kUeX-a-BmboOR7uErz1Ck_p993h-Xnuh2r3e8j0Recdkncy9tpmrSzuK9hKlGOGeU1GzBTp4zyoqGS37fmwC0WBh8ofRQHcS1MAJ1FsGiYor8T93MwK35MuDwPed9YdwLt3QhlLeGaGd257MRELAuqISkpcdx2JgsoMio7J8Lsjc9e3bWGiMMrhOxGoHcNbDz-MzrYCh7MnzT2D0IXJVcTVqoXxFVOTLgbsqlSRNgblYI4o5U-4PoTQNOU1LTyAMYmUR015x7EoIko3znWhmtAsZ4JUzlazKtmYlZitdE6SKN1xy2cBBB4-fSZHDdUXpgowALnoRMGwGYTU4Fo4ynhGUyEWDSpoEtWYgjguXoCoIWABQPtzF1Vuo7Lu1q6ezN4OyieaSM"
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

  static Future<dynamic> fetchAddEnquiryData({
    required String accountId,
    required String description,
    required String amount,
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
        "trader_id": storeId,
        "decription": description,
        "trader_account_id": accountId,
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
      mass = 'Network error' + e.toString();
      return null;
    }
  }
}
