var versions = [
  Version(
      id: 1,
      versionName: "account-manager-v5.apk",
      date: "13-april-2023",
      log: "activity log for account manager is added"),
  Version(
      id: 2,
      versionName: "account-manager-v8.apk",
      date: "16-april-2023",
      log: "st issue fixed and otp will not go work account manager")
];

class Version {
  Version(
      {required this.date,
      required this.versionName,
      required this.log,
      required this.id});
  int id;

  String date;
  String versionName;
  String log;
}
