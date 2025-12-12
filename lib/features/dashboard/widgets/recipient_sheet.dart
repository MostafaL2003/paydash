import 'package:flutter/material.dart';

class RecipientSheet extends StatelessWidget {
  final void Function(String name) onContactSelected;

  const RecipientSheet({super.key, required this.onContactSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: textColor.withOpacity(0.6)),
                  const SizedBox(width: 10),
                  Text(
                    "Name, \$Cashtag, Phone...",
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Favorites Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Favorites",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildFavorite("Mom", Icons.favorite, Colors.pink, textColor),
                _buildFavorite("Ahmed", Icons.person, Colors.blue, textColor),
                _buildFavorite("Boss", Icons.work, Colors.orange, textColor),
                _buildFavorite("Sis", Icons.home, Colors.purple, textColor),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(color: textColor.withOpacity(0.24)),
          ),

          // Recents Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Recents",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildRecent("Sara Williams", "Last sent 2h ago", textColor),
                _buildRecent("Uber Rides", "Yesterday", textColor),
                _buildRecent("McDonald's", "2 days ago", textColor),
                _buildRecent("Netflix", "Subscription", textColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavorite(
    String name,
    IconData icon,
    Color color,
    Color textColor,
  ) {
    return GestureDetector(
      onTap: () => onContactSelected(name),
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecent(String name, String sub, Color textColor) {
    return ListTile(
      onTap: () => onContactSelected(name),
      leading: CircleAvatar(
        backgroundColor: textColor.withOpacity(0.2),
        child: Text(name[0], style: TextStyle(color: textColor)),
      ),
      title: Text(
        name,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        sub,
        style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 12),
      ),
    );
  }
}
