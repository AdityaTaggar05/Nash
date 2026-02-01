import 'package:flutter_regex/flutter_regex.dart';

String? emailValidator(String? input) {
  if(input == null || input.isEmpty) {
    return "Please enter an E-mail";
  }

  bool isValid = input.isEmail();

  if(!isValid) return "Please enter a valid E-mail";
  
  return null;
}