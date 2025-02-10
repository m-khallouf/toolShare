import 'package:flutter/material.dart';
import 'package:tool_share/screens/profile/profile/publish_add.dart';

import '../../../services/offers/get_user_offers.dart';

import 'package:tool_share/utilities/export_all_widget.dart';


class NotEmptyAccountScreen extends StatelessWidget {
  const NotEmptyAccountScreen({super.key});

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
              // User information
              MyContainer(height: 200, text: "user information"),
              const SizedBox(height: 25),

              // current Offers
              Container(
                width: 360,
                height: 400,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FutureBuilder<List<Widget>>(
                  future: GetUserOffers().getCurrentOffers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text("Fehler beim Laden der Angebote"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("Keine Angebote verfügbar"));
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
