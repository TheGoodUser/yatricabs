import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatri_cab/application/providers.dart';
import 'package:yatri_cab/presentation/widgets/airport_transfer.dart';
import 'package:yatri_cab/presentation/widgets/local_trip_card.dart';
import 'package:yatri_cab/presentation/widgets/outstation_trip_card.dart';
import 'package:yatri_cab/presentation/widgets/service_button.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.read(servicePageViewProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: ListView(
        children: [
          ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/logo.png", height: 80),
                Icon(Icons.notifications_active, size: 35, color: Colors.white),
              ],
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headlineLarge,
                text: 'India\'s Leading',
                children: [
                  TextSpan(
                    text: ' Inter-City \nOne Way ',
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: 'Cab Service Provider'),
                ],
              ),
            ),
          ],
          const SizedBox(height: 15),

          // Ads
          SizedBox(
            height: 140,
            child: Stack(
              children: [
                Image.asset("assets/images/ads.png"),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: List.generate(
                      4,
                      (index) => Container(
                        height: 9,
                        width: 9,
                        decoration: BoxDecoration(
                          color: 0 == index
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // Service Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (index) => ServiceButton(
                index: index,
                onPressed: () => pageNotifier.onPageChanged(index),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 450, maxHeight: 650),
            child: PageView(
              controller: pageNotifier.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                OutstationTripCard(),
                LocalTripCard(),
                AirportTransferCard(),
              ],
            ),
          ),

          Image.asset('assets/images/respresentation.png'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
