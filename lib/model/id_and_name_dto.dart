class IdAndNameDto {
  final String? id;
  final String name;

  // Constructor
  IdAndNameDto({required this.id, required this.name});

  factory IdAndNameDto.fromJson(Map<String, dynamic> json) {
    return IdAndNameDto(id: json['id'], name: json['name']);
  }

  static List<IdAndNameDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => IdAndNameDto.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
