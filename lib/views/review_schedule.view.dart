import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fertigation_project/controllers/fertigation.controller.dart';
import 'package:fertigation_project/enums/fertigation_type.enum.dart';
import 'package:fertigation_project/widgets/fertigation_list.widget.dart';

class ReviewScheduleView extends ConsumerStatefulWidget {
  const ReviewScheduleView({super.key});

  @override
  ConsumerState<ReviewScheduleView> createState() => _ReviewScheduleViewState();
}

class _ReviewScheduleViewState extends ConsumerState<ReviewScheduleView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ValueNotifier<int> currentSelectedTab = ValueNotifier<int>(0);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.read(fertigationController).getFertigationData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Review Schedule',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            onTap: (value) => currentSelectedTab.value = value,
            tabs: [
              ValueListenableBuilder(
                  valueListenable: currentSelectedTab,
                  builder: (context, value, _) {
                    return Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade200,
                            width: 2,
                          ),
                          bottom: value == 0
                              ? const BorderSide(
                                  color: Color(0xFF81b18a),
                                  width: 2,
                                )
                              : BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 2,
                                ),
                        ),
                        color: value == 0 ? const Color(0xFFEFF7F1) : null,
                      ),
                      child: const Text(
                        'Simultaneous Mode',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }),
              ValueListenableBuilder(
                  valueListenable: currentSelectedTab,
                  builder: (context, value, _) {
                    return Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade200,
                            width: 2,
                          ),
                          bottom: value == 1
                              ? const BorderSide(
                                  color: Color(0xFF81b18a),
                                  width: 2,
                                )
                              : BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 2,
                                ),
                        ),
                        color: value == 1 ? const Color(0xFFEFF7F1) : null,
                      ),
                      child: const Text(
                        'Sequential Mode',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }),
            ],
            indicatorColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            FertigationListWidget(
                fertigationType: FertigationType.simultaneous),
            FertigationListWidget(fertigationType: FertigationType.sequential),
          ],
        ),
      ),
    );
  }
}
