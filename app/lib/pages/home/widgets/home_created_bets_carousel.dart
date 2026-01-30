import 'package:app/config/theme.dart';
import 'package:app/pages/home/widgets/bets_carousel_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCreatedBetsCarousel extends StatelessWidget {
  HomeCreatedBetsCarousel({super.key});

  final List<Map<String, dynamic>> _dummyBets = [
    {
      "amount": 3840,
      "placed": 100,
      "title": "Will Keshav bath today?",
      "endsAt": DateTime.now(),
    },
    {
      "amount": 1200,
      "placed": 50,
      "title": "Will Bitcoin hit 100k?",
      "endsAt": DateTime.now(),
    },
    {
      "amount": 500,
      "placed": 20,
      "title": "CS2 Major Winner?",
      "endsAt": DateTime.now(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 192.0,
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 0.95,
      ),
      items: _dummyBets.map((bet) {
        return Builder(
          builder: (BuildContext context) {
            return BetsCarouselCard(
              totalPot: bet['amount'],
              placedBet: bet['placed'],
              title: bet['title'],
              endsAt: bet['endsAt'],
              color: context.colorScheme.secondary,
            );
          },
        );
      }).toList(),
    );
  }
}
