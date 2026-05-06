import 'package:flutter/material.dart';

class PickUpDateTile extends StatelessWidget {
  const PickUpDateTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).highlightColor,
      ),
      child: Row(
        spacing: 15,
        children: [
          Image.asset('assets/icons/calender.png', height: 30),
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
                'DD-MM-YYYY',
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
    );
  }
}
