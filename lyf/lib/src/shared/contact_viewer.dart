import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactViewer extends StatefulWidget {
  final Size size;
  final List<Contact>? contacts;
  const ContactViewer({
    Key? key,
    required this.size,
    required this.contacts,
  }) : super(key: key);

  @override
  _ContactViewerState createState() => _ContactViewerState();
}

class _ContactViewerState extends State<ContactViewer> {
  // Image imageProcessor(Uint8List? uint8) {
  //   if (uint8 != null) {
  //     try {
  //       return Image.memory(uint8);
  //     } catch (e) {
  //       print(e);
  //       return const Image(
  //         image: AssetImage("assets/images/todo.jpg"),
  //       );
  //     }
  //   } else {
  //     return const Image(
  //       image: AssetImage("assets/images/todo.jpg"),
  //     );
  //   }
  // }

  Widget contactViewer({
    required Size size,
    required List<Contact>? contacts,
  }) {
    List<Contact> contactList = [];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.05 * size.width,
      ),
      child: SizedBox(
        width: size.width,
        height: 0.75 * size.height,
        child: (contacts!.isNotEmpty)
            ? Card(
                color: Colors.transparent,
                elevation: 0,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: contacts.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0.020 * size.height,
                        ),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.white,
                              ),
                              hintText: "Search People...",
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.25),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.25),
                                    width: 1.0),
                              ),

                              // labelText: "Search...",
                              // labelStyle: TextStyle(color: Colors.white),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                      );
                    } else if (index == 1) {
                      return ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        tileColor: Colors.white.withOpacity(0.15),
                        leading: (contacts[index].avatar != null &&
                                contacts[index].avatar!.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage:
                                    MemoryImage(contacts[index].avatar!),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.15),
                                child: Text(contacts[index].initials()),
                              ),
                        title: Text(
                          contacts[index].displayName!,
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17.5,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          contacts[index].androidAccountTypeRaw!,
                        ),
                        onTap: () {},
                      );
                    } else if (index == contacts.length) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        tileColor: Colors.white.withOpacity(0.15),
                        leading: (contacts[index].avatar != null &&
                                contacts[index].avatar!.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage:
                                    MemoryImage(contacts[index].avatar!),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.15),
                                child: Text(contacts[index].initials()),
                              ),
                        title: Text(
                          contacts[index].displayName!,
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17.5,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          contacts[index].androidAccountTypeRaw!,
                        ),
                        onTap: () {},
                      );
                    } else {
                      return ListTile(
                        tileColor: Colors.white.withOpacity(0.15),
                        leading: (contacts[index].avatar != null &&
                                contacts[index].avatar!.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage:
                                    MemoryImage(contacts[index].avatar!),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.15),
                                child: Text(
                                  contacts[index].initials(),
                                  style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                        title: Text(
                          contacts[index].displayName!,
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17.5,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          contacts[index].phones!.toString(),
                        ),
                        onTap: () {},
                      );
                    }
                  },
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  Text("Oops! Looks like you don't have any contacts."),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return contactViewer(
      size: widget.size,
      contacts: widget.contacts,
    );
  }
}

Future<List<Contact>?> contactViewerLauncher({
  required Future<int> Function() requestContactAccess,
  required Size size,
}) async {
  int? requestResponse;
  requestResponse = await requestContactAccess();
  print(requestResponse);
  if (requestResponse == 2) {
    List<Contact> contacts = await ContactsService.getContacts();
    return contacts;
  } else {
    return null;
  }
}
