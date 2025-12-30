class JenisBuahModel {
  final int id;
  final String nama;
  final String kode;

  JenisBuahModel({
    required this.id,
    required this.nama,
    required this.kode,
  });

  factory JenisBuahModel.fromJson(Map<String, dynamic> json) => JenisBuahModel(
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
