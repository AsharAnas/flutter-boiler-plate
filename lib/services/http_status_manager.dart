import 'package:boiler_plate/services/response_wrapper.dart';

class HttpStatusManager {
  static void handleStatusCode(ResponseWrapper response) {
    switch (response.statusCode) {
      case 200:
        // Handle successful response (HTTP 200)
        break;
      case 400:
        // Handle bad request (HTTP 400)
        break;
      case 404:
        // Handle not found (HTTP 404)
        break;
      case 403:
        // Handle forbidden (HTTP 403)
        break;
      case 500:
        // Handle internal server error (HTTP 500)
        break;
      default:
        // Handle other status codes
        break;
    }
  }
}
