import 'package:flutter/material.dart';
import 'package:elfaa/constants.dart';

enum DialogsAction {yes, cancel}

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(DialogsAction.cancel),
                  child: Text(
                    'إلغاء', textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF9C0000),
                        fontWeight: FontWeight.bold), // TextStyle
                  ),
                ),
                 TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(DialogsAction.yes),
                  child: Text(
                    'تأكيد', textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold), // TextStyle
                  ),
                ),
              ]);
        });
        return (action != null) ? action : DialogsAction.cancel;
  }
}
