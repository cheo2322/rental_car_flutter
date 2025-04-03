import 'package:dio/dio.dart';
import 'package:rental_car_flutter/model/id_and_name_dto.dart';

class ApiService {
  final Dio _dio;

  ApiService({
    String baseUrl = "https://rental-car-syec.onrender.com/rental-car/v1",
  }) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<IdAndNameDto>> getBrands() async {
    try {
      final response = await _dio.get("/brands");
      final data = response.data;
      if (data != null) {
        return IdAndNameDto.fromJsonList(data);
      }
      return [];
    } catch (e) {
      print("Error en getBrands: $e");
      return [];
    }
  }

  //   // Llamada API 1: Obtener datos con filtro
  //   Future<List<IdAndNameDto>> getData(String filter) async {
  //     try {
  //       final response = await _dio.get(
  //         "/users", // Endpoint
  //         queryParameters: {"filter": filter}, // Parámetros de consulta
  //       );
  //       final data = response.data;
  //       if (data != null) {
  //         return IdAndNameDto.fromJsonList(data); // Conversión de JSON a DTOs
  //       }
  //       return [];
  //     } catch (e) {
  //       print("Error en getData: $e");
  //       return [];
  //     }
  //   }

  //   // Llamada API 2: Ejemplo de otra función (puedes agregar más)
  //   Future<List<IdAndNameDto>> getOtherData() async {
  //     try {
  //       final response = await _dio.get("/other-endpoint"); // Otro endpoint
  //       final data = response.data;
  //       if (data != null) {
  //         return IdAndNameDto.fromJsonList(data);
  //       }
  //       return [];
  //     } catch (e) {
  //       print("Error en getOtherData: $e");
  //       return [];
  //     }
  //   }

  //   // Llamada API 3: Ejemplo de una solicitud POST
  //   Future<void> postData(Map<String, dynamic> body) async {
  //     try {
  //       final response = await _dio.post(
  //         "/users", // Endpoint para POST
  //         data: body, // Cuerpo de la solicitud
  //       );
  //       print("Respuesta POST: ${response.data}");
  //     } catch (e) {
  //       print("Error en postData: $e");
  //     }
  //   }
}
