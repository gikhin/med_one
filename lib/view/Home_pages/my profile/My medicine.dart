import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:med_one/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../res/appurl.dart';
import 'gettingFeedback.dart';

class Mymedicine extends StatefulWidget {
  @override
  _MymedicineState createState() => _MymedicineState();
}

class _MymedicineState extends State<Mymedicine> {
  // Replace this URL with your actual API endpoint
  static const String apiUrl = "YOUR_API_ENDPOINT_HERE";

  Future<List<Map<String, dynamic>>> fetchMedicines() async {
    final url = Uri.parse(AppUrl.getmyMedicine); // Replace with actual API URL
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userID');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": int.parse(userId.toString())}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        final List<Map<String, dynamic>> medicines = [];

        // Process response to create a list of medicines with type and startDate
        for (var entry in responseData['data']) {
          for (var item in entry['medicine']) {
            medicines.add({
              "id": item['id'],
              "name": item['name'],
              "medicine_type": entry['medicine_type'],
              "startDate": entry['startDate'],
            });
          }
        }
        return medicines;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception("Failed to load medicines");
    }
  }


  void showFeedbackDialog(int medicineId) {
    final TextEditingController feedbackController = TextEditingController();
    bool acceptPrivacyPolicy = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets, // Adjusts for keyboard
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Provide Feedback",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: feedbackController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "If you have any additional feedback, please type it in here...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: acceptPrivacyPolicy,
                          onChanged: (value) {
                            setModalState(() {
                              acceptPrivacyPolicy = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "I have read and accept the Privacy Policy.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final feedback = feedbackController.text.trim();
                        if (feedback.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Feedback cannot be empty")),
                          );
                          return;
                        }
                        if (!acceptPrivacyPolicy) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("You must accept the Privacy Policy to continue.")),
                          );
                          return;
                        }
                        Navigator.pop(context);
                        await addFeedback(medicineId, feedback);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Submit feedback",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  Future<void> addFeedback(int medicineId, String feedback) async {
    final url = Uri.parse(AppUrl.addingFeedback); // Replace with actual API URL

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userID');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": int.parse(userId.toString()),
        "medicineId": medicineId,
        "feedback": [
          {"feedback": feedback}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feedback submitted successfully!")),
        );
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception("Failed to submit feedback");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.pageColor,
      appBar: AppBar(backgroundColor: AppColors.pageColor,centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Replace with your feedback navigation logic
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyFeedback()),
              );
            },
            icon: const Icon(Icons.reviews_outlined),
          ),
        ],
        title: const Text("My Medicines",style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchMedicines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No medicines found."));
          } else {
            final medicines = snapshot.data!;
            return ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the ListTile
                      borderRadius: BorderRadius.circular(12.0), // Curved edges
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: ListTile(tileColor: Colors.white,
                      title: Text(
                        medicine['name'],
                        style: text40016black,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Type: ${medicine['medicine_type']}"),
                          Text("Start Date: ${medicine['startDate']}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.reviews_rounded, color: Colors.blue),
                        onPressed: () => showFeedbackDialog(medicine['id']),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


