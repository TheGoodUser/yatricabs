import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yatri_cab/application/providers.dart';
import 'package:yatri_cab/application/service_state.dart';

class ServiceButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final int index;
  const ServiceButton({
    super.key,
    required this.onPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedService = ref.watch(servicePageViewProvider);
    final bool isSelected =
        index == ServiceType.values.indexOf(selectedService.type);
    return SizedBox(
      width: 135,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            SvgPicture.asset(
              'assets/icons/${ServiceType.values.elementAt(index).logoSrc}',
              height: 40,
              width: 40,
              colorFilter: isSelected
                  ? ColorFilter.mode(
                      Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    )
                  : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            Text(
              ServiceType.values.elementAt(index).label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
