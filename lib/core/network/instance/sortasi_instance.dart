// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:new_apta_grading/core/network/config/base_config.dart';
import 'package:new_apta_grading/features/home/data/model/asisten_sortasi_model.dart';
import 'package:new_apta_grading/features/home/data/model/change_shift_model.dart';
import 'package:new_apta_grading/features/home/data/model/jenis_buah_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_by_id_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_pagination_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_report_pagination_model.dart';
import 'package:new_apta_grading/features/home/data/model/transaksi_material_sortasi_model.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

import '../config/endpoints.dart';
import '../config/exception.dart';
import '../interceptor/auth_interceptor.dart';
import '../interceptor/delay_interceptor.dart';

class SortasiAPI {
  late final Dio _dio;
  SortasiAPI()
    : _dio = Dio(baseConfig)
        ..interceptors.addAll([
          AuthorizationInterceptor(),
          DelayInterceptor(),
          TalkerDioLogger(
            settings: const TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
              printResponseMessage: true,
            ),
          ),
        ]);

  Future<List<TransaksiMaterialModel>> getTrukSortasi() async {
    try {
      final response = await _dio.get(Endpoints.getTruck);
      List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(
        response.data['transaksi_material'],
      );
      List<TransaksiMaterialModel> trukSortasi = responseData
          .map((json) => TransaksiMaterialModel.fromJson(json))
          .toList();

      return trukSortasi;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<JenisBuahModel>> getJenisBuah() async {
    try {
      final response = await _dio.get(Endpoints.getJenisBuah);
      List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(
        response.data['jenis_buah'],
      );
      List<JenisBuahModel> jenisBuah = responseData
          .map((json) => JenisBuahModel.fromJson(json))
          .toList();

      return jenisBuah;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<AsistenSortasiModel>> getAsistenSortasi() async {
    try {
      final response = await _dio.get(Endpoints.getAsistenSortasi);
      List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(
        response.data['petugas_sortasi'],
      );
      List<AsistenSortasiModel> petugasSortasi = responseData
          .map((json) => AsistenSortasiModel.fromJson(json))
          .toList();

      return petugasSortasi;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future changeShiftSortasi(ChangeShiftModel changeShiftModel) async {
    try {
      final response = await _dio.post(
        Endpoints.changeShift,
        data: changeShiftModel.toJson(),
      );

      return response.statusCode;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<GetSortasiModel>> getDataSortasi() async {
    try {
      final response = await _dio.get(Endpoints.sortasi);
      List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(
        response.data['sortasi'],
      );
      List<GetSortasiModel> dataSortasi = responseData
          .map((json) => GetSortasiModel.fromJson(json))
          .toList();

      return dataSortasi;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SortasiPaginationModel> getDataSortasiPagination(int page) async {
    try {
      final response = await _dio.get(
        "${Endpoints.sortasi}/pagination?page=$page&size=10",
      );

      return SortasiPaginationModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SortasiReportPaginationModel> getDataSortasiReportPagination(
    int page,
  ) async {
    try {
      final response = await _dio.get(
        "${Endpoints.sortasiReport}?page=$page&size=10",
      );

      return SortasiReportPaginationModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future inputSortasi(InputSortasiModel inputSortasiModel) async {
    try {
      // List<MultipartFile> photoFiles = [];

      // // Check if the photo paths are valid
      // for (String photoPath in inputSortasiModel.photo) {
      //   File photoFile = File(photoPath);
      //   if (photoFile.existsSync()) {
      //     photoFiles.add(await MultipartFile.fromFile(photoPath));
      //   } else {
      //     print("File not found at path: $photoPath");
      //     // Handle the case where the file is not found (you may throw an error or handle it as needed)
      //   }
      // }
      final form = FormData();
      form.fields.addAll([
        MapEntry("berat_tandan", inputSortasiModel.beratTandan.toString()),
        MapEntry("brondolan", inputSortasiModel.brondolan.toString()),
        MapEntry("catatan", inputSortasiModel.catatan),
        MapEntry("dura", inputSortasiModel.dura.toString()),
        MapEntry("jenis_buah_id", inputSortasiModel.jenisBuahId.toString()),
        MapEntry("pulang_semua", inputSortasiModel.pulangSemua.toString()),
        MapEntry(
          "is_confirmed_checked",
          inputSortasiModel.isConfirmedChecked.toString(),
        ),
        MapEntry("transaksi_id", inputSortasiModel.transaksiId.toString()),
        MapEntry("persentase_air", inputSortasiModel.persentaseAir.toString()),
        MapEntry(
          "persentase_lain_lain_potongan",
          inputSortasiModel.persentaseLainLainPotongan.toString(),
        ),
        MapEntry(
          "persentase_mengkal",
          inputSortasiModel.persentaseMengkal.toString(),
        ),
        MapEntry(
          "persentase_mutu",
          inputSortasiModel.persentaseMutu.toString(),
        ),
        MapEntry(
          "persentase_pasir",
          inputSortasiModel.persentasePasir.toString(),
        ),
        MapEntry(
          "persentase_sampah",
          inputSortasiModel.persentaseSampah.toString(),
        ),
        MapEntry(
          "persentase_tangkai",
          inputSortasiModel.persentaseTangkai.toString(),
        ),
        MapEntry(
          "total_persentase_potongan",
          inputSortasiModel.totalPersentasePotongan.toString(),
        ),
        MapEntry("jumlah_busuk", inputSortasiModel.jumlahBusuk.toString()),
        MapEntry(
          "jumlah_lain_lain_pulangan",
          inputSortasiModel.jumlahLainLainPulangan.toString(),
        ),
        MapEntry("jumlah_mentah", inputSortasiModel.jumlahMentah.toString()),
        MapEntry("jumlah_tankos", inputSortasiModel.jumlahTankos.toString()),
        MapEntry("jumlah_kecil", inputSortasiModel.jumlahKecil.toString()),
        MapEntry(
          "total_jumlah_pulangan",
          inputSortasiModel.totalJumlahPulangan.toString(),
        ),
      ]);

      form.fields.add(
        MapEntry("jenis[]", inputSortasiModel.jenis),
      ); // m.jenis: String

      for (final path in inputSortasiModel.photo) {
        final f = File(path);
        if (!f.existsSync()) {
          print("File not found at path: $path");
          continue;
        }
        form.files.add(
          MapEntry(
            "photo[]",
            await MultipartFile.fromFile(path, filename: p.basename(path)),
          ),
        );
      }

      // FormData formData = FormData.fromMap({
      //   "berat_tandan": inputSortasiModel.beratTandan,
      //   "brondolan": inputSortasiModel.brondolan,
      //   "catatan": inputSortasiModel.catatan,
      //   "dura": inputSortasiModel.dura,
      //   "jenis_buah_id": inputSortasiModel.jenisBuahId,
      //   "pulang_semua": inputSortasiModel.pulangSemua,
      //   "is_confirmed_checked": inputSortasiModel.isConfirmedChecked,
      //   "transaksi_id": inputSortasiModel.transaksiId,
      //   "persentase_air": inputSortasiModel.persentaseAir,
      //   "persentase_lain_lain_potongan":
      //       inputSortasiModel.persentaseLainLainPotongan,
      //   "persentase_mengkal": inputSortasiModel.persentaseMengkal,
      //   "persentase_mutu": inputSortasiModel.persentaseMutu,
      //   "persentase_pasir": inputSortasiModel.persentasePasir,
      //   "persentase_sampah": inputSortasiModel.persentaseSampah,
      //   "persentase_tangkai": inputSortasiModel.persentaseTangkai,
      //   "total_persentase_potongan": inputSortasiModel.totalPersentasePotongan,
      //   "jumlah_busuk": inputSortasiModel.jumlahBusuk,
      //   "jumlah_lain_lain_pulangan": inputSortasiModel.jumlahLainLainPulangan,
      //   "jumlah_mentah": inputSortasiModel.jumlahMentah,
      //   "jumlah_tankos": inputSortasiModel.jumlahTankos,
      //   "total_jumlah_pulangan": inputSortasiModel.totalJumlahPulangan,
      //   "jenis[]": inputSortasiModel.jenis,
      //   "photo[]": photoFiles,
      // });

      final response = await _dio.post(Endpoints.sortasi, data: form);

      return response.statusCode;
    } on DioException catch (e) {
      print("isi error: $e");
      // if (e.type == DioExceptionType.receiveTimeout ||
      //     e.type == DioExceptionType.connectionTimeout) {
      //   throw ApiClientTimeout();
      // }
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      print("isi error: $e");
      throw e.toString();
    }
  }

  Future inputSortasiReport(
    InputReportSortasiModel inputReportSortasiModel,
  ) async {
    try {
      List<MultipartFile> photoFiles = [];
      for (String photoPath in inputReportSortasiModel.photo) {
        File photoFile = File(photoPath);
        if (photoFile.existsSync()) {
          photoFiles.add(await MultipartFile.fromFile(photoPath));
        } else {
          print("file not found at path: $photoPath");
        }
      }
      FormData formData = FormData.fromMap({
        "description": inputReportSortasiModel.description,
        "transaksi_material_id": inputReportSortasiModel.transaksiMaterialId,
        "notes": inputReportSortasiModel.notes,
        "photo": photoFiles,
      });

      final response = await _dio.post(Endpoints.sortasiReport, data: formData);
      return response.statusCode;
    } on DioException catch (e) {
      print("isi error: $e");
    } catch (e) {
      print("isi error: $e");
      throw e.toString();
    }
  }

  Future<GetByIdSortasiModel> getDataSortasiById(String id) async {
    try {
      final response = await _dio.get("${Endpoints.sortasi}/$id");
      print("isi data sortasi: ${response.data}");

      return GetByIdSortasiModel.fromJson(
        response.data['sortasi'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      print("isi error: $e");
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      print("isi error: $e");
      throw e.toString();
    }
  }

  Future deleteDataSortasiById(
    String id,
    DeleteSortasiModel deleteSortasiModel,
  ) async {
    try {
      final response = await _dio.delete(
        "${Endpoints.sortasi}/$id/cancel",
        data: deleteSortasiModel.toJson(),
      );

      return response.statusCode;
    } on DioException catch (e) {
      print("isi error: $e");
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      print("isi error: $e");
      throw e.toString();
    }
  }
}
