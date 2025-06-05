import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class InputTextWidget extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final int? maxLines;
  final bool readOnly;


  const InputTextWidget({
    super.key,
    required this.hintText,
    this.icon,
    this.focusNode,
    this.controller,
    this.maxLines,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.1),
      ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          focusNode: focusNode,
          readOnly: readOnly,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, color: ColorConstants.primaryColor, size: 20,): null,
            hintText: hintText,
            labelText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      ),
    ));
  }
}
