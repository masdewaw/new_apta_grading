class TransaksiMaterialModel {
  final int id;
  final String nomorTiket;
  final int supplierId;
  final String namaSupir;
  final String platKendaraan;
  final int jenisKendaraanId;
  final int jenisBarangId;
  final String status;
  final int netto;
  final int jumlahTandan;
  final Supplier supplier;
  final TimbangMasukMaterial timbangMasukMaterial;

  TransaksiMaterialModel({
    required this.id,
    required this.nomorTiket,
    required this.supplierId,
    required this.namaSupir,
    required this.platKendaraan,
    required this.jenisKendaraanId,
    required this.jenisBarangId,
    required this.status,
    required this.netto,
    required this.jumlahTandan,
    required this.supplier,
    required this.timbangMasukMaterial,
  });

  factory TransaksiMaterialModel.fromJson(Map<String, dynamic> json) =>
      TransaksiMaterialModel(
        id: json["id"],
        nomorTiket: json["nomor_tiket"],
        supplierId: json["supplier_id"],
        namaSupir: json["nama_supir"],
        platKendaraan: json["plat_kendaraan"],
        jenisKendaraanId: json["jenis_kendaraan_id"],
        jenisBarangId: json["jenis_barang_id"],
        status: json["status"],
        netto: json["netto"],
        jumlahTandan: json["jumlah_tandan"],
        supplier: Supplier.fromJson(json["supplier"]),
        timbangMasukMaterial:
            TimbangMasukMaterial.fromJson(json["timbang_masuk_material"]),
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
        "jumlah_tandan": jumlahTandan,
        "supplier": supplier.toJson(),
        "timbang_masuk_material": timbangMasukMaterial.toJson(),
      };
}

class Supplier {
  final int id;
  final String nama;
  final String kodeSupplier;

  Supplier({
    required this.id,
    required this.nama,
    required this.kodeSupplier,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        nama: json["nama"],
        kodeSupplier: json["kode_supplier"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kode_supplier": kodeSupplier,
      };
}

class TimbangMasukMaterial {
  final int id;
  final int transaksiId;
  final int bruto;

  TimbangMasukMaterial({
    required this.id,
    required this.transaksiId,
    required this.bruto,
  });

  factory TimbangMasukMaterial.fromJson(Map<String, dynamic> json) =>
      TimbangMasukMaterial(
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
