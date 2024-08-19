import 'package:dio/dio.dart';

class HttpService {
  static Dio get fertigationDataUrl => Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = 'https://mocki.io/v1';
          return handler.next(options);
        },
      ),
    );
}
