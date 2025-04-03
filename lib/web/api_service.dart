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

  Future<List<IdAndNameDto>> getModels(String brandId) async {
    try {
      final response = await _dio.get("/brands/$brandId/models");
      final data = response.data;
      if (data != null) {
        return IdAndNameDto.fromJsonList(data);
      }
      return [];
    } catch (e) {
      print("Error en getModels: $e");
      return [];
    }
  }

  Future<IdAndNameDto?> postBrand(String name) async {
    try {
      final response = await _dio.post(
        "/brands",
        data: IdAndNameDto(name: name, id: null).toJson(),
      );
      print("Respuesta POST: ${response.data}");
      return IdAndNameDto.fromJson(response.data);
    } catch (e) {
      print("Error en postData: $e");

      return null;
    }
  }
}
