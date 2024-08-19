class SliderState {
  final double? width;
  final double? position;

  SliderState({this.width, this.position});

  SliderState copyWith({double? width, double? position}) {
    return SliderState(
      width: width ?? this.width,
      position: position ?? this.position,
    );
  }
}
