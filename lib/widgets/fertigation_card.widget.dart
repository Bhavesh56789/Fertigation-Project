import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fertigation_project/enums/fertigation_type.enum.dart';
import 'package:fertigation_project/models/fertigation_data.model.dart';
import 'package:fertigation_project/widgets/fertigation_bulleted_data.widget.dart';
import 'package:fertigation_project/widgets/slider.widget.dart';

class FertigationCardWidget extends ConsumerStatefulWidget {
  const FertigationCardWidget({
    required this.fertigationDataModel,
    required this.fertigationType,
    required this.injectorIndex,
    super.key,
  });

  final dynamic fertigationDataModel;
  final FertigationType fertigationType;
  final int injectorIndex;
  @override
  ConsumerState<FertigationCardWidget> createState() =>
      _FertigationCardWidgetState();
}

class _FertigationCardWidgetState extends ConsumerState<FertigationCardWidget> {
  @override
  Widget build(BuildContext context) {
    final FertigationDataModel parsedFertigationModel =
        (widget.fertigationType == FertigationType.simultaneous
            ? ((widget.fertigationDataModel as FertigationDataModel?) ??
                FertigationDataModel())
            : ref.read(widget.fertigationDataModel
                as StateProvider<FertigationDataModel>));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Injector ${widget.injectorIndex + 1}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Visibility(
                visible: widget.fertigationType == FertigationType.sequential,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${widget.injectorIndex + 1}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const FertigationBulletedDataWidget(
                isBottomElement: false,
                isTopElement: true,
                title: 'Tank 1 ',
                value: 'Nitrogen',
              ),
              FertigationBulletedDataWidget(
                isBottomElement: false,
                isTopElement: false,
                title: 'Volume ${parsedFertigationModel.volume} litres ',
                value: parsedFertigationModel.fertigation?.toString() ?? 'N/A',
              ),
              FertigationBulletedDataWidget(
                isBottomElement: true,
                isTopElement: false,
                title:
                    '${parsedFertigationModel.mode?.toString() ?? "N/A"} mode',
                value: '',
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text('Pre mix'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          parsedFertigationModel.pre_mix?.toString() ?? 'N/A',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Fertigation',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer(
                          builder: (context, widgetRef, _) {
                            return Text(
                              (widget.fertigationType ==
                                              FertigationType.simultaneous
                                          ? ((widget.fertigationDataModel
                                                  as FertigationDataModel?) ??
                                              FertigationDataModel())
                                          : widgetRef.watch(
                                              widget.fertigationDataModel
                                                  as StateProvider<
                                                      FertigationDataModel>))
                                      .fertigation
                                      ?.toString() ??
                                  'N/A',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Pre mix'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          parsedFertigationModel.pre_mix?.toString() ?? 'N/A',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Positioned(
                      height: 25,
                      width: MediaQuery.of(context).size.width - 40,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.grey.shade400,
                          height: 10,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 7.5,
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: VerticalDivider(
                          color: Colors.grey.shade600,
                          thickness: 3,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      height: 25,
                      child: IgnorePointer(
                        ignoring: widget.fertigationType ==
                            FertigationType.simultaneous,
                        child: SliderWidget(
                          currentRangeWidth: ((MediaQuery.of(context)
                                          .size
                                          .width -
                                      94) *
                                  (parsedFertigationModel.fertigation ?? 1)
                                      .toDouble()) /
                              120, // Converting Fertigation value into device pixel width
                          minWidth:
                              ((MediaQuery.of(context).size.width - 94) * 4) /
                                  120, //Minimum fertigation time
                          width: MediaQuery.of(context).size.width - 94,
                          height: 20,
                          onRangeResized: (value) {
                            if (widget.fertigationType ==
                                FertigationType.sequential) {
                              ref
                                  .read((widget.fertigationDataModel
                                          as StateProvider<
                                              FertigationDataModel>)
                                      .notifier)
                                  .update(
                                    (state) => state.copyWith(
                                      fertigation: ((value! * 120) /
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  94))
                                          .ceil(), // Converting Device pixel width into our 120 mins bar value
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 7.5,
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: VerticalDivider(
                          color: Colors.grey.shade600,
                          thickness: 3,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
