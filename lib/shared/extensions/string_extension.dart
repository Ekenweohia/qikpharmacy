extension StringExtension on String {
  String get formatTime => int.parse(this) >= 10 ? this : '0$this';

  String pluralize(int length) => length > 1 ? '${this}s' : this;

  String get capitalize => this[0].toUpperCase() + substring(1);
}
