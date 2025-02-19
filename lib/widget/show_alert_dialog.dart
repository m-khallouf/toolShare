import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

class AlertDialogHelper {
  static void showDeleteConfirmationDialog(
      BuildContext context, {
        required String title,
        required String content,
        String yesText = 'Yes',
        String noText = 'No',
        required Function onConfirm,
      }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: Theme.of(context).colorScheme.inversePrimary),
                    SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  content,
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          noText,
                          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton( // ✅ Changed from ElevatedButton to TextButton
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        child: Text(
                          yesText,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary, // Keeps theme color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
