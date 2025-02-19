import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:tool_share/utilities/export_all_profile.dart';
import 'package:tool_share/utilities/export_all_offers.dart';

class NotEmptyAccountScreen extends StatelessWidget {
  const NotEmptyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      navigationBar: CupertinoNavigationBar(
        middle:  Text("Profile", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontSize: 20),),
        // Custom leading widget to change the back arrow color
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(
              CupertinoPageRoute(builder: (context) => AccountSettingsScreen()),
            );
          },
          child: Icon(
            CupertinoIcons.back,
            color: Theme.of(context).colorScheme.inversePrimary, // Change the back arrow color to red
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User information
              MyContainer(height: 100, text: "user information"),
              const SizedBox(height: 25),

              // current Offers
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: FutureBuilder<List<Widget>>(
                  future: OfferService().getOffers(onlyCurrentUser: true),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Fehler beim Laden der Angebote"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Keine Angebote verfügbar"));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!,
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 25),

              // Create new ad
              MyButton(
                text: "Publish an ad",
                onTap: () => publishAdd(context),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void publishAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PublishAdd()),
    );
  }
}
