class GetSortasiModel {
  final int id;
  final int transaksiId;
  final String tanggal;
  final int shiftId;
  final int jenisBuahId;
  final int dura;
  final int beratTandan;
  final int brondolan;
  final bool pulangSemua;
  final String catatan;
  final Transaksi transaksi;

  GetSortasiModel({
    required this.id,
    required this.transaksiId,
    required this.tanggal,
    required this.shiftId,
    required this.jenisBuahId,
    required this.dura,
    required this.beratTandan,
    required this.brondolan,
    required this.pulangSemua,
    required this.catatan,
    required this.transaksi,
  });

  factory GetSortasiModel.fromJson(Map<String, dynamic> json) =>
      GetSortasiModel(
        id: json["id"],
        transaksiId: json["transaksi_id"],
        tanggal: json["tanggal"],
        shiftId: json["shift_id"],
        jenisBuahId: json["jenis_buah_id"],
        dura: json["dura"],
        beratTandan: json["berat_tandan"],
        brondolan: json["brondolan"],
        pulangSemua: json["pulang_semua"],
        catatan: json["catatan"],
        transaksi: Transaksi.fromJson(json["transaksi"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaksi_id": transaksiId,
        "tanggal": tanggal,
        "shift_id": shiftId,
        "jenis_buah_id": jenisBuahId,
        "dura": dura,
        "berat_tandan": beratTandan,
        "brondolan": brondolan,
        "pulang_semua": pulangSemua,
        "catatan": catatan,
        "transaksi": transaksi.toJson(),
      };
}

class Transaksi {
  final int id;
  final String nomorTiket;
  final int supplierId;
  final String namaSupir;
  final String platKendaraan;
  final int jenisKendaraanId;
  final int jenisBarangId;
  final String status;
  final dynamic timbangMasukMaterial;
  final dynamic timbangKeluarMaterial;

  Transaksi({
    required this.id,
    required this.nomorTiket,
    required this.supplierId,
    required this.namaSupir,
    required this.platKendaraan,
    required this.jenisKendaraanId,
    required this.jenisBarangId,
    required this.status,
    required this.timbangMasukMaterial,
    required this.timbangKeluarMaterial,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        nomorTiket: json["nomor_tiket"],
        supplierId: json["supplier_id"],
        namaSupir: json["nama_supir"],
        platKendaraan: json["plat_kendaraan"],
        jenisKendaraanId: json["jenis_kendaraan_id"],
        jenisBarangId: json["jenis_barang_id"],
        status: json["status"],
        timbangMasukMaterial: json["timbang_masuk_material"],
        timbangKeluarMaterial: json["timbang_keluar_material"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor_tiket": nomorTiket,
        "supplier_id": supplierId,
        "nama_supir": namaSupir,
        "plat_kendaraan": platKendaraan,
        "jenis_kendaraan_id": jenisKendaraanId,
        "jenis_barang_id": jenisBarangId,
        "status": status,
        "timbang_masuk_material": timbangMasukMaterial,
        "timbang_keluar_material": timbangKeluarMaterial,
      };
}

class InputSortasiModel {
  final num beratTandan;
  final num brondolan;
  final String catatan;
  final num dura;
  final int jenisBuahId;
  final bool pulangSemua;
  final bool isConfirmedChecked;
  final int transaksiId;
  final num persentaseAir;
  final num persentaseLainLainPotongan;
  final num persentaseMengkal;
  final num persentaseMutu;
  final num persentasePasir;
  final num persentaseSampah;
  final num persentaseTangkai;
  final num totalPersentasePotongan;
  final num jumlahBusuk;
  final num jumlahLainLainPulangan;
  final num jumlahMentah;
  final num jumlahTankos;
  final num jumlahKecil;
  final num totalJumlahPulangan;
  final String jenis;
  final List photo;

  InputSortasiModel({
    required this.beratTandan,
    required this.brondolan,
    required this.catatan,
    required this.dura,
    required this.jenisBuahId,
    required this.pulangSemua,
    required this.isConfirmedChecked,
    required this.transaksiId,
    required this.persentaseAir,
    required this.persentaseLainLainPotongan,
    required this.persentaseMengkal,
    required this.persentaseMutu,
    required this.persentasePasir,
    required this.persentaseSampah,
    required this.persentaseTangkai,
    required this.totalPersentasePotongan,
    required this.jumlahBusuk,
    required this.jumlahLainLainPulangan,
    required this.jumlahMentah,
    required this.jumlahTankos,
    required this.jumlahKecil,
    required this.totalJumlahPulangan,
    required this.jenis,
    required this.photo,
  });

  factory InputSortasiModel.fromJson(Map<String, dynamic> json) =>
      InputSortasiModel(
        beratTandan: json["berat_tandan"],
        brondolan: json["brondolan"],
        catatan: json["catatan"],
        dura: json["dura"],
        jenisBuahId: json["jenis_buah_id"],
        pulangSemua: json["pulang_semua"],
        isConfirmedChecked: json['is_confirmed_checked'],
        transaksiId: json["transaksi_id"],
        persentaseAir: json["persentase_air"],
        persentaseLainLainPotongan: json["persentase_lain_lain_potongan"],
        persentaseMengkal: json["persentase_mengkal"],
        persentaseMutu: json["persentase_mutu"],
        persentasePasir: json["persentase_pasir"],
        persentaseSampah: json["persentase_sampah"],
        persentaseTangkai: json["persentase_tangkai"],
        totalPersentasePotongan: json["total_persentase_potongan"],
        jumlahBusuk: json["jumlah_busuk"],
        jumlahLainLainPulangan: json["jumlah_lain_lain_pulangan"],
        jumlahMentah: json["jumlah_mentah"],
        jumlahTankos: json["jumlah_tankos"],
        jumlahKecil: json["jumlah_kecil"],
        totalJumlahPulangan: json["total_jumlah_pulangan"],
        jenis: json['json'],
        photo: json['photo'],
      );

  Map<String, dynamic> toJson() => {
        "berat_tandan": beratTandan,
        "brondolan": brondolan,
        "catatan": catatan,
        "dura": dura,
        "jenis_buah_id": jenisBuahId,
        "pulang_semua": pulangSemua,
        "is_confirmed_checked": isConfirmedChecked,
        "transaksi_id": transaksiId,
        "persentase_air": persentaseAir,
        "persentase_lain_lain_potongan": persentaseLainLainPotongan,
        "persentase_mengkal": persentaseMengkal,
        "persentase_mutu": persentaseMutu,
        "persentase_pasir": persentasePasir,
        "persentase_sampah": persentaseSampah,
        "persentase_tangkai": persentaseTangkai,
        "total_persentase_potongan": totalPersentasePotongan,
        "jumlah_busuk": jumlahBusuk,
        "jumlah_lain_lain_pulangan": jumlahLainLainPulangan,
        "jumlah_mentah": jumlahMentah,
        "jumlah_tankos": jumlahTankos,
        "jumlah_kecil": jumlahKecil,
        "total_jumlah_pulangan": totalJumlahPulangan,
        "jenis[]": jenis,
        "photo[]": photo,
      };
}

class InputReportSortasiModel {
  String description;
  num transaksiMaterialId;
  String notes;
  List photo;

  InputReportSortasiModel({
    required this.description,
    required this.transaksiMaterialId,
    required this.notes,
    required this.photo,
  });

  factory InputReportSortasiModel.fromJson(Map<String, dynamic> json) =>
      InputReportSortasiModel(
        description: json["description"],
        transaksiMaterialId: json['transaksi_material_id'],
        notes: json["notes"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "transaksi_material_id": transaksiMaterialId,
        "notes": notes,
        "photo": photo,
      };
}
