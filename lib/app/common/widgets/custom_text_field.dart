// ignore_for_file: prefer_const_constructors, must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/modules/authentication/controllers/authentication_controller.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? label;
  final bool isPhoneNumber;
  final bool isShowSuffix;
  final bool isClear;
  final bool isObscureText;
  final BorderSide border;
  final int maxLine;
  final Function(String value)? onChange;
  final Function()? onPress;
  final AuthenticationController? authController;
  final String? Function(String?)? validator;
  bool isDone;
  bool isAutoFocus;
  bool isFillColor;
  bool backgroundColor;

  CustomTextFieldWidget(
    this.textEditingController, {
    super.key,
    this.label,
    this.isPhoneNumber = true,
    this.isShowSuffix = false,
    this.isClear = false,
    this.isObscureText = false,
    this.border = const BorderSide(color: Colors.black),
    this.maxLine = 1,
    this.onChange,
    this.onPress,
    this.authController,
    this.isDone = false,
    this.validator,
    this.isAutoFocus = false,
    this.isFillColor = false,
    this.backgroundColor = false,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      keyboardType: widget.isPhoneNumber ? TextInputType.phone : TextInputType.text,
      validator: widget.validator,
      maxLines: widget.maxLine,
      onChanged: widget.onChange,
      obscureText: widget.isObscureText,
      textInputAction: TextInputAction.done,
      autofocus: widget.isAutoFocus,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        filled: widget.authController?.isTypingCompleted ?? false ? false : true,
        fillColor: widget.isFillColor ? Colors.white : Colors.transparent,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: localizedTextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderSide: widget.isFillColor ? BorderSide(color: Colors.grey.shade300) : BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        prefix: Text("  "),
        suffix: Text("  "),
        hintText: widget.label,
        hintStyle: localizedTextStyle(color: Colors.grey, fontSize: 14),
        suffixIcon:
            widget.isShowSuffix
                ? IconButton(
                  iconSize: 24,
                  splashColor: Colors.transparent,
                  icon: Icon(widget.isObscureText ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                  onPressed: widget.onPress,
                )
                : null,
        focusedBorder: OutlineInputBorder(
          borderSide: widget.isFillColor ? BorderSide(color: Colors.grey.shade300) : BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: widget.isFillColor ? BorderSide(color: Colors.grey.shade300) : BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      cursorColor: Colors.black45,
    );
  }
}


// Todo: CustomInputFormatterNumber (for format number)
class CustomInputFormatterNumber extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }

    final formattedText = buffer.toString();

    return TextEditingValue(text: formattedText, selection: TextSelection.collapsed(offset: formattedText.length));
  }
}
