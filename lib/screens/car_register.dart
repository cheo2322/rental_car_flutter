import 'package:flutter/material.dart';
import 'package:rental_car_flutter/model/id_and_name_dto.dart';
import 'package:rental_car_flutter/web/api_service.dart';

class CarRegister extends StatefulWidget {
  const CarRegister({super.key});

  @override
  State<CarRegister> createState() => _CarRegisterState();
}

class _CarRegisterState extends State<CarRegister> {
  // Controladores de texto
  // final TextEditingController _carNameController = TextEditingController();
  // final TextEditingController _carModelController = TextEditingController();

  String? _selectedBrand;
  String? _selectedModel;

  final ApiService _apiService = ApiService(); // Instancia del servicio

  // // Variables para controlar los dropdowns
  // String? _selectedType; // Tipo de auto
  // String? _selectedTransmission; // Transmisión

  // Variables para la validación
  // bool _nameError = false;
  // bool _modelError = false;
  // bool _typeError = false;
  // bool _transmissionError = false;
  bool _brandError = false;
  bool _modelError = false;

  bool _isFormComplete() {
    // return _carNameController.text.isNotEmpty &&
    //     _carModelController.text.isNotEmpty &&
    //     _selectedType != null &&
    //     _selectedTransmission != null;
    return _selectedBrand != null && _selectedModel != null;
  }

  List<IdAndNameDto> _brands = [];
  List<IdAndNameDto> _models = [];

  bool _loadingBrands = true;
  bool _loadingModels = true;

  Future<void> _fetchBrands() async {
    try {
      final data = await _apiService.getBrands();
      setState(() {
        _brands = data;
        _loadingBrands = false;
      });
    } catch (e) {
      print("Error al cargar tipos: $e");
      setState(() {
        _loadingBrands = false;
      });
    }
  }

  Future<void> _fetchModels(String brandId) async {
    try {
      final data = await _apiService.getModels(brandId);
      setState(() {
        _models = data;
        _loadingModels = false;
      });
    } catch (e) {
      print("Error al cargar modelos: $e");
      setState(() {
        _loadingModels = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBrands();
  }

  @override
  void dispose() {
    // _carNameController.dispose();
    // _carModelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Auto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child:
                      _loadingBrands
                          ? Center(child: CircularProgressIndicator())
                          : DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Brand* (press the + button to add)',
                              border: OutlineInputBorder(),
                              errorText: _brandError ? 'Mandatory field' : null,
                            ),
                            value: _selectedBrand,
                            items:
                                _brands.map((IdAndNameDto item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedBrand = newValue;
                                _fetchModels(_selectedBrand!);
                              });
                            },
                          ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    print('Botón de agregar presionado');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                  ),
                  child: Icon(Icons.add),
                ),
              ],
            ),

            _selectedBrand != null ? SizedBox(height: 16) : Container(),

            _selectedBrand != null
                ? Row(
                  children: [
                    Expanded(
                      child:
                          _loadingModels
                              ? Center(child: CircularProgressIndicator())
                              : DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText:
                                      'Model* (press the + button to add)',
                                  border: OutlineInputBorder(),
                                  errorText:
                                      _modelError ? 'Mandatory field' : null,
                                ),
                                value: _selectedModel,
                                items:
                                    _models.map((IdAndNameDto item) {
                                      return DropdownMenuItem<String>(
                                        value: item.id,
                                        child: Text(item.name),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedModel = newValue;
                                  });
                                },
                              ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        print('Botón de agregar presionado');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(12),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ],
                )
                : Container(),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  _isFormComplete()
                      ? () {
                        setState(() {
                          _brandError = _selectedBrand == null;
                          _modelError = _selectedModel == null;
                        });

                        if (_isFormComplete()) {
                          print(
                            'Brand: $_selectedBrand, Model: $_selectedModel',
                          );
                        }
                      }
                      : null,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
