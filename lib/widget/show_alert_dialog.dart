import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

class AlertDialogHelper {
  static void showDeleteConfirmationDialog(
      BuildContext context, {
        required String title,
        required String content,
        String yesText = 'Yes',
        String noText = 'No',
        required Function onConfirm,
      }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(noText),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context); // Close the dialog
              await onConfirm(); // Call the confirmation function
            },
            child: Text(yesText),
          ),
        ],
      ),
    );
  }
}