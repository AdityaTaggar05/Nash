import 'package:app/config/theme.dart';
import 'package:app/extensions/number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsetsGeometry.all(4.0),
          child: Image.asset('assets/logo.png', fit: BoxFit.contain),
        ),
        title: Text(
          "NASH",
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xff404040), width: 2.0)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _NavBarItem(
                      icon: Icons.home,
                      label: "Home",
                      isSelected: widget.navigationShell.currentIndex == 0,
                      onTap: () => _onTap(0),
                    ),
                  ),
                  Expanded(
                    child: _NavBarItem(
                      icon: Icons.search,
                      label: "Search",
                      isSelected: widget.navigationShell.currentIndex == 1,
                      onTap: () => _onTap(1),
                    ),
                  ),
                  Expanded(
                    child: _NavBarItem(
                      icon: Icons.group,
                      label: "Groups",
                      isSelected: widget.navigationShell.currentIndex == 2,
                      onTap: () => _onTap(2),
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              thickness: 2,
              width: 32,
              color: Colors.grey.shade700,
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/150?img=11",
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.primary,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    ('\$${200.formatWithCommas()}'),
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final targetColor = isSelected
        ? context.colorScheme.secondary
        : context.colorScheme.secondaryContainer;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: TweenAnimationBuilder(
        tween: ColorTween(end: targetColor),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, color, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4.0),
              AnimatedDefaultTextStyle(
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                duration: Duration(milliseconds: 300),
                child: Text(label),
              ),
            ],
          );
        },
      ),
    );
  }
}
