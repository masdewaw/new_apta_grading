class AsistenSortasiModel {
  final int id;
  final int roleId;
  final String nama;

  AsistenSortasiModel({
    required this.id,
    required this.roleId,
    required this.nama,
  });

  factory AsistenSortasiModel.fromJson(Map<String, dynamic> json) =>
      AsistenSortasiModel(
        id: json["id"],
        roleId: json["role_id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "nama": nama,
      };
}
