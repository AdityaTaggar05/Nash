import 'package:app/config/theme.dart';
import 'package:flutter/material.dart';

import '/widgets/rounded_icon_button.dart';

class ProfileHeader extends StatelessWidget {
  final GlobalKey headerKey;
  final Map<String, dynamic> data;

  const ProfileHeader({super.key, required this.headerKey, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: headerKey,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Row(
            children: [
              if (Navigator.of(context).canPop())
                RoundedIconButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: Navigator.of(context).pop,
                  color: context.colorScheme.surface,
                ),
              const Spacer(),
              RoundedIconButton(
                icon: Icons.power_settings_new_rounded,
                onTap: () => print("LOGOUT!"),
                color: context.colorScheme.surface,
              ),
            ],
          ),
        ),
        Hero(
          tag: "pfp",
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.onSecondary,
            ),
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(100),
              child: Image.network(
                "https://cdn.dribbble.com/users/18924830/avatars/normal/25cecaeb59d31d07887ff220ea9ab686.png?1728297612",
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data["username"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: context.colorScheme.onTertiary,
          ),
        ),
        Text(
          data["email"],
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("REFERRAL CODE: "),
              Text(
                data["referral_code"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
