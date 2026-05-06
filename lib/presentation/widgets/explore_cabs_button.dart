import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatri_cab/application/providers.dart';
import 'package:yatri_cab/presentation/screens/ride_screen.dart';

class ExploreCabsButton extends ConsumerWidget {
  const ExploreCabsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(bookingProvider);
    final canProceed = ref.read(bookingProvider.notifier).isValid;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: canProceed
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RideScreen()),
              );
            }
          : null,
      child: Text(
        'Explore Cabs',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
