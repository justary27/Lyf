import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/utils/enums/error_type.dart';
import 'package:lyf/src/utils/errors/services/service_errors.dart';

import '../../utils/handlers/permission_handler.dart';
import '../errors/error_state.dart';

final contactNotifier =
    StateNotifierProvider<ContactNotifier, AsyncValue<List<Contact>>>((ref) {
  return ContactNotifier(ref.read);
});

class ContactNotifier extends StateNotifier<AsyncValue<List<Contact>>> {
  final Reader read;
  AsyncValue<List<Contact>>? initState;
  AsyncValue<List<Contact>>? previousState;

  ContactNotifier(this.read, [AsyncValue<List<Contact>>? initContacts])
      : super(initContacts ?? const AsyncValue.loading()) {
    getContacts();
  }

  void getContacts() async {
    try {
      int requestResponse = await PermissionManager.requestContactAccess();
      if (requestResponse == 2) {
        List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true,
        );
        List<Contact> contactList = contacts
            .where((element) => element.phones.isNotEmpty)
            .toList()
            .cast<Contact>();
        state = AsyncValue.data(contactList);
        initState = state;
      } else {
        throw ServiceException(
          "Contact Access was denied",
          errorType: ErrorType.permissionError,
        );
      }
    } catch (e) {
      handleException(e);
    }
  }

  void searchContact(String query) {
    _cacheState();
    state = const AsyncValue.loading();
    try {
      if (query.isEmpty) {
        state = initState!;
      } else {
        List<Contact> filteredData = initState!.value!
            .where(
              (element) => element.displayName
                  .toLowerCase()
                  .contains(query.toLowerCase()),
            )
            .toList()
            .cast<Contact>();
        state = AsyncValue.data(filteredData);
      }
    } catch (e) {
      handleException(e);
    }
  }

  void _cacheState() {
    previousState = state;
  }

  void _resetState() {
    if (previousState != null) {
      state = previousState!;
      previousState = null;
    }
  }

  void setToInitState() {
    if (initState != null && initState != state) {
      state = initState!;
    }
  }

  void handleException(Object e) {
    if (state == const AsyncValue<List<Contact>>.loading() &&
        e.runtimeType == ServiceException) {
      state = AsyncValue.error(e);
    } else {
      _resetState();
    }
    read(errorNotifier.notifier).addError(e);
  }
}
