import 'package:badge_hack/profile/src/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ProfileScreen(),
    );
  }

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(),
      builder: (context, _) {
        final viewModel = context.watch<ProfileViewModel>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Column(
            children: [
              TextField(
                controller: viewModel.nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              ElevatedButton(
                onPressed: viewModel.save,
                child: const Text('Save name'),
              ),
              _TagWriter(),
            ],
          ),
        );
      },
    );
  }
}

class _TagWriter extends StatelessWidget {
  const _TagWriter();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();

    if (viewModel.writing) {
      return const CircularProgressIndicator();
    }

    return ElevatedButton(
      onPressed: viewModel.writeTag,
      child: const Text('Write to NFC tag'),
    );
  }
}
