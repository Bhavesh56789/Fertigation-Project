import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fertigation_project/controllers/fertigation.controller.dart';
import 'package:fertigation_project/services/fertigation.service.dart';
import 'package:dio/dio.dart';

class MockFertigationService extends FertigationService {
  @override
  Future<Response?> getFertigationData() async {
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: {
        'simultaneous': [
          {
            "device": "Test 1",
            "volume": 89,
            "mode": "bulk",
            "pre_mix": 2,
            "post_mix": 2,
            "fertigation": 10
          },
          {
            "device": "Test 2",
            "volume": 89,
            "mode": "spred",
            "pre_mix": 2,
            "post_mix": 2,
            "fertigation": 10
          }
        ],
        'sequential': [
          {
            "device": "Test abc",
            "volume": 89,
            "mode": "bulk",
            "pre_mix": 2,
            "post_mix": 2,
            "fertigation": 5
          },
          {
            "device": "Test xyz",
            "volume": 600,
            "mode": "bulk",
            "pre_mix": 2,
            "post_mix": 2,
            "fertigation": 36
          }
        ],
      },
    );
  }
}

class MockFertigationServiceWithError extends FertigationService {
  @override
  Future<Response?> getFertigationData() async {
    throw Exception('Failed to fetch data');
  }
}

void main() {
  group('FertigationController', () {
    test('should update state with fetched data on success', () async {
      // Arrange
      final providerContainer = ProviderContainer(
        overrides: [
          fertigationController.overrideWith(
            (ref) => FertigationController(
              ref,
              MockFertigationService(),
            ),
          ),
        ],
      );

      final controller = providerContainer.read(fertigationController);

      await controller.getFertigationData();

      final simultaneousData =
          providerContainer.read(simultaneousFertigationDataList);
      final sequentialData =
          providerContainer.read(sequentialFertigationDataList);

      expect(simultaneousData?.length, 2);
      expect(simultaneousData?[0].device, 'Test 1');
      expect(simultaneousData?[0].fertigation, 10);

      expect(sequentialData?.length, 2);
      expect(providerContainer.read(sequentialData![0]).device, 'Test abc');
      expect(providerContainer.read(sequentialData[0]).fertigation, 5);
    });

    test('should handle exceptions gracefully', () async {
      // Arrange
      final providerContainer = ProviderContainer(
        overrides: [
          fertigationController.overrideWith(
            (ref) => FertigationController(
              ref,
              MockFertigationServiceWithError(),
            ),
          ),
        ],
      );

      final controller = providerContainer.read(fertigationController);

      await controller.getFertigationData();

      final simultaneousData =
          providerContainer.read(simultaneousFertigationDataList);
      final sequentialData =
          providerContainer.read(sequentialFertigationDataList);

      expect(simultaneousData, isEmpty);
      expect(sequentialData, isEmpty);
    });
  });
}
