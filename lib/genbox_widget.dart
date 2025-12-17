import 'package:flutter/material.dart';

class GenderBox extends StatefulWidget {
  const GenderBox({super.key});

  @override
  State<GenderBox> createState() => _GenderBoxState();
}

class _GenderBoxState extends State<GenderBox> {
  @override
  Widget build(BuildContext context) {
    return Text('젠더 박스 영역');
  }
}
