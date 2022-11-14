import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/handlers/permission_handler.dart';

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
    _getContacts();
  }

  void _getContacts() async {
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
        throw ("Contact Access was denied");
      }
    } catch (e) {
      handleException();
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
      handleException();
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

  void handleException() {
    _resetState();
  }
}
