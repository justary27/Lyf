import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/models/todo_model.dart';

SnackBar deleteSnack({
  required BuildContext parentContext,
  required Size size,
  required Object item,
  Function? performDeleteTask,
}) {
  Todo? todo;
  DiaryEntry? entry;
  String itemName = "";
  if (item is Todo) {
    itemName = item.todoTitle;
    todo = item;
  } else if (item is DiaryEntry) {
    itemName = item.entryTitle;
    entry = item;
  }
  return SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    duration: const Duration(
      seconds: 5,
    ),
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
              "Are you sure you want to delete the entry $itemName?",
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
                      if (performDeleteTask != null) {
                        if (todo != null) {
                          performDeleteTask(todo);
                        } else if (entry != null) {
                          performDeleteTask(entry);
                        }
                      }
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
