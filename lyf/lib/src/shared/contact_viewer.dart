import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:lyf/src/constants/invite_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactViewer extends StatefulWidget {
  final Size size;
  final List<Color> themeColors;
  final List<Contact> contacts;
  const ContactViewer({
    super.key,
    required this.size,
    required this.themeColors,
    required this.contacts,
  });

  @override
  State<ContactViewer> createState() => _ContactViewerState();
}

class _ContactViewerState extends State<ContactViewer> {
  void sendSms(String phoneNo) async {
    late Uri msg;
    if (Platform.isAndroid) {
      msg = Uri.parse(
        "sms:$phoneNo?$inviteMsgBody",
      );
    } else if (Platform.isIOS) {
      msg = Uri.parse(
        "sms:$phoneNo&$inviteMsgBody",
      );
    } else {
      msg = Uri.parse("uri");
    }
    await launchUrl(msg);
  }

  Widget contactViewer({
    required Size size,
    required List<Contact> contacts,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.05 * size.width,
        vertical: 0.01 * size.height,
      ),
      child: Container(
        width: size.width,
        height: 0.75 * size.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).splashColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        child: (contacts.isNotEmpty)
            ? Card(
                color: Colors.transparent,
                elevation: 0,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: contacts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    late BorderRadius br;

                    if (index == 0) {
                      br = const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      );
                    } else if (index == contacts.length - 1) {
                      br = const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      );
                    } else {
                      br = BorderRadius.zero;
                    }
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: br,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: widget.themeColors[0],
                        child: Text(
                          contacts[index]
                              .displayName
                              .substring(0, 2)
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      title: Text(
                        contacts[index].displayName,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      subtitle: Text(
                        contacts[index].phones.first.number.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onTap: () {
                        sendSms(
                          contacts[index].phones.first.number.toString(),
                        );
                      },
                    );
                  },
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Theme.of(context).iconTheme.color,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Oops! Looks like you don't have any contacts.",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
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
