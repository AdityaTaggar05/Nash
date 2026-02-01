import 'package:app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/bet.dart';

class OngoingBetsCarousel extends ConsumerWidget {
  const OngoingBetsCarousel({super.key});

  Future<List<Bet>> getOngoingBets(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get('/users/placed_bet');

    return res.data.map((bet) => Bet.fromJSON(bet));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
    // return FutureBuilder(
    //   future: getOngoingBets(ref),
    //   builder: (context, asyncSnapshot) {
    //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }

    //     if (asyncSnapshot.hasError) {
    //       print("LOG ERROR: ${asyncSnapshot.error}");

    //       return Center(
    //         child: Text(
    //           "Something went wrong",
    //           style: TextStyle(
    //             color: context.colorScheme.onSurface,
    //             fontSize: 18,
    //           ),
    //         ),
    //       );
    //     }

    //     if (asyncSnapshot.data == null) {
    //       return Center(
    //         child: Text(
    //           "You don't have any placed open bets!",
    //           style: TextStyle(
    //             color: context.colorScheme.onSurface,
    //             fontSize: 18,
    //           ),
    //         ),
    //       );
    //     }

    //     final List<Bet> data = asyncSnapshot.data!;

    //     return CarouselSlider(
    //       options: CarouselOptions(
    //         height: 192.0,
    //         autoPlay: true,
    //         enlargeCenterPage: true,
    //         enableInfiniteScroll: true,
    //         viewportFraction: 0.95,
    //       ),
    //       items: data.map((bet) {
    //         return Builder(
    //           builder: (BuildContext context) {
    //             return BetsCarouselCard(
    //               totalPot: bet.totalPot,
    //               placedBet: bet.myBet!.amount,
    //               title: bet.title,
    //               endsAt: bet.endsAt,
    //               color: context.colorScheme.primary,
    //             );
    //           },
    //         );
    //       }).toList(),
    //     );
    //   },
    // );
  }
}
