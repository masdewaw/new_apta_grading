class ChangeShiftModel {
  final String jenisShift;
  final PetugasSortasi petugasSortasi;
  final int shift;
  final int userId;

  ChangeShiftModel({
    required this.jenisShift,
    required this.petugasSortasi,
    required this.shift,
    required this.userId,
  });

  factory ChangeShiftModel.fromJson(Map<String, dynamic> json) =>
      ChangeShiftModel(
        jenisShift: json["jenis_shift"],
        petugasSortasi: PetugasSortasi.fromJson(json["petugas_sortasi"]),
        shift: json["shift"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "jenis_shift": jenisShift,
        "petugas_sortasi": petugasSortasi.toJson(),
        "shift": shift,
        "user_id": userId,
      };
}

class PetugasSortasi {
  final List<int> petugasSortasiId;

  PetugasSortasi({
    required this.petugasSortasiId,
  });

  factory PetugasSortasi.fromJson(Map<String, dynamic> json) => PetugasSortasi(
        petugasSortasiId:
            List<int>.from(json["petugas_sortasi_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "petugas_sortasi_id":
            List<dynamic>.from(petugasSortasiId.map((x) => x)),
      };
}
