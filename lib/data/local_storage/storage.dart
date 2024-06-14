abstract interface class Storage<T> {
  Future<T?> get value;

  Stream<T?> get valueStream;

  Future<void> save(T value);

  Future<void> delete();
}
