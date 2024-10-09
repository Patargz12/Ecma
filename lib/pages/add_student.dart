import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'student_list.dart';

void main() {
  runApp(const AddStudent());
}

class AddStudent extends StatelessWidget {
  const AddStudent({Key? key}) : super(key: key);

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
  String? selectedSubjectCode;
  String? selectedExamType;
  final List<String> examTypes = [
    'Quiz 1',
    'Quiz 2',
    'Quiz 3',
    'Quiz 4',
    'Exam',
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
          'Add Student',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Student Name'),
            const SizedBox(height: 8),
            _buildTextField('Enter Name'),
            const SizedBox(height: 16),
            _buildSectionTitle('Subject Code'),
            const SizedBox(height: 8),
            _buildDropdown(
              hint: 'Select Subject Code',
              items: subjectCodes,
              value: selectedSubjectCode,
              onChanged: (value) => setState(() => selectedSubjectCode = value),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Exam Type'),
            const SizedBox(height: 8),
            _buildDropdown(
              hint: 'Select Exam Type',
              items: examTypes,
              value: selectedExamType,
              onChanged: (value) => setState(() => selectedExamType = value),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Exam Detection'),
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
            const SizedBox(height: 32),
            _buildSectionTitle('SCORE: 0'),
            const SizedBox(height: 100),
            ElevatedButton(
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
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      hint: Text(hint),
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
          Text(label, style: TextStyle(color: color)),
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
