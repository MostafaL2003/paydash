import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paydash/core/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotifications = true;
  bool isFaceID = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        final ThemeData theme = Theme.of(context);
        final cardColor = theme.cardColor;
        final scaffoldBg = theme.scaffoldBackgroundColor;
        final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;
        final subtitleColor =
            theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
            Colors.grey[400];

        return Scaffold(
          backgroundColor: scaffoldBg,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                children: [
                  const SizedBox(height: 32),

                  // Header
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: cardColor,
                          child: Icon(
                            Icons.person_rounded,
                            size: 56,
                            color: textColor.withOpacity(0.87),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: scaffoldBg, width: 2),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    'Mostafa',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'developer@gmail.com',
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 16,
                      letterSpacing: 0.1,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Stats Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '12 Transactions',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            width: 1.1,
                            height: 30,
                            color: theme.dividerColor.withOpacity(0.2),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Member Since 2025',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Section title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: textColor.withOpacity(0.85),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Settings List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _settingsTile(
                          context: context,
                          icon: Icons.dark_mode_rounded,
                          title: 'Dark Mode',
                          value: state == ThemeMode.dark,
                          onChanged: (val) {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                          textColor: textColor,
                          // This tile is handled via ThemeCubit, so do not use internal bool
                        ),
                        _divider(context, textColor),
                        _settingsTile(
                          context: context,
                          icon: Icons.notifications_rounded,
                          title: 'Notifications',
                          value: isNotifications,
                          onChanged:
                              (val) => setState(() => isNotifications = val),
                          textColor: textColor,
                        ),
                        _divider(context, textColor),
                        _settingsTile(
                          context: context,
                          icon: Icons.face_rounded,
                          title: 'Face ID',
                          value: isFaceID,
                          onChanged: (val) => setState(() => isFaceID = val),
                          textColor: textColor,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Footer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.help_outline_rounded,
                            color: textColor,
                          ),
                          title: Text(
                            'Help & Support',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {},
                          tileColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(height: 4),
                        ListTile(
                          leading: const Icon(
                            Icons.logout_rounded,
                            color: Colors.redAccent,
                          ),
                          title: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            // Add log out functionality here
                          },
                          tileColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _divider(BuildContext context, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 54, right: 10),
      child: Divider(
        color: Theme.of(context).dividerColor.withOpacity(0.2),
        height: 0,
        thickness: 1,
      ),
    );
  }

  Widget _settingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveTrackColor: Theme.of(context).colorScheme.surfaceVariant,
        value: value,
        onChanged: onChanged,
      ),
      tileColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      onTap: null,
    );
  }
}
