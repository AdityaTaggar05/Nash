import '/models/bet_transaction.dart';
import '/models/placed_bet.dart';

enum Status { open, resolved, locked }

class Bet {
  final String id;
  final String groupID;
  final String title;
  int totalPot;
  final int poolFor;
  final int poolAgainst;
  final Status status;
  final String createdBy;
  final DateTime createdAt;
  final DateTime expiresAt;
  String? winningOption;
  PlacedBet? myBet;
  List<BetTransaction> transactions;

  Bet({
    required this.id,
    required this.groupID,
    required this.title,
    required this.totalPot,
    required this.poolFor,
    required this.poolAgainst,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.expiresAt,
    required this.transactions,
    this.myBet,
    this.winningOption,
  });

  factory Bet.fromJSON(Map<String, dynamic> json) {
    Status status = Status.open;
    switch (json['status']) {
      case 'open':
        status = Status.open;
      case 'resolved':
        status = Status.resolved;
      case 'locked':
        status = Status.locked;
    }

    return Bet(
      id: json['id'],
      groupID: json['group_id'],
      status: status,
      title: json['title'],
      winningOption: json['winning_option'],
      totalPot: int.parse(json['total_pot'].toString()),
      poolFor: json['pool_for']?.toString() != null
          ? int.parse(json['pool_for'].toString())
          : 0,
      poolAgainst: json['pool_against']?.toString() != null
          ? int.parse(json['pool_against'].toString())
          : 0,
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['creator_id'] ?? "",
      expiresAt: DateTime.parse(json['expires_at']),
      myBet: json["my_bet"] != null ? PlacedBet.fromJSON(json['my_bet']) : null,
      transactions: [],
    );
  }

  Bet copyWith({
    String? id,
    String? groupID,
    String? title,
    int? totalPot,
    int? poolFor,
    int? poolAgainst,
    Status? status,
    String? createdBy,
    DateTime? createdAt,
    DateTime? expiresAt,
    PlacedBet? myBet,
    String? winningOption,
    List<BetTransaction>? transactions,
  }) {
    return Bet(
      id: id ?? this.id,
      groupID: groupID ?? this.groupID,
      title: title ?? this.title,
      totalPot: totalPot ?? this.totalPot,
      poolFor: poolFor ?? this.poolFor,
      poolAgainst: poolAgainst ?? this.poolAgainst,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      myBet: myBet ?? this.myBet,
      transactions: transactions ?? this.transactions,
      winningOption: winningOption ?? this.winningOption,
    );
  }
}
