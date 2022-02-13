import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';

final accountCredentials = ServiceAccountCredentials.fromJson({
  "private_key_id": "myprivatekeyid",
  "private_key": "myprivatekey",
  "client_email": "myclientemail",
  "client_id": "myclientid",
  "type": "service_account"
});
var _scopes = [CalendarApi.calendarScope];
