import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int _id;
  String orderNumber;
  String bId;
  String businUrl;
  String businUrl2;

  @JsonKey(name: '_id', nullable: true)
  String id;

  Order();
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
