import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yatri_cab/application/providers.dart';

class PickUpDateTile extends ConsumerStatefulWidget {
  const PickUpDateTile({super.key});

  @override
  ConsumerState<PickUpDateTile> createState() => _PickUpDateTileState();
}

class _PickUpDateTileState extends ConsumerState<PickUpDateTile> {
  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingProvider);
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 60)),
        );
        // update state
        if (date == null) return;
        ref.read(bookingProvider.notifier).updateDateTime(date);
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
            Image.asset('assets/icons/calender.png', height: 24),
            Column(
              children: [
                Text(
                  'Pickup Date',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  bookingState.pickupDate != null
                      ? DateFormat(
                          'dd-MM-yyyy',
                        ).format(bookingState.pickupDate!)
                      : 'DD-MM-YYYY',
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
