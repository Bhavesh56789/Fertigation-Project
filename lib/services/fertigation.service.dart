import 'package:dio/dio.dart';
import 'package:fertigation_project/services/http.service.dart';

class FertigationService {
  Future<Response?> getFertigationData() async {
    try {
      return await HttpService.fertigationDataUrl
          .get('/02803453-b00b-4c75-9e8e-5c582d050ed7');
    } catch (e) {
      rethrow;
    }
  }
}
