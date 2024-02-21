extension StringExt on String? {
  bool get isBlank {
    final string = this;

    return string == null || string.trim().isEmpty;
  }

  bool get isNotBlank {
    return !isBlank;
  }
}

extension StringNonNullExt on String {
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  String get capitalize {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
