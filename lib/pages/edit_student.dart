import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'welcome.dart';
import 'student_list.dart';

void main() {
  runApp(const UpdateStudent());
}

class UpdateStudent extends StatelessWidget {
  const UpdateStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examination Form',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ExaminationScreen(),
    );
  }
}

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({Key? key}) : super(key: key);

  @override
  _ExaminationScreenState createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  String? selectedExamType;
  String? selectedSubjectCode; // Separate state variable for subject code

  final List<String> examTypes = [
    'Quiz 1',
    'Quiz 2',
    'Quiz 3',
    'Quiz 4',
    'Examination',
  ];

  final List<String> subjectCodes = [
    'CRP 1102',
    'CMD 2913',
    'CIT 2134',
  ];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print('Selected file: ${file.path}');
    } else {
      print('File picking canceled');
    }
  }

  Future<void> _openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      File file = File(photo.path);
      print('Captured photo: ${file.path}');
    } else {
      print('Camera capture canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentList()),
            );
          },
        ),
        title: const Text(
          'Update Student',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Student Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: 'Light Yagami'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Subject Code',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedSubjectCode,
              items: subjectCodes.map((code) {
                return DropdownMenuItem(
                  value: code,
                  child: Text(code),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubjectCode = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              hint: const Text('Select Subject Code'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Exam Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedExamType,
              items: examTypes.map((examType) {
                return DropdownMenuItem(
                  value: examType,
                  child: Text(examType),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedExamType = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              hint: const Text('Select Exam Type'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Exam Detection',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildActionButton(
              icon: Icons.upload_file,
              label: 'File Upload',
              onPressed: _pickFile,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              icon: Icons.camera_alt,
              label: 'Open Camera',
              onPressed: _openCamera,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            const Text(
              'SCORE: 0 ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF00BF6D),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 48),
                  shape: const StadiumBorder(),
                ),
                child: const Text("SAVE"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
