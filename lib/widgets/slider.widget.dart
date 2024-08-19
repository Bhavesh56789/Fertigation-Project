import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fertigation_project/controllers/slider.controller.dart';

class SliderWidget extends ConsumerStatefulWidget {
  const SliderWidget({
    required this.width,
    required this.minWidth,
    required this.currentRangeWidth,
    required this.height,
    required this.onRangeResized,
    super.key,
  });

  final double width;
  final double minWidth;
  final double currentRangeWidth;
  final double height;
  final Function(double? value) onRangeResized;

  @override
  ConsumerState<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends ConsumerState<SliderWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(sliderProvider(widget.hashCode.toString()).notifier)
        ..updatePosition(0)
        ..updateWidth(widget.currentRangeWidth);
      super.didChangeDependencies();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.listenManual(
        sliderProvider(widget.hashCode.toString()),
        (previous, next) {
          widget.onRangeResized(next.width);
        },
      );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final sliderState = ref.watch(sliderProvider(widget.hashCode.toString()));
    final sliderNotifier =
        ref.read(sliderProvider(widget.hashCode.toString()).notifier);

    return Visibility(
      visible: sliderState.width != null && sliderState.position != null,
      child: Stack(
        children: [
          Positioned(
            left: sliderState.position,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                double newPosition =
                    (sliderState.position ?? 0) + details.delta.dx;
                newPosition = newPosition.clamp(
                    0.0, widget.width - (sliderState.width ?? 0));
                sliderNotifier.updatePosition(newPosition);
              },
              child: Container(
                width: sliderState.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.green.shade800,
                    width: 2,
                  ),
                  color: Colors.green.shade200,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          double newWidth =
                              (sliderState.width ?? 0) - details.delta.dx;
                          double newPosition =
                              (sliderState.position ?? 0) + details.delta.dx;

                          if (newWidth >= widget.minWidth &&
                              newPosition >= 0.0) {
                            sliderNotifier.updateWidth(newWidth);
                            sliderNotifier.updatePosition(newPosition);
                          }
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.resizeLeftRight,
                          child: SizedBox(
                            width: 4,
                            height: widget.height,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.height,
                      child: const Align(
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text(
                            ':::',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          double newWidth =
                              (sliderState.width ?? 0) + details.delta.dx;
                          if (newWidth >= widget.minWidth &&
                              (sliderState.position ?? 0) + newWidth <=
                                  widget.width) {
                            sliderNotifier.updateWidth(newWidth);
                          }
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.resizeLeftRight,
                          child: SizedBox(
                            width: 4,
                            height: widget.height,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
