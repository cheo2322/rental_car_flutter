import 'package:flutter/material.dart';

class CarRegister extends StatefulWidget {
  const CarRegister({super.key});

  @override
  State<CarRegister> createState() => _CarRegisterState();
}

class _CarRegisterState extends State<CarRegister> {
  // Controladores de texto
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();

  // Variables para controlar los dropdowns
  String? _selectedType; // Tipo de auto
  String? _selectedTransmission; // Transmisión

  // Variables para la validación
  bool _nameError = false;
  bool _modelError = false;
  bool _typeError = false;
  bool _transmissionError = false;

  @override
  void dispose() {
    // Liberar recursos de los controladores al cerrar la página
    _carNameController.dispose();
    _carModelController.dispose();
    super.dispose();
  }

  bool _isFormComplete() {
    return _carNameController.text.isNotEmpty &&
        _carModelController.text.isNotEmpty &&
        _selectedType != null &&
        _selectedTransmission != null;
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
            // TextField(
            //   controller: _carNameController,
            //   decoration: InputDecoration(
            //     labelText: 'Nombre del Auto *',
            //     border: OutlineInputBorder(),
            //     errorText: _nameError ? 'Este campo es obligatorio' : null,
            //   ),
            // ),
            // SizedBox(height: 16),

            // TextField(
            //   controller: _carModelController,
            //   decoration: InputDecoration(
            //     labelText: 'Modelo del Auto *',
            //     border: OutlineInputBorder(),
            //     errorText: _modelError ? 'Este campo es obligatorio' : null,
            //   ),
            // ),
            // SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Marca *',
                border: OutlineInputBorder(),
                errorText: _typeError ? 'Este campo es obligatorio' : null,
              ),
              value: _selectedType,
              items:
                  ['Eléctrico', 'Combustión'].map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue;
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

            // Botón Registrar
            ElevatedButton(
              onPressed:
                  _isFormComplete()
                      ? () {
                        setState(() {
                          // Validación de los campos
                          _nameError = _carNameController.text.isEmpty;
                          _modelError = _carModelController.text.isEmpty;
                          _typeError = _selectedType == null;
                          _transmissionError = _selectedTransmission == null;
                        });

                        if (_isFormComplete()) {
                          // Acción al guardar el formulario
                          print(
                            'Nombre: ${_carNameController.text}, Modelo: ${_carModelController.text}, Tipo: $_selectedType, Transmisión: $_selectedTransmission',
                          );
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
