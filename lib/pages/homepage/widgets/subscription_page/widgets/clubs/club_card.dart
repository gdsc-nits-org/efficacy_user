import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClubCard extends StatelessWidget {
  ClubCard({
    super.key,
    required this.club,
    required this.onToggle,
  });
  final ClubModel club;
  final Function(ClubModel) onToggle;

  @override
  Widget build(BuildContext context) {
    bool isSubscribed = UserController.currentUser!.following.contains(club.id);
    return ListTile(
      title: Text(
        club.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {}, // to club details page
      leading: ClipOval(
        child: Image(
          image: NetworkImage(club.clubLogoURL),
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.people),
          width: 45, // Adjust the width as needed
          height: 45, // Adjust the height as needed
          fit: BoxFit.cover,
        ),
      ),
      trailing: ToggleButtons(
        borderRadius: BorderRadius.circular(15),
        renderBorder: false,
        isSelected: [isSubscribed],
        onPressed: (int index) => onToggle(club),
        selectedColor: Colors.white,
        fillColor: Color.fromARGB(253, 82, 81, 81),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  isSubscribed ? "Subscribed" : "Subscribe",
                ),
                const Icon(CupertinoIcons.bell),
              ].separate(10),
            ),
          )
        ],
      ),
    );
  }
}
