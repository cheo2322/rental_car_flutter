import 'package:flutter/material.dart';
import 'package:rental_car_flutter/model/brand_name_dto.dart';
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
      print("Error loading models: $e");
      setState(() {
        _loadingModels = false;
      });
    }
  }

  Future<BrandNameDto> _createBrandAndModel(
    String brandName,
    String modelName,
  ) async {
    try {
      final data = await _apiService.postBrandAndModel(brandName, modelName);
      return data!;
    } catch (e) {
      print("Error when creating brand and model: $e");
      rethrow;
    }
  }

  Future<IdAndNameDto> _createModelByNameAndBrandId(
    String brandId,
    String modelName,
  ) async {
    try {
      final data = await _apiService.postModelByNameAndBrandId(
        brandId,
        modelName,
      );
      return data!;
    } catch (e) {
      print("Error when creating model by name and brand ID: $e");
      rethrow;
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
      appBar: AppBar(title: Text('Register my car')),
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
                                _selectedModel = null;
                                _loadingModels = true;
                                _models.clear();
                                _selectedBrand = newValue;
                                _fetchModels(_selectedBrand!);
                              });
                            },
                          ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed:
                      _loadingBrands || _selectedModel != null
                          ? null
                          : () {
                            _showAddBrandModelDialog(context);
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
                      onPressed:
                          _loadingBrands || _selectedModel != null
                              ? null
                              : () {
                                _showAddModelDialog(context);
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

  void _showAddBrandModelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController brandController = TextEditingController();
        TextEditingController modelController = TextEditingController();
        bool isAddEnabled = false;

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: brandController,
                    onChanged: (value) {
                      setStateDialog(() {
                        isAddEnabled =
                            value.length >= 2 &&
                            modelController.text.length >= 2;
                      });
                    },
                    decoration: InputDecoration(hintText: "Brand"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: modelController,
                    onChanged: (value) {
                      setStateDialog(() {
                        isAddEnabled =
                            value.length >= 2 &&
                            brandController.text.length >= 2;
                      });
                    },
                    decoration: InputDecoration(hintText: "Model"),
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed:
                      isAddEnabled
                          ? () {
                            final newBrandName = brandController.text;
                            final newModelName = modelController.text;

                            Navigator.of(context).pop();

                            _createBrandAndModel(newBrandName, newModelName)
                                .then((response) {
                                  setState(() {
                                    if (!_brands.any(
                                      (brand) => brand.id == response.brandId,
                                    )) {
                                      _brands.add(
                                        IdAndNameDto(
                                          id: response.brandId,
                                          name: response.brandName,
                                        ),
                                      );
                                    }

                                    if (!_models.any(
                                      (model) => model.id == response.modelId,
                                    )) {
                                      _models.add(
                                        IdAndNameDto(
                                          id: response.modelId,
                                          name: response.modelName,
                                        ),
                                      );
                                    }
                                    _selectedBrand = response.brandId;
                                    _selectedModel = response.modelId;

                                    _loadingBrands = false;
                                    _loadingModels = false;
                                  });
                                })
                                .catchError((error) {
                                  print("Error: $error");
                                });
                          }
                          : null,
                  child: Text("Add"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddModelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController modelController = TextEditingController();
        bool isAddEnabled = false;

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              content: TextField(
                controller: modelController,
                onChanged: (value) {
                  setStateDialog(() {
                    isAddEnabled = value.length >= 2;
                  });
                },
                decoration: InputDecoration(hintText: "Model"),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed:
                      isAddEnabled
                          ? () {
                            final newModelName = modelController.text;

                            Navigator.of(context).pop();

                            _createModelByNameAndBrandId(
                                  _selectedBrand!,
                                  newModelName,
                                )
                                .then((response) {
                                  setState(() {
                                    if (!_models.any(
                                      (model) => model.id == response.id,
                                    )) {
                                      _models.add(
                                        IdAndNameDto(
                                          id: response.id,
                                          name: response.name,
                                        ),
                                      );
                                    }

                                    _selectedModel = response.id;
                                    _loadingModels = false;
                                  });
                                })
                                .catchError((error) {
                                  print("Error: $error");
                                });
                          }
                          : null,
                  child: Text("Add"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
