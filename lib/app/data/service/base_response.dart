import 'dart:developer';

class BaseResponse<T> {
  final T? body;
  final String? message;
  final bool? success;

  BaseResponse({this.body, this.message, this.success});

  factory BaseResponse.fromJson(dynamic json, T Function(dynamic json)? fromJsonT) {
    try {
      bool? success = true;
      String? message;
      T? body;

      if (json is Map<String, dynamic>) {
        success = json['success'] as bool? ?? success;

        // Safely handle message
        final rawMessage = json['message'];
        if (rawMessage is String) {
          message = rawMessage;
        } else if (rawMessage is Map) {
          message = rawMessage.values.map((v) => v is List ? v.join(', ') : v.toString()).join(', ');
        } else if (rawMessage != null) {
          message = rawMessage.toString();
        }

        final dynamic rawData = json['data'] ?? json;

        if (fromJsonT != null && rawData != null) {
          body = fromJsonT(rawData);
        } else if (rawData is T) {
          body = rawData;
        } else if (rawData is String) {
          body = rawData as T;
        }
      } else if (json is List) {
        if (fromJsonT != null) {
          body = fromJsonT(json);
        }
      } else if (json is String) {
        message = json;
      } else {
        if (fromJsonT != null) {
          body = fromJsonT(json);
        }
      }

      return BaseResponse(success: success, message: message, body: body);
    } catch (e, s) {
      log('Error parsing BaseResponse', error: e, stackTrace: s);
      return BaseResponse(success: false, message: 'Failed to parse response: $e');
    }
  }
}
