import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'welcome.dart';
import 'subject_list.dart';

void main() {
  runApp(const EditSubj());
}

class EditSubj extends StatelessWidget {
  const EditSubj({Key? key}) : super(key: key);

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

class ExaminationScreen extends StatelessWidget {
  const ExaminationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SubjectList(),
              ),
            );
          },
        ),
        title: const Text(
          'Edit Subject',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: const SingleChildScrollView(
        child: ExaminationBody(),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SaveButton(),
      ),
    );
  }
}

class ExaminationBody extends StatefulWidget {
  const ExaminationBody({Key? key}) : super(key: key);

  @override
  _ExaminationBodyState createState() => _ExaminationBodyState();
}

class _ExaminationBodyState extends State<ExaminationBody> {
  String? selectedExamType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SubjectInput(),
          const SizedBox(height: 16),
          buildExamTypeDropdown(),
          const SizedBox(height: 64),
          const ExamDetectionSection(),
        ],
      ),
    );
  }

  Widget buildExamTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Exam Type',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedExamType,
          items: [
            'Quiz 1',
            'Quiz 2',
            'Quiz 3',
            'Quiz 4',
            'Exam',
          ].map((examType) {
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
      ],
    );
  }
}

class SubjectInput extends StatelessWidget {
  const SubjectInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Subject',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: 'Math'),
          decoration: InputDecoration(
            hintText: 'Enter Subject',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class ExamDetectionSection extends StatelessWidget {
  const ExamDetectionSection({Key? key}) : super(key: key);

  Future<void> _openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Handle the image
    }
  }

  Future<void> _uploadFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle the uploaded file
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Exam Detection',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildActionButton(
          icon: Icons.upload_file,
          label: 'File Upload',
          onPressed: _uploadFile,
          color: Colors.black,
        ),
        const SizedBox(height: 16),
        _buildActionButton(
          icon: Icons.camera_alt,
          label: 'Open Camera',
          onPressed: _openCamera,
          color: Colors.black,
        ),
        const SizedBox(height: 64),
        const Text(
          'Total: 0',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
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

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ),
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
    );
  }
}
