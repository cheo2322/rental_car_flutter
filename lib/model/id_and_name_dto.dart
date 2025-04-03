class IdAndNameDto {
  final String id; // Identificador único como String
  final String name; // Nombre asociado

  // Constructor
  IdAndNameDto({required this.id, required this.name});

  // Método para convertir un JSON a una instancia de la clase DTO
  factory IdAndNameDto.fromJson(Map<String, dynamic> json) {
    return IdAndNameDto(id: json['id'], name: json['name']);
  }

  // Método para convertir una lista de JSONs a una lista de instancias DTO
  static List<IdAndNameDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => IdAndNameDto.fromJson(json)).toList();
  }

  // Método para convertir la clase DTO a JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
