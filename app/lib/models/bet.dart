import 'package:app/models/placed_bet.dart';

enum Status { open, resolved, locked }

class Bet {
  final String title;
  final double totalPot;
  final double poolFor;
  final double poolAgainst;
  final Status status;
  final String createdBy;
  final DateTime createdAt;
  final DateTime endsAt;
  final PlacedBet? myBet;

  Bet({
    required this.title,
    required this.totalPot,
    required this.poolFor,
    required this.poolAgainst,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.endsAt,
    this.myBet,
  });

  static fromJSON(Map<String, dynamic> data) {
    Status status = Status.resolved;

    if (data['status'] == 'open') {
      status = Status.open;
    } else if (data['status'] == 'resolved') {
      status = Status.resolved;
    } else if (data['status'] == 'locked') {
      status = Status.locked;
    }

    return Bet(
      status: status,
      title: data['title'],
      totalPot: data['total_pot'],
      poolFor: data['pool_for'],
      poolAgainst: data['pool_against'],
      createdAt: data['created_at'],
      createdBy: data['created_by'],
      endsAt: data['ends_at'],
      myBet: data["my_bet"] != null ? PlacedBet.fromJSON(data['my_bet']) : null,
    );
  }
}
