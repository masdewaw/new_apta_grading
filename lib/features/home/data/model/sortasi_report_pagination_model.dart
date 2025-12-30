class SortasiReportPaginationModel {
  List<Item> items;
  int page;
  int size;
  int maxPage;
  int totalPages;
  int total;
  bool last;
  bool first;
  int visible;

  SortasiReportPaginationModel({
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

  factory SortasiReportPaginationModel.fromJson(Map<String, dynamic> json) =>
      SortasiReportPaginationModel(
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
  String description;
  int transaksiMaterialId;
  List<SortasiReportPhoto> sortasiReportPhotos;
  TransaksiMaterial transaksiMaterial;

  Item({
    required this.id,
    required this.description,
    required this.transaksiMaterialId,
    required this.sortasiReportPhotos,
    required this.transaksiMaterial,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        description: json["description"],
        transaksiMaterialId: json["transaksi_material_id"],
        sortasiReportPhotos: List<SortasiReportPhoto>.from(
            json["sortasi_report_photos"]
                .map((x) => SortasiReportPhoto.fromJson(x))),
        transaksiMaterial:
            TransaksiMaterial.fromJson(json["transaksi_material"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "transaksi_material_id": transaksiMaterialId,
        "sortasi_report_photos":
            List<dynamic>.from(sortasiReportPhotos.map((x) => x.toJson())),
        "transaksi_material": transaksiMaterial.toJson(),
      };
}

class SortasiReportPhoto {
  int id;
  String photo;
  String note;
  int sortasiReportId;

  SortasiReportPhoto({
    required this.id,
    required this.photo,
    required this.note,
    required this.sortasiReportId,
  });

  factory SortasiReportPhoto.fromJson(Map<String, dynamic> json) =>
      SortasiReportPhoto(
        id: json["id"],
        photo: json["photo"],
        note: json["note"],
        sortasiReportId: json["sortasi_report_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "note": note,
        "sortasi_report_id": sortasiReportId,
      };
}

class TransaksiMaterial {
  int id;
  String nomorTiket;
  int supplierId;
  String namaSupir;
  String platKendaraan;
  int jenisKendaraanId;
  int jenisBarangId;
  String status;
  int netto;
  int beratTerima;
  int jumlahTandan;
  int brutoRamp;
  int nettoRamp;
  int taraRamp;
  String outRamp;
  String tripCode;

  TransaksiMaterial({
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
    required this.brutoRamp,
    required this.nettoRamp,
    required this.taraRamp,
    required this.outRamp,
    required this.tripCode,
  });

  factory TransaksiMaterial.fromJson(Map<String, dynamic> json) =>
      TransaksiMaterial(
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
        brutoRamp: json["bruto_ramp"],
        nettoRamp: json["netto_ramp"],
        taraRamp: json["tara_ramp"],
        outRamp: json["out_ramp"],
        tripCode: json["trip_code"],
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
        "bruto_ramp": brutoRamp,
        "netto_ramp": nettoRamp,
        "tara_ramp": taraRamp,
        "out_ramp": outRamp,
        "trip_code": tripCode,
      };
}
