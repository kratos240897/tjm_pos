extension EnumToString on String {
  String getFormattedValue() {
    return replaceAllMapped(
      RegExp(r'(?<=[a-z])[A-Z]'),
      (Match match) {
        return ' ${match.group(0)}';
      },
    ).toUpperCase();
  }
}
