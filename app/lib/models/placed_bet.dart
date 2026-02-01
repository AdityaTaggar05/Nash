class PlacedBet {
  final int amount;
  final String option;
  final int expectedPayout;

  PlacedBet({
    required this.amount,
    required this.option,
    required this.expectedPayout,
  });

  static fromJSON(Map<String, dynamic> data) => PlacedBet(
    amount: int.parse(data['amount']),
    option: data['option'],
    expectedPayout: data['payout'] ?? 0,
  );
}
