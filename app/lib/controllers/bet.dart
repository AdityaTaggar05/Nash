import 'dart:async';

import 'package:app/services/socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/bet.dart';
import '/models/bet_transaction.dart';
import '/providers/dio_provider.dart';

class BetParams {
  final String groupID;
  final String betID;

  BetParams({required this.groupID, required this.betID});

  @override
  int get hashCode => Object.hash(groupID, betID);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BetParams && groupID == other.groupID && betID == other.betID;
}

final betControllerProvider = AsyncNotifierProvider.autoDispose
    .family<BetController, Bet, BetParams>(BetController.new);

class BetController extends AsyncNotifier<Bet> {
  late final BetParams params;
  late final SocketService _socketService;

  BetController(this.params);

  @override
  FutureOr<Bet> build() async {
    final dio = ref.read(dioProvider);
    var res = await dio.get("/group/${params.groupID}/bet/${params.betID}");

    final Bet bet = Bet.fromJSON(res.data);

    _socketService = SocketService();
    await _socketService.connect(betID: bet.id, onNewBet: _handleNewBet);

    res = await dio.get("/transaction/bet/${params.betID}");

    bet.transactions = res.data["transactions"]
        .map<BetTransaction>(
          (transaction) => BetTransaction.fromJSON(transaction),
        )
        .toList();

    return bet;
  }

  void resolveBet(Status status, String winningOption) {
    state = state.whenData(
      (bet) => bet.copyWith(status: status, winningOption: winningOption),
    );
  }

  void _handleNewBet(Map<String, dynamic> data) {
    state = state.whenData((bet) {
      bet.transactions.add(
        BetTransaction(
          amount: int.parse(data['amount']),
          option: data['selected_option'],
          userID: data['user_id'],
          username: data['user_id'],
          placedAt: DateTime.now(),
        ),
      );

      return bet.copyWith(
        totalPot: bet.totalPot + int.parse(data['amount']),
        poolFor: data['selected_option'] == 'for'
            ? bet.poolFor + int.parse(data['amount'])
            : bet.poolFor,
        poolAgainst: data['selected_option'] == 'against'
            ? bet.poolAgainst + int.parse(data['amount'])
            : bet.poolAgainst,
      );
    });
  }
}
