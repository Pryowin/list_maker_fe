String buildDuplicateError(data) {
  String returnText = "";
  data.forEach((errorText) {
    returnText += errorText + '\n';
  });
  return returnText;
}
