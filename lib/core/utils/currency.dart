enum Currency {
  usd,
  inr;

  /// +91 numbers see INR, everyone else sees USD.
  static Currency fromPhone(String? phone) =>
      (phone ?? '').startsWith('+91') ? Currency.inr : Currency.usd;
}