final class AppPermission {
  const AppPermission(this.value);

  final String value;

  @override
  bool operator ==(Object other) {
    return other is AppPermission && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
