import 'package:flutter/material.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'TuristAPP'),
      body: Text("Profile"),
    );
  }
}
