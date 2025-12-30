class SortasiPaginationModel {
  List<Item> items;
  int page;
  int size;
  int maxPage;
  int totalPages;
  int total;
  bool last;
  bool first;
  int visible;

  SortasiPaginationModel({
    required this.items,
    required this.page,
    required this.size,
    required this.maxPage,
    required this.totalPages,
    required this.total,
    required this.last,
    required this.first,
    required this.visible,
  });

  factory SortasiPaginationModel.fromJson(Map<String, dynamic> json) =>
      SortasiPaginationModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        page: json["page"],
        size: json["size"],
        maxPage: json["max_page"],
        totalPages: json["total_pages"],
        total: json["total"],
        last: json["last"],
        first: json["first"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "page": page,
        "size": size,
        "max_page": maxPage,
        "total_pages": totalPages,
        "total": total,
        "last": last,
        "first": first,
        "visible": visible,
      };
}

class Item {
  int id;
  int transaksiId;
  String tanggal;
  int shiftId;
  int jenisBuahId;
  num dura;
  num beratTandan;
  num brondolan;
  bool pulangSemua;
  String catatan;
  Transaksi transaksi;

  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
  int id;
  String nomorTiket;
  int supplierId;
  String namaSupir;
  String platKendaraan;
  int jenisKendaraanId;
  int jenisBarangId;
  String status;
  dynamic timbangMasukMaterial;
  dynamic timbangKeluarMaterial;

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
