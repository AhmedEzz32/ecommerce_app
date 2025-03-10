import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {

  final String id;

  final String title;
  final String description;

  final num price;

  final String image;

  const ProductModel({
    required this.id,

    required this.title,
    required this.description,

    required this.image,
    
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
