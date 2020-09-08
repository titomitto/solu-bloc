bool validPhoneNumber(String value) {
  Pattern pattern = r'(0|\+*25\d)(7|1)\d{8}';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(value);
}
