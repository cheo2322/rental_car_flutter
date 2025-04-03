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

  bool _isFormComplete() {
    // return _carNameController.text.isNotEmpty &&
    //     _carModelController.text.isNotEmpty &&
    //     _selectedType != null &&
    //     _selectedTransmission != null;
    return _selectedBrand != null;
  }

  List<IdAndNameDto> _brands = [];
  bool _loadingBrands = true;

  Future<void> _fetchTypes() async {
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

  @override
  void initState() {
    super.initState();
    _fetchTypes();
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
            _loadingBrands
                ? CircularProgressIndicator()
                : DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Marca *',
                    border: OutlineInputBorder(),
                    errorText: _brandError ? 'Este campo es obligatorio' : null,
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
                    });
                  },
                ),
            SizedBox(height: 16),

            // DropdownButtonFormField<String>(
            //   decoration: InputDecoration(
            //     labelText: 'Transmisión *',
            //     border: OutlineInputBorder(),
            //     errorText:
            //         _transmissionError ? 'Este campo es obligatorio' : null,
            //   ),
            //   value: _selectedTransmission,
            //   items:
            //       ['Manual', 'Automático'].map((String transmission) {
            //         return DropdownMenuItem<String>(
            //           value: transmission,
            //           child: Text(transmission),
            //         );
            //       }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedTransmission = newValue;
            //     });
            //   },
            // ),
            // SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  _isFormComplete()
                      ? () {
                        setState(() {
                          // Validación de los campos
                          // _nameError = _carNameController.text.isEmpty;
                          // _modelError = _carModelController.text.isEmpty;
                          // _typeError = _selectedType == null;
                          // _transmissionError = _selectedTransmission == null;
                          _brandError = _selectedBrand == null;
                        });

                        if (_isFormComplete()) {
                          // Acción al guardar el formulario
                          print('Brand: $_selectedBrand');
                        }
                      }
                      : null, // Deshabilitar si no está completo
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
