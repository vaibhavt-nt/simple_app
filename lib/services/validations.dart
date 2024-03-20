class Validation {
  //validation for email
  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return "Email is required";
    }
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  //validation for password
  static String? validatePassword(passCurrentValue) {
    if (passCurrentValue == null || passCurrentValue.isEmpty) {
      return "Password is required";
    }
    // Perform custom password validation here
    if (passCurrentValue.length < 6) {
      return "Password must be at least 6 characters long";
    }
    if (!passCurrentValue.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!passCurrentValue.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!passCurrentValue.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one numeric character";
    }
    if (!passCurrentValue.contains(RegExp(r'[!@#$%^&*()<>?/|}{~:]'))) {
      return "Password must contain at least one special character";
    }

    return null; // Password is valid.
  }

  //validation for username
  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Name is required";
    }
    return null;
  }
}
