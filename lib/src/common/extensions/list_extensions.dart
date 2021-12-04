extension MyList<T> on List<T> {

  T? get(int index, {T? defaultValue}) {
    return length >= index ? this[index] : defaultValue;
  }

}
