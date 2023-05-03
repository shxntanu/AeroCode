import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

// Multi Line Text Field
class MLTField extends StatefulWidget {
  const MLTField({super.key});

  @override
  State<MLTField> createState() => _MLTFieldState();
}

class _MLTFieldState extends State<MLTField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.7,
      constraints: const BoxConstraints(maxHeight: 400),
      child: const SingleChildScrollView(
        child: TextField(
          
          decoration: InputDecoration(
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}