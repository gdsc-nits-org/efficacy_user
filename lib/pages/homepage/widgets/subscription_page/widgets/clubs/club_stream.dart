import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/controllers/services/club/club_controller.dart';
import 'package:efficacy_user/models/club/club_model.dart';
import 'package:efficacy_user/pages/homepage/widgets/subscription_page/widgets/clubs/club_card.dart';
import 'package:efficacy_user/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

class ClubsStream extends StatelessWidget {
  final int filterIndex;
  final Function(ClubModel) onToggle;
  final Stream<List<ClubModel>> clubStream;

  const ClubsStream({
    super.key,
    required this.filterIndex,
    required this.onToggle,
    required this.clubStream,
  }); // Size constants
  static const double bigFontSize = 18;
  static const double smallFontSize = 14;
  static const double elevation = 5;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ClubModel>>(
      stream: clubStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Error state
          showSnackBar(context, 'Error: ${snapshot.error}');
          throw Exception('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Empty data state
          return const Text('No clubs available for NIT Silchar');
        } else {
          // Data available
          final clubs = snapshot.data!
              .where((club) => club.clubStatus == ClubStatus.accepted)
              .toList();
          final userClubList = clubs
              .where((club) =>
                  UserController.currentUser!.following.contains(club.id))
              .toList();
          List<ClubModel> specificList = filterIndex == 0
              ? clubs
              : filterIndex == 1
                  ? userClubList
                  : clubs
                      .where((element) => !userClubList.contains(element))
                      .toList();
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                itemCount: specificList.length,
                itemBuilder: (context, index) {
                  final club = specificList[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClubCard(
                      club: club,
                      onToggle: onToggle,
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
