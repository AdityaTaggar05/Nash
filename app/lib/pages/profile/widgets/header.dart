import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/controllers/auth.dart';
import '/models/user.dart';
import '/widgets/rounded_icon_button.dart';

class ProfileHeader extends ConsumerWidget {
  final GlobalKey headerKey;
  final User user;

  const ProfileHeader({super.key, required this.headerKey, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              if (user.balance != null)
                RoundedIconButton(
                  icon: Icons.power_settings_new_rounded,
                  onTap: ref.read(authControllerProvider.notifier).logout,
                  color: context.colorScheme.surface,
                ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.onSecondary,
          ),
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(8),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://cdn.dribbble.com/users/18924830/avatars/normal/25cecaeb59d31d07887ff220ea9ab686.png?1728297612",
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: context.colorScheme.onTertiary,
          ),
        ),
        Text(user.email, style: TextStyle(fontSize: 18, color: Colors.black54)),
        user.referralCode != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("REFERRAL CODE: "),
                    GestureDetector(
                      child: Text(
                        user.referralCode!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onLongPress: () => Clipboard.setData(
                        ClipboardData(text: user.referralCode!),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(height: 12),
      ],
    );
  }
}
