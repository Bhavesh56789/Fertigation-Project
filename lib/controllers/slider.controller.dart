import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fertigation_project/models/slider_state.model.dart';

final sliderProvider =
    StateNotifierProvider.family<SliderNotifier, SliderState, String>(
        (ref, arg) {
  return SliderNotifier();
});

class SliderNotifier extends StateNotifier<SliderState> {
  SliderNotifier() : super(SliderState());

  void updateWidth(double newWidth) {
    state = state.copyWith(width: newWidth);
  }

  void updatePosition(double newPosition) {
    state = state.copyWith(position: newPosition);
  }
}
