
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_one/res/appurl.dart';


import '../../app_colors.dart';
import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';
import 'Adding medicine two.dart';
import 'package:http/http.dart' as http;


class AddingMedicineone extends StatefulWidget {
  const AddingMedicineone({super.key});

  @override
  State<AddingMedicineone> createState() => _AddingMedicineoneState();
}

class _AddingMedicineoneState extends State<AddingMedicineone> {
  String? _selectedMedicine;
  String? fileName;
  TextEditingController _medicineNameController = TextEditingController();
  Map<String, dynamic>? selectedMedicine;


  Future<void> pickFile() async {
    final ImagePicker _picker = ImagePicker();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () async {
                  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    setState(() {
                      fileName = photo.name;
                    });
                  }
                  Navigator.pop(context);
                },
                child: Text('Open Camera'),
              ),
              TextButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null) {
                    setState(() {
                      fileName = result.files.single.name;
                    });
                  }
                  Navigator.pop(context);
                },
                child: Text('Open Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }
  List<dynamic> _medicines = [];

  Future<void> fetchMedicineData() async {
    final url = Uri.parse(AppUrl.getMedicine); // Replace with your API URL
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          _medicines = jsonResponse['data']; // Assuming 'data' contains the list of medicines
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchMedicineData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.pageColor,
        leading: Dronewidgets.backButton(context),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Dronewidgets.mainButton(
              title: 'Next',
              onPressed: () {
                if (_selectedMedicine != null && _medicineNameController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddingMedicineTwo(
                        medicineName: _medicineNameController.text,
                        medicineType: _selectedMedicine!,
                        selectedMedicine: selectedMedicine!,
                      ),
                    ),
                  );
                } else {
                  // Show Flushbar if any field is empty
                  showFlushbar(context, 'Please select a medicine type and enter the medicine name', Colors.red);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Now,",
                style: text50026black,
              ),
              SizedBox(height: 8),
              Text(
                "Let’s Add Medicine",
                style: text50026black,
              ),
              //new medicine
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _medicineNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your medicine here',
                  ),
                ),
                suggestionsCallback: (pattern) {
                  // Filter API data based on user input
                  return _medicines.where((medicine) =>
                      medicine['name'].toLowerCase().contains(pattern.toLowerCase()));
                },
                itemBuilder: (context, suggestion) {
                  // Build a suggestion tile
                  return ListTile(
                    leading: Image.network(suggestion['images']['image1'], width: 50),
                    title: Text(suggestion['name']),
                  );
                },
                onSuggestionSelected: (suggestion) {setState(() {
                  selectedMedicine = {
                    'id':suggestion['id'],
                    'name':suggestion['name'],
                  };
                  _medicineNameController.text = suggestion['name'];
                });


                },
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No suggestions found!'),
                ),
              ),


              SizedBox(height: 30),
              Text(
                "Select medicine type",
                style: text50018primary,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _selectMedicine('Pills'),
                    child: _MedicineContainer('Pills', 'assets/images/medicine.png'),
                  ),
                  GestureDetector(
                    onTap: () => _selectMedicine('Syringe'),
                    child: _MedicineContainer('Syringe', 'assets/images/syringe.png'),
                  ),
                  GestureDetector(
                    onTap: () => _selectMedicine('Syrup'),
                    child: _MedicineContainer('Syrup', 'assets/images/syrup.png'),
                  ),
                  GestureDetector(
                    onTap: () => _selectMedicine('Ointment'),
                    child: _MedicineContainer('Ointment', 'assets/images/ointment.png'),
                  ),
                ],
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: pickFile,
                child: Center(
                  child: DottedBorder(
                    color: Colors.black,
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    child: Container(
                      width: 280,
                      height: 108,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          fileName != null
                              ? Icon(Icons.photo, color: AppColors.primaryColor2)
                              : Icon(Icons.photo, color: Colors.grey),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Take photo of medicine', style: text50012primary),
                              Text('to identify', style: text50012primary),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectMedicine(String medicineType) {
    setState(() {
      _selectedMedicine = medicineType;
    });
  }

  Widget _MedicineContainer(String medicineType, String imagePath) {
    bool isSelected = _selectedMedicine == medicineType;
    return Container(
      width: 68,
      height: 67,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor2 : Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }

  // Show Flushbar when there's an error
  void showFlushbar(BuildContext context, String message, Color backgroundColor) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      backgroundColor: backgroundColor,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      margin: EdgeInsets.all(8),
    )..show(context);
  }
}