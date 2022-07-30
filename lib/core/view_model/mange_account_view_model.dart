import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/finance_api.dart';
import 'package:dalile_customer/model/bank_model.dart';
import 'package:dalile_customer/model/manage_account_model.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageAccountController extends GetxController {
  @override
  void onInit() {
    fetchManageAccountData();
    fetchBankListData();
    super.onInit();
  }

  var isLoading = false.obs;
  var bankListData = <BankListModel>[].obs;
  var accountData = <BankAccount>[].obs;
  void fetchManageAccountData() async {
    try {
      isLoading(true);
      var account = await FinanceApi.fetchManageAccountData();
      if (account != null) {
        accountData.value = account.bankAccounts!.reversed.toList();
      } else {
           if (!Get.isSnackbarOpen) {
           Get.snackbar('Filed', FinanceApi.mass);
         }
        
     
      }
    } finally {
     

      isLoading(false);
    }
  }

  void fetchBankListData() async {
    try {
      var bank = await FinanceApi.fetchBankListData();
      if (bank != null) {
        bankListData.value = bank;
      }
    } finally {
     
    }
  }

  editBankAccount(context, String title) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(builder: (context) {
          return ShowAddEditBank(
            title: title,
          );
        }),
      ),
    );
  }

  var checkboxIs = false.obs;
  void onClickCheckBox(val) {
    checkboxIs.value = val;
  }

  TextEditingController bankName = TextEditingController();
  TextEditingController bankNo = TextEditingController();
  TextEditingController bankId = TextEditingController();
  TextEditingController nameAccount = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void fetchAddPostData(context) async {
    try {
      if (formkey.currentState!.validate()) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return const Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: WaiteImage(),
            );
          },
        );

        bool? postRequst = await FinanceApi.fetchAddAccountData(
            "1", bankId.text, bankName.text, bankNo.text, nameAccount.text);
        Get.back();
        if (postRequst != null && postRequst == true) {
          Get.back();
          showDialog(
              barrierDismissible: true,
              barrierColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBoxAl(
                  title: "Done !!",
                  des: "bank account added successfully",
                  icon: Icons.priority_high_outlined,
                );
              });
        } else {
         
             if (!Get.isSnackbarOpen) {
           Get.snackbar('Filed', FinanceApi.mass,
              colorText: whiteColor, backgroundColor: textRedColor);
        }
        
        }
      }
    } finally {
      nameAccount.clear();
      bankId.clear();

      bankNo.clear();
      checkboxIs.value = false;
      fetchManageAccountData();
     
    }
  }
}

class ShowAddEditBank extends GetWidget<ManageAccountController> {
  const ShowAddEditBank({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width / 0.9,
        child: Form(
          key: controller.formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: title,
                      alignment: Alignment.topRight,
                      color: primaryColor,
                      size: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.clear_outlined,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomFormFiled(
                    hint: 'Bank Muscat',
                    select: controller.bankName.text.isEmpty
                        ? null
                        : controller.bankName.text,
                    text: 'Bank',
                    onSaved: (val) {
                      for (int i = 0; i < controller.bankListData.length; i++) {
                        if (controller.bankListData[i].name == val) {
                          controller.bankId.text =
                              controller.bankListData[i].id.toString();
                          controller.bankName.text =
                              controller.bankListData[i].name.toString();

                        }
                      }
                      return null;
                    },
                    validator: (val) => val == null
                        ? 'please enter your account number'
                        : val.length > 20
                            ? "max number 20"
                            : null,
                    items: controller.bankListData
                        .map((element) => element.name.toString())
                        .toList()),
                CustomFormFiledWithTitle(
                  validator: (val) => val!.isEmpty
                      ? 'please enter your account number'
                      : val.length > 20
                          ? "max number 20"
                          : null,
                  controller: controller.bankNo,
                  keyboardType: TextInputType.number,
                  text: 'Account Number',
                  hintText: '012 345 6789',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormFiledWithTitle(
                  controller: controller.nameAccount,
                  validator: (val) => val!.isEmpty
                      ? 'please enter your name'
                      : val.length > 20
                          ? "name is to long"
                          : null,
                  text: 'Beneficiary Name',
                  hintText: 'name',
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: whiteColor,
                  activeColor: textRedColor,
                  value: controller.checkboxIs.value, // ************
                  onChanged: (vla) {
                   
                    controller.onClickCheckBox(vla);
                  },
                  title: const CustomText(
                    text: "this account which all money will be transferred",
                    color: textRedColor,
                    size: 10,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButtom(
                  text: 'Add',
                  onPressed: () {
                    if (controller.checkboxIs.value) {
                      controller.fetchAddPostData(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
