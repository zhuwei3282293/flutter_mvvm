// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order()
    ..orderNumber = json['orderNumber'] as String
    ..bId = json['bId'] as String
    ..businUrl = json['businUrl'] as String
    ..businUrl2 = json['businUrl2'] as String
    ..id = json['_id'] as String;
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'bId': instance.bId,
      'businUrl': instance.businUrl,
      'businUrl2': instance.businUrl2,
      '_id': instance.id
    };
