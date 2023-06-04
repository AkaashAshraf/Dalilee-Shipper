import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperController extends GetxController {
  RxString currency = "omr".obs;
  RxList<TrackingStatus> trackingStatuses = [
    TrackingStatus(
        id: 1,
        statusEng: "pickup",
        icon: "https://shaheenom.com/storage/order-icons/pickup.png"),
    TrackingStatus(
        id: 2,
        statusEng: "send in branch",
        icon: "https://shaheenom.com/storage/order-icons/send.png"),
    TrackingStatus(
        id: 3,
        statusEng: "received in branch",
        icon: "https://shaheenom.com/storage/order-icons/received.png"),
    TrackingStatus(
        id: 4,
        statusEng: "order assigned",
        icon: "https://shaheenom.com/storage/order-icons/assigned.png"),
    TrackingStatus(
        id: 5,
        statusEng: "in process",
        icon: "https://shaheenom.com/storage/order-icons/process.png"),
    TrackingStatus(
        id: 7,
        statusEng: "canceled",
        icon: "https://shaheenom.com/storage/order-icons/canceled.png"),
    TrackingStatus(
        id: 8,
        statusEng: "un delivered",
        icon: "https://shaheenom.com/storage/order-icons/un-delivered.png"),
    TrackingStatus(
        id: 9,
        statusEng: "delivered",
        icon: "https://shaheenom.com/storage/order-icons/delivered.png"),
  ].obs;
  String getCurrencyInFormat(dynamic amount) {
    if (currency.value == "aed") {
      return ((double.tryParse(amount.toString()) ?? 0) * omrToAedRate)
              .toStringAsFixed(2) +
          " " +
          "aed".tr;
    }
    return (double.tryParse(amount.toString()) ?? 0).toStringAsFixed(3) +
        " " +
        "omr".tr;
  }

  int getStatusCode(String statusKey) {
    // return 6;
    switch (statusKey) {
      case "uc":
        return 6;

      case "se":
        return 5;

      case "RTO":
        return 7;

      case "RISS":
        return 3;

      case "review":
        return 5;

      case "return":
        return 7;

      case "reschedule":
        return 6;

      case "receivedbybranch":
        return 3;

      case "pickupbydriver":
        return 1;

      case "OFD":
        return 4;

      case "ndr":
        return 7;

      case "NA":
        return 6;

      case "logsheetconfirm":
        return 1;

      case "intransit":
        return 2;

      case "intercept":
        return 5;

      case "I":
        return 0;

      case "FW":
        return 6;

      case "F":
        return 6;

      case "completed":
        return 8;

      case "canceled":
        return 7;

      case "BR":
        return 7;

      case "assigned":
        return 4;

      default:
        return 0;
    }
  }

  readCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    String cacheCurrency = prefs.getString("currency") ?? "";
    currency(cacheCurrency);
  }

  @override
  void onInit() {
    readCurrency();
    super.onInit();
  }
}
