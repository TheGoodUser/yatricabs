import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cab/application/providers.dart';
import 'package:yatri_cab/presentation/widgets/city_recommendations.dart';

class DropOffCityTile extends ConsumerStatefulWidget {
  const DropOffCityTile({super.key});

  @override
  ConsumerState<DropOffCityTile> createState() => _PickUpCityTileState();
}

class _PickUpCityTileState extends ConsumerState<DropOffCityTile> {
  // Use a single name for the controller to avoid errors
  final _textController = TextEditingController();
  final _portalController = OverlayPortalController();
  final _focusNode = FocusNode();
  final _layerLink = LayerLink();

  // Necessary for TapRegion and Layout calculation
  final String _focusId = "dropoff_search_region";
  double _searchFieldWidth = 0;

  @override
  void initState() {
    super.initState();
    // Show/Hide recommendations based on focus and existing text
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _textController.text.isNotEmpty) {
        _portalController.show();
      } else {
        // We hide the portal when focus is lost
        _portalController.hide();
      }
      // Rebuild to update border colors or icons
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      groupId: _focusId,
      onTapOutside: (event) {
        if (_focusNode.hasFocus) {
          _portalController.hide();
          _focusNode.unfocus();
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Capture the width of the text field to match the dropdown width
            _searchFieldWidth = constraints.maxWidth;

            return OverlayPortal(
              controller: _portalController,
              overlayChildBuilder: (context) => _buildOverlay(),
              child: _searchBuilder(),
            );
          },
        ),
      ),
    );
  }

  Widget _searchBuilder() {
    return TextField(
      focusNode: _focusNode,
      controller: _textController,
      maxLines: 1,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: 'Enter dropoff city',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset('assets/icons/flag.png', height: 24),
        ),
        suffixIcon: _textController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _textController.clear();
                  _portalController.hide();
                  // Reset the search results in provider
                  ref
                      .read(placeSearchProvider.notifier)
                      .onQueryChanged(
                        query: "",
                        type: ref.read(servicePageViewProvider).type,
                      );
                  setState(() {});
                },
                icon: const Icon(Icons.cancel_rounded, color: Colors.grey),
              )
            : null,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          _portalController.show();
          ref
              .read(placeSearchProvider.notifier)
              .onQueryChanged(
                query: value,
                type: ref.read(servicePageViewProvider).type,
              );
        } else {
          _portalController.hide();
        }
        setState(() {}); // Updates suffix icon visibility
      },
    );
  }

  Widget _buildOverlay() {
    return CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      targetAnchor: Alignment.bottomLeft,
      followerAnchor: Alignment.topLeft,
      offset: const Offset(0, 5), // Slight gap below the text field
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: _searchFieldWidth,
          child: TapRegion(
            groupId: _focusId,
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(15),
              shadowColor: Colors.black.withValues(alpha: 0.3),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 350),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: CityRecommendations(
                  onCitySelected: (place) {
                    // 1. Update text field
                    _textController.text = place.displayName ?? "";

                    // 2. Hide the portal
                    _portalController.hide();

                    // 3. Close keyboarrd
                    _focusNode.unfocus();

                    // 4. Update state to reflct non-empty text
                    setState(() {});

                    // Logic for saving the specific location object can go here
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
