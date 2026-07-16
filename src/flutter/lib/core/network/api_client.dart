import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Centralized Dio API Client for remote synchronization.
/// Enforces timeout constraints and interceptors for multi-tenant headers (`X-Tenant-Id`).
class ApiClient {
  final Dio _dio;
  final String tenantId;

  ApiClient({required String baseUrl, required this.tenantId})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {
              'Content-Type': 'application/json',
              'X-Tenant-Id': tenantId,
            },
          ),
        ) {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ),
    );
  }

  Dio get client => _dio;
}
