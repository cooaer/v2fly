extension MyList<T> on List<T> {
  T? get(int index, {T? defaultValue}) {
    return length >= index ? this[index] : defaultValue;
  }

  T? get firstOrNull {
    return length > 0 ? this[0] : null;
  }
}
