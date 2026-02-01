import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/models/bet.dart';
import '/pages/home/widgets/bets_carousel_card.dart';
import '/providers/dio_provider.dart';

class HomeCreatedBetsCarousel extends ConsumerWidget {
  const HomeCreatedBetsCarousel({super.key});

  Future<List<Bet>> getCreatedBets(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get('/users/created_bets');

    return res.data.map<Bet>((bet) => Bet.fromJSON(bet)).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: getCreatedBets(ref),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (asyncSnapshot.hasError) {
          return Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(
                color: context.colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
          );
        }

        if (asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "You don't have any created open bets!",
              style: TextStyle(
                color: context.colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
          );
        }

        final List<Bet> data = asyncSnapshot.data!;

        return CarouselSlider(
          options: CarouselOptions(
            height: 168.0,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.95,
          ),
          items: data.map((bet) {
            return Builder(
              builder: (BuildContext context) {
                return BetsCarouselCard(
                  bet: bet,
                  color: context.colorScheme.secondary,
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
