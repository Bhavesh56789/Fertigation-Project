import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fertigation_project/controllers/fertigation.controller.dart';
import 'package:fertigation_project/enums/fertigation_type.enum.dart';
import 'package:fertigation_project/widgets/fertigation_card.widget.dart';

class FertigationListWidget extends ConsumerWidget {
  const FertigationListWidget({
    required this.fertigationType,
    super.key,
  });
  final FertigationType fertigationType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fertigationList = fertigationType == FertigationType.simultaneous
        ? ref.watch(simultaneousFertigationDataList)
        : ref.watch(sequentialFertigationDataList);
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.green.shade50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              color: Colors.green.shade50,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Schedule 1',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Zone 1, Zone 2',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: fertigationType == FertigationType.sequential,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(13),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      backgroundColor: Colors.green.shade800),
                  child: const Text(
                    'Finish',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
      body: Visibility(
        visible: fertigationList != null,
        replacement: const Center(child: CircularProgressIndicator()),
        child: Visibility(
          visible: fertigationList?.isNotEmpty ?? false,
          replacement: const Center(
            child: Text('Fertigation Data Not Found'),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: fertigationType == FertigationType.sequential,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.grey.shade500,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 42,
                          child: Text(
                            'Injector operates one after another in this mode.',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: fertigationList?.length ?? 0,
                  itemBuilder: (context, index) => FertigationCardWidget(
                    fertigationDataModel: fertigationList?[index],
                    fertigationType: fertigationType,
                    injectorIndex: index,
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
