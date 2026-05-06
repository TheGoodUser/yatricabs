import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatri_cab/presentation/widgets/drop_off_city_tile.dart';
import 'package:yatri_cab/presentation/widgets/explore_cabs_button.dart';
import 'package:yatri_cab/presentation/widgets/pick_up_city_tile.dart';
import 'package:yatri_cab/presentation/widgets/pick_up_date_tile.dart';
import 'package:yatri_cab/presentation/widgets/time_tile.dart';

enum JourneyType { oneWay, roundTrip }

class OutstationTripCard extends StatefulWidget {
  const OutstationTripCard({super.key});

  @override
  State<OutstationTripCard> createState() => _OutstationTripCardState();
}

class _OutstationTripCardState extends State<OutstationTripCard> {
  JourneyType _type = JourneyType.oneWay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            // One way
            _button("One-way", JourneyType.oneWay),
            _button("Round Trip", JourneyType.roundTrip),
            // Round trip
          ],
        ),
        const SizedBox(height: 10),
        // Card Details
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            spacing: 10,
            children: [
              PickUpCityTile(),
              DropOffCityTile(),
              PickUpDateTile(),
              TimeTile(),
              ExploreCabsButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _button(String label, JourneyType type) {
    final bool isSelected = type == _type;
    return SizedBox(
      height: 28,
      width: 147,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).primaryColor
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          setState(() {
            _type = type;
          });
        },
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
