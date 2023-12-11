import 'package:flutter/material.dart';

class AppBars extends StatelessWidget implements PreferredSize {
  const AppBars({super.key, required this.onTap, this.isLoading});
  final VoidCallback onTap;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: onTap,
            icon: isLoading! 
                ? const CircularProgressIndicator()
                : const Icon(Icons.logout))
      ],
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
