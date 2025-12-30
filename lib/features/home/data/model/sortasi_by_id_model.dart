class GetByIdSortasiModel {
  final Sortasi sortasi;
  final Potongan potongan;
  final Pulangan pulangan;
  final TimbangMasuk timbangMasuk;

  GetByIdSortasiModel({
    required this.sortasi,
    required this.potongan,
    required this.pulangan,
    required this.timbangMasuk,
  });

  factory GetByIdSortasiModel.fromJson(Map<String, dynamic> json) =>
      GetByIdSortasiModel(
        sortasi: Sortasi.fromJson(json["Sortasi"]),
        potongan: Potongan.fromJson(json["Potongan"]),
        pulangan: Pulangan.fromJson(json["Pulangan"]),
        timbangMasuk: TimbangMasuk.fromJson(json["TimbangMasuk"]),
      );

  Map<String, dynamic> toJson() => {
        "Sortasi": sortasi.toJson(),
        "Potongan": potongan.toJson(),
        "Pulangan": pulangan.toJson(),
        "TimbangMasuk": timbangMasuk.toJson(),
      };
}

class Sortasi {
  final int id;
  final int transaksiId;
  final String tanggal;
  final int shiftId;
  final int jenisBuahId;
  final num dura;
  final num beratTandan;
  final num brondolan;
  final bool pulangSemua;
  final String catatan;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Transaksi transaksi;
  final Shift shift;
  final JenisBuah jenisBuah;
  final List<FotoSortasi> fotoSortasi;

  Sortasi({
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
    required this.createdAt,
    required this.updatedAt,
    required this.transaksi,
    required this.shift,
    required this.jenisBuah,
    required this.fotoSortasi,
  });

  factory Sortasi.fromJson(Map<String, dynamic> json) => Sortasi(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        transaksi: Transaksi.fromJson(json["Transaksi"]),
        shift: Shift.fromJson(json["Shift"]),
        jenisBuah: JenisBuah.fromJson(json["JenisBuah"]),
        fotoSortasi: List<FotoSortasi>.from(
            json["FotoSortasi"].map((x) => FotoSortasi.fromJson(x))),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "Transaksi": transaksi.toJson(),
        "Shift": shift.toJson(),
        "JenisBuah": jenisBuah.toJson(),
        "FotoSortasi": List<dynamic>.from(fotoSortasi.map((x) => x.toJson())),
      };
}

class FotoSortasi {
  final int id;
  final String jenis;
  final String localPath;
  final String cloudPath;

  FotoSortasi({
    required this.id,
    required this.jenis,
    required this.localPath,
    required this.cloudPath,
  });

  factory FotoSortasi.fromJson(Map<String, dynamic> json) => FotoSortasi(
        id: json["id"],
        jenis: json["jenis"],
        localPath: json["local_path"],
        cloudPath: json["cloud_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis": jenis,
        "local_path": localPath,
        "cloud_path": cloudPath,
      };
}

class JenisBuah {
  final int id;
  final String nama;
  final String kode;

  JenisBuah({
    required this.id,
    required this.nama,
    required this.kode,
  });

  factory JenisBuah.fromJson(Map<String, dynamic> json) => JenisBuah(
        id: json["id"],
        nama: json["nama"],
        kode: json["kode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kode": kode,
      };
}

class Shift {
  final int id;
  final String tanggal;
  final int shift;
  final String jenisShift;
  final int pengawasId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pengawas pengawas;

  Shift({
    required this.id,
    required this.tanggal,
    required this.shift,
    required this.jenisShift,
    required this.pengawasId,
    required this.createdAt,
    required this.updatedAt,
    required this.pengawas,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        tanggal: json["tanggal"],
        shift: json["shift"],
        jenisShift: json["jenis_shift"],
        pengawasId: json["pengawas_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pengawas: Pengawas.fromJson(json["pengawas"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "shift": shift,
        "jenis_shift": jenisShift,
        "pengawas_id": pengawasId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "Pengawas": pengawas.toJson(),
      };
}

class Pengawas {
  final int id;
  final String name;
  final String email;
  final String accessToken;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pengawas({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pengawas.fromJson(Map<String, dynamic> json) => Pengawas(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        accessToken: json["access_token"],
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "access_token": accessToken,
        "password": password,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
  final int netto;
  final int beratTerima;
  final int jumlahTandan;
  final Supplier supplier;

  Transaksi({
    required this.id,
    required this.nomorTiket,
    required this.supplierId,
    required this.namaSupir,
    required this.platKendaraan,
    required this.jenisKendaraanId,
    required this.jenisBarangId,
    required this.status,
    required this.netto,
    required this.beratTerima,
    required this.jumlahTandan,
    required this.supplier,
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
        netto: json["netto"],
        beratTerima: json["berat_terima"],
        jumlahTandan: json["jumlah_tandan"],
        supplier: Supplier.fromJson(json["Supplier"]),
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
        "netto": netto,
        "berat_terima": beratTerima,
        "jumlah_tandan": jumlahTandan,
        "Supplier": supplier.toJson(),
      };
}

class Supplier {
  final int id;
  final String nama;
  final String kodeSupplier;
  final String alamat;
  final String telepon;
  final String fax;
  final String penanggungJawab;

  Supplier({
    required this.id,
    required this.nama,
    required this.kodeSupplier,
    required this.alamat,
    required this.telepon,
    required this.fax,
    required this.penanggungJawab,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        nama: json["nama"],
        kodeSupplier: json["kode_supplier"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        fax: json["fax"],
        penanggungJawab: json["penanggung_jawab"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kode_supplier": kodeSupplier,
        "alamat": alamat,
        "telepon": telepon,
        "fax": fax,
        "penanggung_jawab": penanggungJawab,
      };
}

class Potongan {
  final int id;
  final int sortasiId;
  final num persentaseAir;
  final num jumlahAir;
  final num persentaseSampah;
  final num jumlahSampah;
  final num persentaseTangkai;
  final num jumlahTangkai;
  final num persentasePasir;
  final num jumlahPasir;
  final num persentaseMutu;
  final num jumlahMutu;
  final num persentaseMengkal;
  final num jumlahMengkal;
  final num persentaseLainLain;
  final num jumlahLainLain;
  final num totalPersentase;
  final num totalJumlah;

  Potongan({
    required this.id,
    required this.sortasiId,
    required this.persentaseAir,
    required this.jumlahAir,
    required this.persentaseSampah,
    required this.jumlahSampah,
    required this.persentaseTangkai,
    required this.jumlahTangkai,
    required this.persentasePasir,
    required this.jumlahPasir,
    required this.persentaseMutu,
    required this.jumlahMutu,
    required this.persentaseMengkal,
    required this.jumlahMengkal,
    required this.persentaseLainLain,
    required this.jumlahLainLain,
    required this.totalPersentase,
    required this.totalJumlah,
  });

  factory Potongan.fromJson(Map<String, dynamic> json) {
    return Potongan(
      id: json['id'],
      sortasiId: json['sortasi_id'],
      persentaseAir: json['persentase_air'],
      jumlahAir: json['jumlah_air'],
      persentaseSampah: json['persentase_sampah'],
      jumlahSampah: json['jumlah_sampah'],
      persentaseTangkai: json['persentase_tangkai'],
      jumlahTangkai: json['jumlah_tangkai'],
      persentasePasir: json['persentase_pasir'],
      jumlahPasir: json['jumlah_pasir'],
      persentaseMutu: json['persentase_mutu'],
      jumlahMutu: json['jumlah_mutu'],
      persentaseMengkal: json['persentase_mengkal'],
      jumlahMengkal: json['jumlah_mengkal'],
      persentaseLainLain: json['persentase_lain_lain'],
      jumlahLainLain: json['jumlah_lain_lain'],
      totalPersentase: json['total_persentase'],
      totalJumlah: json['total_jumlah'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sortasiId": sortasiId,
        "persentaseAir": persentaseAir,
        "jumlahAir": jumlahAir,
        "persentaseSampah": persentaseSampah,
        "jumlahSampah": jumlahSampah,
        "persentaseTangkai": persentaseTangkai,
        "jumlahTangkai": jumlahTangkai,
        "persentasePasir": persentasePasir,
        "jumlahPasir": jumlahPasir,
        "persentaseMutu": persentaseMutu,
        "jumlahMutu": jumlahMutu,
        "persentaseMengkal": persentaseMengkal,
        "jumlahMengkal": jumlahMengkal,
        "persentaseLainLain": persentaseLainLain,
        "jumlahLainLain": jumlahLainLain,
        "totalPersentase": totalPersentase,
        "totalJumlah": totalJumlah,
      };
}

class Pulangan {
  final int id;
  final int sortasiId;
  final num persentaseMentah;
  final num jumlahMentah;
  final num persentaseBusuk;
  final num jumlahBusuk;
  final num persentaseTankos;
  final num jumlahTankos;
  final num persentaseLainLain;
  final num jumlahLainLain;
  final num jumalahKecil;
  final num totalPersentase;
  final num totalJumlah;

  Pulangan({
    required this.id,
    required this.sortasiId,
    required this.persentaseMentah,
    required this.jumlahMentah,
    required this.persentaseBusuk,
    required this.jumlahBusuk,
    required this.persentaseTankos,
    required this.jumlahTankos,
    required this.persentaseLainLain,
    required this.jumlahLainLain,
    required this.jumalahKecil,
    required this.totalPersentase,
    required this.totalJumlah,
  });

  factory Pulangan.fromJson(Map<String, dynamic> json) {
    return Pulangan(
      id: json['id'],
      sortasiId: json['sortasi_id'],
      persentaseMentah: json['persentase_mentah'],
      jumlahMentah: json['jumlah_mentah'],
      persentaseBusuk: json['persentase_busuk'],
      jumlahBusuk: json['jumlah_busuk'],
      persentaseTankos: json['persentase_tankos'],
      jumlahTankos: json['jumlah_tankos'],
      persentaseLainLain: json['persentase_lain_lain'],
      jumlahLainLain: json['jumlah_lain_lain'],
      jumalahKecil: json['jumlah_kecil'],
      totalPersentase: json['total_persentase'],
      totalJumlah: json['total_jumlah'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sortasiId": sortasiId,
        "persentaseMentah": persentaseMentah,
        "jumlahMentah": jumlahMentah,
        "persentaseBusuk": persentaseBusuk,
        "jumlahBusuk": jumlahBusuk,
        "persentaseTankos": persentaseTankos,
        "jumlahTankos": jumlahTankos,
        "persentaseLainLain": persentaseLainLain,
        "jumlahLainLain": jumlahLainLain,
        "jumlahKecil": jumalahKecil,
        "totalPersentase": totalPersentase,
        "totalJumlah": totalJumlah,
      };
}

class TimbangMasuk {
  final int id;
  final int transaksiId;
  final num bruto;

  TimbangMasuk({
    required this.id,
    required this.transaksiId,
    required this.bruto,
  });

  factory TimbangMasuk.fromJson(Map<String, dynamic> json) => TimbangMasuk(
        id: json["id"],
        transaksiId: json["transaksi_id"],
        bruto: json["bruto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaksi_id": transaksiId,
        "bruto": bruto,
      };
}

class DeleteSortasiModel {
  final String catatan;

  DeleteSortasiModel({
    required this.catatan,
  });

  factory DeleteSortasiModel.fromJson(Map<String, dynamic> json) =>
      DeleteSortasiModel(
        catatan: json["catatan"],
      );

  Map<String, dynamic> toJson() => {
        "catatan": catatan,
      };
}
