class UserTransaction {
  final String betID;
  final String description;
  final int amount;
  final DateTime placedAt;

  UserTransaction({
    required this.betID,
    required this.description,
    required this.amount,
    required this.placedAt,
  });

  factory UserTransaction.fromJSON(Map<String, dynamic> json) {
    return UserTransaction(
      amount: int.parse(json['amount']),
      description: json['description'],
      betID: json['bet_id'],
      placedAt: DateTime.parse(json['placed_at']),
    );
  }
}
