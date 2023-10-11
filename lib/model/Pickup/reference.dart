class Reference {
  Reference({
    this.id,
    this.cop,
    this.location,
    this.totalOrders,
    this.collectionDate,
    this.status,
    this.driverName,
    this.driverMobile,
    this.storeUsername,
  });

  int? id;
  dynamic cop;
  String? location;
  dynamic totalOrders;
  String? collectionDate;
  String? status;
  String? driverName;
  String? driverMobile;
  String? storeUsername;

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        id: json["id"] == null ? null : json["id"],
        cop: json["cop"] == null ? null : json["cop"],
        location: json["location"] == null ? null : json["location"],
        totalOrders: json["total_orders"] == null ? 0 : json["total_orders"],
        collectionDate:
            json["collection_date"] == null ? "" : json["collection_date"],
        status: json["status"] == null ? "" : json["status"],
        driverName: json["driver_name"] == null ? "" : json["driver_name"],
        driverMobile:
            json["driver_mobile"] == null ? "" : json["driver_mobile"],
        storeUsername:
            json["store_username"] == null ? "" : json["store_username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cop": cop == null ? null : cop,
        "location": location == null ? null : location,
        "total_orders": totalOrders == null ? null : totalOrders,
        "collection_date": collectionDate == null ? null : collectionDate,
        "status": status == null ? null : status,
        "driver_name": driverName == null ? null : driverName,
        "driver_mobile": driverMobile == null ? null : driverMobile,
        "store_username": storeUsername == null ? null : storeUsername,
      };
}
