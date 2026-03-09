class CustomValidatorWidget {
  static String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return "";
  }

  //validate username 
  static String validateUsername(String value) {
    String pattern = r'^[a-zA-Z0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter username';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid username';
    }
    return "";
  }

}
