String trimAndUppercaseString(String inputString) {
  String resultString = '';
  if (inputString != null) {
    resultString = inputString.trim().toUpperCase();
  }
  return resultString;
}
