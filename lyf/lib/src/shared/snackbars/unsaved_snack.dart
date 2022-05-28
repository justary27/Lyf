import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar unsavedSnack({
  required BuildContext parentContext,
  required Size size,
  required Object item,
}) {
  return SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.grey.shade700,
    content: Container(
      alignment: Alignment.center,
      height: 0.170 * size.height,
      padding: EdgeInsets.fromLTRB(0, 0.0125 * size.height, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0.0175 * size.height),
            child: Text(
              "Do you want to go back without updating ${item.runtimeType.toString().toLowerCase()}?",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.40,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(parentContext).hideCurrentSnackBar();
                      Navigator.of(parentContext).pop();
                    },
                    child: Text(
                      "Yes",
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.40,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          side: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(parentContext).hideCurrentSnackBar();
                    },
                    child: Text(
                      "No",
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
