import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropOffCityTile extends ConsumerStatefulWidget {
  const DropOffCityTile({super.key});

  @override
  ConsumerState<DropOffCityTile> createState() => _PickUpCityTileState();
}

class _PickUpCityTileState extends ConsumerState<DropOffCityTile> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Image.asset('assets/icons/flag.png', height: 25),
          suffixIcon: IconButton(
            onPressed: () => _textController.clear(),
            icon: Icon(Icons.clear, color: Colors.black),
          ),
          hintText: 'Type City Name',
          contentPadding: EdgeInsets.symmetric(vertical: 25),
        ),
        maxLines: 1,
        controller: _textController,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {},
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
