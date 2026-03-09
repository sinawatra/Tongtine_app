import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _tokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _tokenExpiryKey = 'token_expiry';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  Future<String?> getToken() => _storage.read(key: _tokenKey);

  Future<void> deleteToken() => _storage.delete(key: _tokenKey);

  Future<void> saveRefreshToken(String token) => _storage.write(key: _refreshTokenKey, value: token);

  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> deleteRefreshToken() => _storage.delete(key: _refreshTokenKey);
  
  Future<DateTime?> getTokenExpiry() async {
  final raw = await _storage.read(key: _tokenExpiryKey);
  if (raw == null) return null;
  return DateTime.tryParse(raw);
    }

  Future<bool> hasValidToken() async {
    final token = await getToken();
    log("hasValidToken $token");
    if (token == null || token.isEmpty) return false;

    final expiry = await getTokenExpiry();
    log("Token expired at  $expiry");
    if (expiry == null) return true;

    return DateTime.now().isBefore(expiry);
  }

  Future<void> saveToken(String token) async {
  final expiryDate = _getJwtExpiry(token);
  await _storage.write(key: _tokenKey, value: token);
  await _storage.write(key: _tokenExpiryKey, value: expiryDate.toString());
  }
    Future<void> clearAll() async {
    await _storage.deleteAll();
    await deleteToken();
    await deleteRefreshToken();
  }

  DateTime? _getJwtExpiry(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final map = jsonDecode(decoded) as Map<String, dynamic>;

      final exp = map['exp'];
      if (exp is! num) return null;

      return DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000);
    } catch (_) {
      return null;
    }
  }
  }