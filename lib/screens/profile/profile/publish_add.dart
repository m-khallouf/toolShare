import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/screens/profile/profile/not_empty_account.dart';
import 'package:tool_share/services/offers/submit_offer.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:tool_share/utilities/export_all_widget.dart';



class PublishAdd extends StatefulWidget {
  @override
  _PublishAddState createState() => _PublishAddState();
}
const double _kItemExtent = 32.0;
const List<String> _categories = <String>[
  'Househole',
  'Garden',
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
          onUpdate: () {
            setState(() {
              _selectedCategory = -1;
              _availabilitySelected.updateAll((key, value) => false);
            });
          },
        ).submit(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Container(
                width: double.infinity,
                height: 230,
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

              /*GestureDetector(
                onTap: () => _showCategoryPicker(context),
                child: Container(
                  width: 365,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,  // Centering vertically
                      children: [
                        Text(
                          _categoriesController.text.isEmpty ? "category: " : "category: ${_categoriesController.text}",
                          style: TextStyle(fontSize: 17),
                        ),
                        Icon(
                          CupertinoIcons.chevron_right,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/

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
                        'categorie: ',
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

  /*void submit() async {

    try {
      // Reference to Firestore
      CollectionReference offers = FirebaseFirestore.instance.collection('offers');

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser ;

      // Data to be uploaded
      Map<String, dynamic> offerData = {
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'category': _categories[_selectedCategorie],
        'availability': _availabilitySelected.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList(),
        'userId': user?.uid,
      };

      // Save data to Firestore
      await offers.add(offerData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Offer submitted successfully!')),
      );

      // Clear fields after successful submission
      _descriptionController.clear();
      _priceController.clear();
      setState(() {
        _selectedCategorie = -1;
        _availabilitySelected.updateAll((key, value) => false);
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting offer: $e')),
      );
    }
  }*/

  /*void submit() async {
    try {
      print("Submit function called");

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      print("Current User: ${user?.uid ?? 'No user logged in'}");

      // Check if the user is null
      if (user == null) {
        print("No user is logged in!");
        return;
      }

      // Reference to Firestore
      CollectionReference offers = FirebaseFirestore.instance.collection('offers');

      // Data to be uploaded
      Map<String, dynamic> offerData = {
        'title': _titleController.text,
        'price': double.tryParse(_priceController.text) ?? 0.0,
        'category': _selectedCategorie >= 0 ? _categories[_selectedCategorie] : '',
        'availability': _availabilitySelected.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList(),
        'userId': user.uid, // Ensure this is correct
      };

      print("Uploading data: $offerData");

      // Save data to Firestore
      await offers.add(offerData);

      // Success message
      print("Offer submitted by user: ${user.uid}");

      // Clear fields after successful submission
      _titleController.clear();
      _priceController.clear();
      setState(() {
        _selectedCategorie = -1;
        _availabilitySelected.updateAll((key, value) => false);
      });

    } catch (e) {
      print("Error submitting offer: $e");
    }
  }*/

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
