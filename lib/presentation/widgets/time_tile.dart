import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cab/application/providers.dart';

class TimeTile extends ConsumerWidget {
  const TimeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider);
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 0, minute: 0),
        );
        if (time == null) return;
        ref.read(bookingProvider.notifier).updateTimeOfDay(time);
      },
      child: Container(
        height: 64,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).highlightColor,
        ),
        child: Row(
          spacing: 15,
          children: [
            Image.asset('assets/icons/clock.png', height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  bookingState.pickupTime != null
                      ? bookingState.pickupTime!.format(context)
                      : 'HH:MM',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withValues(alpha: 0.5),
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
