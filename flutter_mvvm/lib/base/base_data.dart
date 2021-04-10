import 'package:json_annotation/json_annotation.dart';

class BaseResponse {
  int code;
  int total;
  int totalPage;
  dynamic data;
  String message;
  bool success;

  BaseResponse(
      {this.code,
      this.total,
      this.totalPage,
      this.data,
      this.message,
      this.success});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class CommonResponse {
  int code;
  dynamic data;
  String message;
  bool success;

  CommonResponse();

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse(
      code: json['code'] as int,
      total: json['total'] as int,
      totalPage: json['totalPage'] as int,
      data: json['data'],
      message: json['message'] as String,
      success: json['success'] as bool);
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'total': instance.total,
      'totalPage': instance.totalPage,
      'data': instance.data,
      'message': instance.message,
      'success': instance.success
    };

CommonResponse _$CommonResponseFromJson(Map<String, dynamic> json) {
  return CommonResponse()
    ..code = json['code'] as int
    ..data = json['data']
    ..message = json['message'] as String
    ..success = json['success'] as bool;
}

Map<String, dynamic> _$CommonResponseToJson(CommonResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
      'success': instance.success
    };
