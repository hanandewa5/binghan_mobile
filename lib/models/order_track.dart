class OrderTrack {
  int code;
  String msg;
  Data? data;

  OrderTrack({required this.code, required this.msg, this.data});

  factory OrderTrack.fromJson(Map<String, dynamic> json) => OrderTrack(
    code: json["code"],
    msg: json["msg"],
    data: json["code"] != 200 ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  List<Manifest>? manifest;
  Summary? summary;

  Data({this.manifest, this.summary});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    manifest: List<Manifest>.from(
      json["Manifest"] == null
          ? []
          : json["Manifest"].map((x) => Manifest.fromJson(x)),
    ),
    summary: Summary.fromJson(json["Summary"]),
  );

  Map<String, dynamic> toJson() => {
    "Manifest": List<dynamic>.from(manifest?.map((x) => x.toJson()) ?? []),
    "Summary": summary?.toJson(),
  };
}

class Manifest {
  String? manifestDescription;
  DateTime? manifestDate;
  String? manifestTime;
  String? cityName;

  Manifest({
    this.manifestDescription,
    this.manifestDate,
    this.manifestTime,
    this.cityName,
  });

  factory Manifest.fromJson(Map<String, dynamic> json) => Manifest(
    manifestDescription: json["manifest_description"],
    manifestDate: DateTime.parse(json["manifest_date"]),
    manifestTime: json["manifest_time"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "manifest_description": manifestDescription,
    "manifest_date":
        "${manifestDate?.year.toString().padLeft(4, '0')}-${manifestDate?.month.toString().padLeft(2, '0')}-${manifestDate?.day.toString().padLeft(2, '0')}",
    "manifest_time": manifestTime,
    "city_name": cityName,
  };
}

class Summary {
  String? courierCode;
  String? courierName;
  String? waybillNumber;
  String? serviceCode;
  DateTime? waybillDate;
  String? shipperName;
  String? receiverName;
  String? origin;
  String? destination;
  String? status;

  Summary({
    this.courierCode,
    this.courierName,
    this.waybillNumber,
    this.serviceCode,
    this.waybillDate,
    this.shipperName,
    this.receiverName,
    this.origin,
    this.destination,
    this.status,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    courierCode: json["courier_code"],
    courierName: json["courier_name"],
    waybillNumber: json["waybill_number"],
    serviceCode: json["service_code"],
    waybillDate: json["waybill_date"] != ""
        ? DateTime.parse(json["waybill_date"])
        : null,
    shipperName: json["shipper_name"],
    receiverName: json["receiver_name"],
    origin: json["origin"],
    destination: json["destination"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "courier_code": courierCode,
    "courier_name": courierName,
    "waybill_number": waybillNumber,
    "service_code": serviceCode,
    "waybill_date":
        "${waybillDate?.year.toString().padLeft(4, '0')}-${waybillDate?.month.toString().padLeft(2, '0')}-${waybillDate?.day.toString().padLeft(2, '0')}",
    "shipper_name": shipperName,
    "receiver_name": receiverName,
    "origin": origin,
    "destination": destination,
    "status": status,
  };
}
