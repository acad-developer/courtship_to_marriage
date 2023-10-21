class Validator {
  
  static String? validateNull(field, value) {
    if (value == null || value == '') {
      return '$field is required';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if(phone == null || phone == ''){
      return 'Phone is required';
    } else if (phone.length != 10){
      return 'Phone Number must be of 10 digit';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? email) {
    if (email == null || email == '') {
      return 'Email is required';
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(email)) {
      return null;
    } else {
      return 'Invalid Email';
    }
  }

  static validatePassword(String? hitText,String? password) {
    if (password == null || password == '') {
      return '$hitText is required';
    }
    if (password.length <= 6) {
      return 'Password should more than 6 digit';
    } else {
      return null;
    }
  }
}
