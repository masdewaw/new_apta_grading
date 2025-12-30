import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

class DioExceptionHandler implements Exception {
  final String message;
  DioExceptionHandler(this.message);

  factory DioExceptionHandler.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        return DioExceptionHandler('Request to the server was cancelled.');
      case DioExceptionType.connectionTimeout:
        return DioExceptionHandler('Connection timed out.');
      case DioExceptionType.sendTimeout:
        return DioExceptionHandler('Request send timeout.');
      case DioExceptionType.receiveTimeout:
        return DioExceptionHandler('Receiving timeout occurred.');
      case DioExceptionType.badCertificate:
        return DioExceptionHandler(
          'Koneksi gagal karena sertifikat SSL tidak valid.',
        );
      case DioExceptionType.connectionError:
        // Biasanya SocketException / DNS / offline
        if (e.error is SocketException) {
          return DioExceptionHandler(
            'Tidak ada koneksi internet. Periksa jaringan Anda.',
          );
        }
        // Bisa juga timeout dari adapter tertentu
        if (e.error is TimeoutException) {
          return DioExceptionHandler('Connection timed out.');
        }
        return DioExceptionHandler('Periksa kembali jaringan anda.');
      case DioExceptionType.badResponse:
        // Server mengembalikan status code (mis. 408/504 timeout di server)
        final code = e.response?.statusCode;
        final msg = _statusMessage(code, e.response?.data);
        return DioExceptionHandler(msg);
      case DioExceptionType.unknown:
        // Waspadai TimeoutException/SocketException di sini juga
        final err = e.error;
        if (err is TimeoutException) {
          return DioExceptionHandler('Operation timed out.');
        }
        if (err is SocketException) {
          return DioExceptionHandler(
            'Tidak ada koneksi internet. Periksa jaringan Anda.',
          );
        }
        return DioExceptionHandler('Oops, terjadi kesalahan!');
    }
  }

  static String _statusMessage(int? statusCode, dynamic data) {
    // Jika backend mengirim pesan di body, coba ekstrak
    final serverMsg = _extractServerMessage(data);
    switch (statusCode) {
      case 400:
        return serverMsg ?? 'Kesalahan proses request.';
      case 401:
        return serverMsg ?? 'Email atau password anda salah.';
      case 403:
        return serverMsg ?? 'Akses ditolak.';
      case 404:
        return serverMsg ?? 'Sumber tidak ditemukan.';
      case 408:
        return serverMsg ?? 'Request timeout (408).';
      case 500:
        return serverMsg ?? 'Internal server error.';
      case 502:
        return serverMsg ?? 'Bad gateway (502).';
      case 503:
        return serverMsg ?? 'Service unavailable (503).';
      case 504:
        return serverMsg ?? 'Gateway timeout (504).';
      default:
        return serverMsg ?? 'Oops, terjadi kesalahan!';
    }
  }

  static String? _extractServerMessage(dynamic data) {
    // Sesuaikan dengan pola respons API kamu
    if (data is Map) {
      // contoh: {"message":"..."} atau {"error":"..."}
      if (data['message'] is String) return data['message'] as String;
      if (data['error'] is String) return data['error'] as String;
    }
    return null;
    // Bisa diperluas untuk list/string, dsb.
  }

  @override
  String toString() => message;
}
