import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:tool_share/utilities/export_all_offers.dart';

class PublishAdd extends StatefulWidget {
  @override
  _PublishAddState createState() => _PublishAddState();
}
const double _kItemExtent = 32.0;
const List<String> _categories = <String>[
  'Household tools',
  'Garden tools',
  'General tools',
];
class _PublishAddState extends State<PublishAdd> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoriesController = TextEditingController();
  int _selectedCategory = -1;

  final Map<String, bool> _availabilitySelected = {
    "hourly": false,
    "daily": false,
    "weekly": false,
    "monthly": false,
  };

  String? error;
  String? errorMessage;

  void _validateAndSubmit() {
    setState(() {
      // Check if any required field is empty
      if (_titleController.text.isEmpty ||
          _priceController.text.isEmpty ||
          _selectedCategory == -1 || // Ensure category is selected
          !_availabilitySelected.containsValue(true)) { // Ensure at least one availability is selected
        errorMessage = "Oops, seems like there is something messing!";
      } else {
        errorMessage = null; // Clear error message if everything is valid
        SubmitOffer(
          titleController: _titleController,
          priceController: _priceController,
          selectedCategory: _selectedCategory,
          categories: _categories,
          availabilitySelected: _availabilitySelected,
          onUpdate: (String uniqueId) {
            setState(() {
              _selectedCategory = -1;
              _availabilitySelected.updateAll((key, value) => false);
            });
            print("New offer submitted with ID: $uniqueId");
          },
        ).submit(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(""),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Icon(Icons.image, size: 50, color: Colors.black),
              ),
              const SizedBox(height: 25),

              // title
              MyTextField(hintText: "title", obscureText: false, controller: _titleController, errorText: error,),
              const SizedBox(height: 25),

              // availability
              GestureDetector(
                onTap: () => _showRepeatDaysModal(context),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Aligns children of the Column to the left
                      children: [
                        Text(
                          "availability",
                          style: TextStyle(fontSize: 17),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getSelectedDaysText(),
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            Icon(CupertinoIcons.chevron_right,
                                size: 20, color: Colors.black),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // price
              MyTextField(hintText: "price", obscureText: false, controller: _priceController, errorText: error),
              const SizedBox(height: 25),

              GestureDetector(
                onTap: () {
                  // Show the CupertinoPicker when the container is tapped
                  _showDialog(
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: _kItemExtent,
                      // This sets the initial item.
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedCategory >= 0 ? _selectedCategory : 0,
                      ),
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          _selectedCategory = selectedItem;
                        });
                      },
                      children: List<Widget>.generate(_categories.length, (int index) {
                        return Center(
                          child: Text(
                            _categories[index],
                            style: const TextStyle(color: Colors.black), // Change text color if needed
                          ),
                        );
                      }),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 25),// Add some padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'category: ',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ), // Change text color if needed
                      Text(
                        _selectedCategory >= 0 ? _categories[_selectedCategory] : '', // Show selected category or empty
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).colorScheme.primary, // Change text color if needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),

              const SizedBox(height: 25),
              MyButton(text: "submit an offer", onTap: _validateAndSubmit, color: Theme.of(context).colorScheme.secondary,),
            ],
          ),
        ),
      ),
    );
  }

  void _showRepeatDaysModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)), // Rounded corners
          ),
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                "Repeat",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              leading: CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Back",
                    style: TextStyle(
                        color: CupertinoColors.activeBlue, fontSize: 18)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            child: ListView(
              physics: BouncingScrollPhysics(), // iOS-like scrolling
              children: _availabilitySelected.keys.map((day) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: CupertinoColors.systemGrey4,
                          width: 0.5), // iOS divider line
                    ),
                  ),
                  child: CupertinoListTile(
                    title: Text(
                      day,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    trailing: AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: _availabilitySelected[day]! ? 1.0 : 0.0,
                      // Fade in/out effect
                      child: Icon(CupertinoIcons.checkmark,
                          color: CupertinoColors.activeBlue),
                    ),
                    onTap: () {
                      setState(() {
                        _availabilitySelected[day] =
                            !_availabilitySelected[day]!;
                      });
                      // Don't close the modal here, allow it to stay open for multiple clicks
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Function to format selected days text like iOS
  String _getSelectedDaysText() {
    List<String> selectedDays = _availabilitySelected.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.substring(0, 3))
        .toList();

    if (selectedDays.isEmpty) return "Never";
    if (selectedDays.length == 4) return "Every Day";

    // Convert selected days to a Set for comparison
    Set<String> selectedSet = selectedDays.toSet();
    Set<String> availability = {"hourly", "daily", "weekly", "monthly"};

    if (selectedSet.containsAll(availability) && selectedSet.length == 5)
      return "availability";

    return selectedDays.join(", "); // Example: "Mon, Wed, Fri"
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
