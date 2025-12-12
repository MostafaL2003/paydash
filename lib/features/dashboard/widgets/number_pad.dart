import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(String) onKeyPressed;

  const NumberPad({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildRow(['1', '2', '3'], textColor, theme),
          _buildRow(['4', '5', '6'], textColor, theme),
          _buildRow(['7', '8', '9'], textColor, theme),
          _buildRow(['.', '0', 'backspace'], textColor, theme),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> items, Color textColor, ThemeData theme) {
    return Row(
      children:
          items.map((val) {
            if (val == 'backspace') {
              return _keyButton(
                '',
                icon: Icons.backspace_rounded,
                onTap: () => onKeyPressed('backspace'),
                textColor: textColor,
                theme: theme,
              );
            }
            return _keyButton(
              val,
              onTap: () => onKeyPressed(val),
              textColor: textColor,
              theme: theme,
            );
          }).toList(),
    );
  }

  Widget _keyButton(
    String text, {
    IconData? icon,
    VoidCallback? onTap,
    required Color textColor,
    required ThemeData theme,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            splashColor: theme.colorScheme.primary.withOpacity(0.15),
            child: SizedBox(
              height: 64,
              width: 64,
              child: Center(
                child:
                    icon == null
                        ? Text(
                          text,
                          style: TextStyle(
                            fontSize: 28,
                            color: textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                        : Icon(icon, size: 30, color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
