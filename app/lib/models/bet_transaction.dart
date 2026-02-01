class BetTransaction {
  final String username;
  final String userID;
  final int amount;
  final DateTime placedAt;
  final String option;

  BetTransaction({
    required this.username,
    required this.userID,
    required this.amount,
    required this.placedAt,
    required this.option,
  });

  factory BetTransaction.fromJSON(Map<String, dynamic> json) => BetTransaction(
    username: json['username'],
    userID: json['user_id'],
    amount: int.parse(json['amount']),
    placedAt: DateTime.parse(json['placed_at']),
    option: json['option'],
  );
}
