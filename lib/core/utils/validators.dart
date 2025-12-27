class Validators {

  static String? validateName(String name) {
    final trimmed = name.trim();

    if (trimmed.isEmpty) {
      return 'Please enter your name';
    }

    if (trimmed.length < 2 || trimmed.length > 10) {
      return 'Name must be 2-10 characters long';
    }

    final validNameRegExp = RegExp(r'^[a-zA-Z0-9._-]+$');
    if (!validNameRegExp.hasMatch(trimmed)) {
      return 'Name can only contain English letters, numbers, "-", "_", or "."';
    }

    return null;
  }
}
