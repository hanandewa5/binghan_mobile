import 'package:date_format/date_format.dart';

class User {
  int? id;
  String? email;
  String? binghanId;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? tanggalLahir;
  String? nomorKtp;
  String? jenisKelamin;
  String? npwp;
  String? npwpUrl;
  String? status;
  String? alamatRumah;
  String? kelurahan;
  int? kecamatanId;
  String? kecamatan;
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
  int? idSponsor;
  String? sponsorBinghanId;
  String? teleponSponsor;
  int? dmId;
  String? distributorManager;
  String? distributorManagerId;
  String? approvedBy;
  String? ktpUrl;
  String? generationPath;
  String? memberClass;
  int? memberExpiry;
  String? memberExpiryFormated;
  int? pointValues;

  User({
    this.id,
    this.email,
    this.binghanId,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.tanggalLahir,
    this.nomorKtp,
    this.jenisKelamin,
    this.npwp,
    this.status,
    this.alamatRumah,
    this.kelurahan,
    this.kecamatanId,
    this.kecamatan,
    this.sponsorBinghanId,
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
    this.idSponsor,
    this.teleponSponsor,
    this.dmId,
    this.distributorManager,
    this.distributorManagerId,
    this.approvedBy,
    this.ktpUrl,
    this.npwpUrl,
    this.generationPath,
    this.memberClass,
    this.memberExpiry,
    this.memberExpiryFormated,
    this.pointValues,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    binghanId: json["binghan_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    photoUrl: json["photo_url"],
    tanggalLahir: json["tanggal_lahir"],
    nomorKtp: json["nomor_ktp"],
    jenisKelamin: json["jenis_kelamin"],
    npwp: json["npwp"],
    npwpUrl: json["npwp_url"],
    status: json["status"],
    alamatRumah: json["alamat_rumah"],
    kelurahan: json["kelurahan"],
    kecamatanId: json["kecamatan_id"],
    kecamatan: json["kecamatan"],
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
    idSponsor: json["sponsor_id"],
    teleponSponsor: json["telepon_sponsor"],
    dmId: json["dm_id"],
    distributorManager: json["distributor_manager"],
    distributorManagerId: json["distributor_manager_id"],
    approvedBy: json["approved_by"],
    ktpUrl: json["ktp_url"],
    generationPath: json["generation_path"],
    pointValues: json["point_values"],
    sponsorBinghanId: json["sponsor_binghan_id"],
    memberExpiry: json["member_expiry"],
    memberExpiryFormated: json["member_expiry"] == null
        ? ''
        : formatDate(
            DateTime.fromMillisecondsSinceEpoch(json["member_expiry"] * 1000),
            [d, " ", M, " ", yyyy],
          ),
    memberClass: json["member_class"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "binghan_id": binghanId,
    "first_name": firstName,
    "last_name": lastName,
    "photo_url": photoUrl,
    "tanggal_lahir": tanggalLahir,
    "nomor_ktp": nomorKtp,
    "jenis_kelamin": jenisKelamin,
    "npwp": npwp,
    "npwp_url": npwpUrl,
    "status": status,
    "alamat_rumah": alamatRumah,
    "kelurahan": kelurahan,
    "kecamatan_id": kecamatanId,
    "kecamatan": kecamatan,
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
    "sponsor_id": idSponsor,
    "telepon_sponsor": teleponSponsor,
    "dm_id": dmId,
    "distributor_manager": distributorManager,
    "distributor_manager_id": distributorManagerId,
    "approved_by": approvedBy,
    "ktp_url": ktpUrl,
    "generation_path": generationPath,
    "point_values": pointValues,
    "sponsor_binghan_id": sponsorBinghanId,
    "member_class": memberClass,
    "member_expiry": memberExpiry,
  };
}
