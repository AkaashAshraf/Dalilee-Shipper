import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/complain_api.dart';
import 'package:dalile_customer/model/ticket_details_model.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class TicketDetailsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var isLoading1 = false.obs;
  Rx<TicketDetails> ticketDetailsData = TicketDetails().obs;

  void fetchTicketDatilsData(String id) async {
    isLoading1(true);
    print(id.toString());
    try {
      TicketDetailsModel? data = await ComplainApi.fetchTicketDetailsData(id);
      print('----------->$data');
      if (data != null) {
        ticketDetailsData(data.ticketDetails);
      } else {
        Get.snackbar('Filed', ComplainApi.mass);
      }
    } finally {
      isLoading1(false);
    }
  }

  File? file;
  List<ImageFile> itemsImages = [];
  TextEditingController bodytext = TextEditingController();
  selectImage() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: ['png', 'pdf', 'jpeg', 'jpg'],
        type: FileType.custom);
    if (result == null) return;
    //final path = result.files.single.path;
    for (var i = 0; i < result.files.length; i++) {
      file = File(result.files[i].path!);
      // String fileSize = await getFileSize(file!.path, 1).toString();
      // print("Size-------------> $fileSize");
      final filename = file!.path.split('/').last;
      if (itemsImages.length < 5) {
        itemsImages.insert(0, ImageFile(name: filename, file: file!));
      } else {
        if (!Get.isSnackbarOpen)
          Get.snackbar("warning", "can't be more than 5 Files",
              colorText: whiteColor,
              backgroundColor: textRedColor.withOpacity(0.5));
      }
    }

    update();
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  var isLoadingCreate = false;
  Future<void> fetchCreateComplinData(context) async {
    isLoadingCreate = true;
    update();
    try {
      print('--------------->${ticketDetailsData.value.id.toString()}');
      bool? data = await ComplainApi.fetchCreateCommentData(
          ticketDetailsData.value.id.toString(), bodytext.text, []);

      if (data == true) {
        if (Get.isBottomSheetOpen == true) {
          Get.back();
        }

        showDialog(
            barrierDismissible: true,
            barrierColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBoxAl(
                title: "Done !!",
                des: "add Comment successfully",
                icon: Icons.priority_high_outlined,
              );
            });
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', "some data was missing");
        }
      }
    } finally {
      isLoadingCreate = false;
      update();
    }
  }
}

class ImageFile {
  String name;
  File file;
  ImageFile({required this.name, required this.file});
}
