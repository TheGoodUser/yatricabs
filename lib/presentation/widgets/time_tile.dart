import 'package:flutter/material.dart';

class TimeTile extends StatelessWidget {
  const TimeTile({super.key});

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
          Image.asset('assets/icons/clock.png', height: 30),
          Column(
            children: [
              Text(
                'Time',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'HH:MM',
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
