class AlertResponse {
  final String? fieldOne;
  final String? fieldTwo;
  final bool confirmed;
  final bool secondConfirmed;

  AlertResponse({
    this.fieldOne,
    this.fieldTwo,
    required this.confirmed,
    required this.secondConfirmed,
  });
}
