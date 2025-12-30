import 'package:new_apta_grading/core/network/instance/sortasi_instance.dart';
import 'package:new_apta_grading/features/home/data/model/asisten_sortasi_model.dart';
import 'package:new_apta_grading/features/home/data/model/change_shift_model.dart';
import 'package:new_apta_grading/features/home/data/model/jenis_buah_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_by_id_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_pagination_model.dart';
import 'package:new_apta_grading/features/home/data/model/sortasi_report_pagination_model.dart';
import 'package:new_apta_grading/features/home/data/model/transaksi_material_sortasi_model.dart';

/// Abstract repository interface for Sortasi related operations
abstract class ISortasiRepository {
  Future<List<TransaksiMaterialModel>> getTrukSortasi();
  Future<List<JenisBuahModel>> getJenisBuah();
  Future<List<AsistenSortasiModel>> getAsistenSortasi();
  Future<dynamic> changeShiftSortasi(ChangeShiftModel changeShiftModel);
  Future<List<GetSortasiModel>> getDataSortasi();
  Future<SortasiPaginationModel> getDataSortasiPagination(int page);
  Future<SortasiReportPaginationModel> getDataSortasiReportPagination(int page);
  Future<dynamic> inputSortasi(InputSortasiModel inputSortasiModel);
  Future<dynamic> inputSortasiReport(
    InputReportSortasiModel inputReportSortasiModel,
  );
  Future<GetByIdSortasiModel> getDataSortasiById(String id);
  Future<dynamic> deleteDataSortasiById(
    String id,
    DeleteSortasiModel deleteSortasiModel,
  );
}

/// Implementation of [ISortasiRepository] that uses [SortasiAPI]
class SortasiRepository implements ISortasiRepository {
  final SortasiAPI _sortasiAPI;

  SortasiRepository({SortasiAPI? sortasiAPI})
    : _sortasiAPI = sortasiAPI ?? SortasiAPI();

  @override
  Future<List<TransaksiMaterialModel>> getTrukSortasi() async {
    return await _sortasiAPI.getTrukSortasi();
  }

  @override
  Future<List<JenisBuahModel>> getJenisBuah() async {
    return await _sortasiAPI.getJenisBuah();
  }

  @override
  Future<List<AsistenSortasiModel>> getAsistenSortasi() async {
    return await _sortasiAPI.getAsistenSortasi();
  }

  @override
  Future<dynamic> changeShiftSortasi(ChangeShiftModel changeShiftModel) async {
    return await _sortasiAPI.changeShiftSortasi(changeShiftModel);
  }

  @override
  Future<List<GetSortasiModel>> getDataSortasi() async {
    return await _sortasiAPI.getDataSortasi();
  }

  @override
  Future<SortasiPaginationModel> getDataSortasiPagination(int page) async {
    return await _sortasiAPI.getDataSortasiPagination(page);
  }

  @override
  Future<SortasiReportPaginationModel> getDataSortasiReportPagination(
    int page,
  ) async {
    return await _sortasiAPI.getDataSortasiReportPagination(page);
  }

  @override
  Future<dynamic> inputSortasi(InputSortasiModel inputSortasiModel) async {
    return await _sortasiAPI.inputSortasi(inputSortasiModel);
  }

  @override
  Future<dynamic> inputSortasiReport(
    InputReportSortasiModel inputReportSortasiModel,
  ) async {
    return await _sortasiAPI.inputSortasiReport(inputReportSortasiModel);
  }

  @override
  Future<GetByIdSortasiModel> getDataSortasiById(String id) async {
    return await _sortasiAPI.getDataSortasiById(id);
  }

  @override
  Future<dynamic> deleteDataSortasiById(
    String id,
    DeleteSortasiModel deleteSortasiModel,
  ) async {
    return await _sortasiAPI.deleteDataSortasiById(id, deleteSortasiModel);
  }
}
