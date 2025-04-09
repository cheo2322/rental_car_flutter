class BrandNameDto {
  final String? brandId;
  final String? modelId;
  final String brandName;
  final String modelName;

  BrandNameDto({
    required this.brandId,
    required this.modelId,
    required this.brandName,
    required this.modelName,
  });

  factory BrandNameDto.fromJson(Map<String, dynamic> json) {
    return BrandNameDto(
      brandId: json['brandId'],
      modelId: json['modelId'],
      brandName: json['brandName'],
      modelName: json['modelName'],
    );
  }

  static List<BrandNameDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BrandNameDto.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'modelId': modelId,
      'brandName': brandName,
      'modelName': modelName,
    };
  }
}
