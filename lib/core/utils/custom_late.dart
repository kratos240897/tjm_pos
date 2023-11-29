class CustomLate<T> {
  bool _initialized = false;
  late T _value;

  CustomLate();

  CustomLate.withValue(T value) {
    _initialized = true;
    _value = value;
  }

  bool get isInitialized => _initialized;

  T get value {
    if (!_initialized) {
      throw Exception('Variable not initialized');
    }
    return _value;
  }

  void setValue(T value) {
    _value = value;
    _initialized = true;
  }
}
