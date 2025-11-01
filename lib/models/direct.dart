class Direct {
  int code;
  String msg;
  List<ListDirect>? data;

  Direct({required this.code, required this.msg, this.data});

  factory Direct.fromJson(Map<String, dynamic> json) => Direct(
    code: json["code"],
    msg: json["msg"],
    data: json["code"] != 200
        ? null
        : List<ListDirect>.from(
            json["data"].map((x) => ListDirect.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
  };
}

class ListDirect {
  int? id;
  int? createdOn;
  int? modifiedOn;
  bool? isAdmin;
  String? email;
  String? binghanId;
  String? password;
  String? firstName;
  String? lastName;
  String? photoUrl;
  bool? approved;
  String? tanggalLahir;
  String? nomorKtp;
  String? jenisKelamin;
  String? npwp;
  String? status;
  String? alamatRumah;
  String? kelurahan;
  String? kecamatan;
  int? kecamatanId;
  String? kota;
  String? propinsi;
  String? kodePos;
  String? alamatKantor;
  String? teleponRumah;
  String? handphone;
  String? teleponKantor;
  String? nomorFax;
  String? namaPemilikRekening;
  String? nomorRekening;
  String? namaBank;
  String? cabangBank;
  String? kotaCabang;
  String? namaSponsor;
  int? sponsorId;
  String? teleponSponsor;
  String? distributorManager;
  String? distributorManagerId;
  String? approvedBy;
  String? ktpUrl;
  String? generationPath;
  String? firebaseToken;
  String? memberClass;
  int? memberExpiry;
  int? pointValues;

  ListDirect({
    this.id,
    this.createdOn,
    this.modifiedOn,
    this.isAdmin,
    this.email,
    this.binghanId,
    this.password,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.approved,
    this.tanggalLahir,
    this.nomorKtp,
    this.jenisKelamin,
    this.npwp,
    this.status,
    this.alamatRumah,
    this.kelurahan,
    this.kecamatan,
    this.kecamatanId,
    this.kota,
    this.propinsi,
    this.kodePos,
    this.alamatKantor,
    this.teleponRumah,
    this.handphone,
    this.teleponKantor,
    this.nomorFax,
    this.namaPemilikRekening,
    this.nomorRekening,
    this.namaBank,
    this.cabangBank,
    this.kotaCabang,
    this.namaSponsor,
    this.sponsorId,
    this.teleponSponsor,
    this.distributorManager,
    this.distributorManagerId,
    this.approvedBy,
    this.ktpUrl,
    this.generationPath,
    this.firebaseToken,
    this.memberClass,
    this.memberExpiry,
    this.pointValues,
  });

  factory ListDirect.fromJson(Map<String, dynamic> json) => ListDirect(
    id: json["id"],
    createdOn: json["created_on"],
    modifiedOn: json["modified_on"],
    isAdmin: json["is_admin"],
    email: json["email"],
    binghanId: json["binghan_id"],
    password: json["password"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    photoUrl: json["photo_url"],
    approved: json["approved"],
    tanggalLahir: json["tanggal_lahir"],
    nomorKtp: json["nomor_ktp"],
    jenisKelamin: json["jenis_kelamin"],
    npwp: json["npwp"],
    status: json["status"],
    alamatRumah: json["alamat_rumah"],
    kelurahan: json["kelurahan"],
    kecamatan: json["kecamatan"],
    kecamatanId: json["kecamatan_id"],
    kota: json["kota"],
    propinsi: json["propinsi"],
    kodePos: json["kode_pos"],
    alamatKantor: json["alamat_kantor"],
    teleponRumah: json["telepon_rumah"],
    handphone: json["handphone"],
    teleponKantor: json["telepon_kantor"],
    nomorFax: json["nomor_fax"],
    namaPemilikRekening: json["nama_pemilik_rekening"],
    nomorRekening: json["nomor_rekening"],
    namaBank: json["nama_bank"],
    cabangBank: json["cabang_bank"],
    kotaCabang: json["kota_cabang"],
    namaSponsor: json["nama_sponsor"],
    sponsorId: json["sponsor_id"],
    teleponSponsor: json["telepon_sponsor"],
    distributorManager: json["distributor_manager"],
    distributorManagerId: json["distributor_manager_id"],
    approvedBy: json["approved_by"],
    ktpUrl: json["ktp_url"],
    generationPath: json["generation_path"],
    firebaseToken: json["firebase_token"],
    memberClass: json["member_class"],
    memberExpiry: json["member_expiry"],
    pointValues: json["point_values"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_on": createdOn,
    "modified_on": modifiedOn,
    "is_admin": isAdmin,
    "email": email,
    "binghan_id": binghanId,
    "password": password,
    "first_name": firstName,
    "last_name": lastName,
    "photo_url": photoUrl,
    "approved": approved,
    "tanggal_lahir": tanggalLahir,
    "nomor_ktp": nomorKtp,
    "jenis_kelamin": jenisKelamin,
    "npwp": npwp,
    "status": status,
    "alamat_rumah": alamatRumah,
    "kelurahan": kelurahan,
    "kecamatan": kecamatan,
    "kecamatan_id": kecamatanId,
    "kota": kota,
    "propinsi": propinsi,
    "kode_pos": kodePos,
    "alamat_kantor": alamatKantor,
    "telepon_rumah": teleponRumah,
    "handphone": handphone,
    "telepon_kantor": teleponKantor,
    "nomor_fax": nomorFax,
    "nama_pemilik_rekening": namaPemilikRekening,
    "nomor_rekening": nomorRekening,
    "nama_bank": namaBank,
    "cabang_bank": cabangBank,
    "kota_cabang": kotaCabang,
    "nama_sponsor": namaSponsor,
    "sponsor_id": sponsorId,
    "telepon_sponsor": teleponSponsor,
    "distributor_manager": distributorManager,
    "distributor_manager_id": distributorManagerId,
    "approved_by": approvedBy,
    "ktp_url": ktpUrl,
    "generation_path": generationPath,
    "firebase_token": firebaseToken,
    "member_class": memberClass,
    "member_expiry": memberExpiry,
    "point_values": pointValues,
  };
}
