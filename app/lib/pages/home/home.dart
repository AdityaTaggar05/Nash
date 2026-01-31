import 'package:app/config/theme.dart';
import 'package:app/pages/home/widgets/group_card_scroll_view.dart';
import 'package:app/pages/home/widgets/home_created_bets_carousel.dart';
import 'package:app/pages/home/widgets/home_placed_bets_carousel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                    fontSize: 24.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Welcome Back, "),
                    TextSpan(
                      text: "SuckSuck.",
                      style: context.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Ongoing Placed Bets",
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorScheme.onSurface,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              OngoingBetsCarousel(),
              SizedBox(height: 32.0),
              Row(
                children: [
                  Text(
                    "Your Groups",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorScheme.onSurface,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      context.go('/groups');
                    },
                    child: Text("See all >"),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              GroupCardScrollView(),
              SizedBox(height: 32.0),
              Text(
                "Ongoing Created Bets",
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorScheme.onSurface,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              HomeCreatedBetsCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}
