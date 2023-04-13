var versions = [
  Version(
      id: 1,
      versionName: "account-manager-v5.apk",
      date: "13-april-2023",
      log: "activity log for account manager is added")
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
