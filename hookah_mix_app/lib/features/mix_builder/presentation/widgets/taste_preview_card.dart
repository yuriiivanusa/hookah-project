import 'package:flutter/material.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/widgets/taste_profile_radar.dart';

class TastePreviewCard extends StatelessWidget {
  const TastePreviewCard({super.key, required this.profile, required this.title});

  final TasteProfile profile;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(height: 200, child: TasteProfileRadar(profile: profile)),
          ],
        ),
      ),
    );
  }
}
