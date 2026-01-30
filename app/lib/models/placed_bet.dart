class PlacedBet {
  final double amount;
  final String option;
  final double expectedPayout;

  PlacedBet({
    required this.amount,
    required this.option,
    required this.expectedPayout,
  });

  static fromJSON(Map<String, dynamic> data) => PlacedBet(
    amount: data['amount'],
    option: data['option'],
    expectedPayout: data['payout'],
  );
}
