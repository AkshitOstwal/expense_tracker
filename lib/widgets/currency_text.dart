class CurrencyText {
  String getCurrencyString(double amt) {
    if (amt >= 100000000) {
      return '\$${(amt / 100000000).toStringAsFixed(2)} B';
    } else if (amt >= 1000000) {
      return '\$${(amt / 1000000).toStringAsFixed(2)} M';
    } else if (amt >= 1000) {
      return '\$${(amt / 1000).toStringAsFixed(2)} K';
    } else
      return '\$${(amt).toStringAsFixed(1)}';
  }
}
