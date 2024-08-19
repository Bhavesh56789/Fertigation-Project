import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fertigation_project/models/fertigation_data.model.dart';
import 'package:fertigation_project/services/fertigation.service.dart';

final fertigationController = Provider<FertigationController>(
  (ref) => FertigationController(ref, FertigationService()),
);
final simultaneousFertigationDataList =
    StateProvider<List<FertigationDataModel>?>(
  (ref) => null,
);
final sequentialFertigationDataList =
    StateProvider<List<StateProvider<FertigationDataModel>>?>(
  (ref) => null,
);

class FertigationController {
  FertigationController(this.providerRef, this.service);
  ProviderRef<FertigationController> providerRef;
  final FertigationService service;

  List<String> get fertigationBulletedDataHeaders => ['Tank 1', 'Volume', ''];

  Future<void> getFertigationData({BuildContext? context}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final Response? response = await service.getFertigationData();
      providerRef.read(simultaneousFertigationDataList.notifier).update(
            (state) => (response?.data['simultaneous'] as List)
                .map((e) => FertigationDataModel.fromJson(e))
                .toList(),
          );
      providerRef.read(sequentialFertigationDataList.notifier).update(
            (state) => (response?.data['sequential'] as List)
                .map(
                  (e) => StateProvider<FertigationDataModel>(
                    (ref) => FertigationDataModel.fromJson(e),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      providerRef
          .read(simultaneousFertigationDataList.notifier)
          .update((state) => []);
      providerRef
          .read(sequentialFertigationDataList.notifier)
          .update((state) => []);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to fetch Fertigation Data'),
          ),
        );
      }
    }
  }
}
