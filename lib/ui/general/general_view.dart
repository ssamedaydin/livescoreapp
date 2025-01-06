import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livescoreapp/routing/navigation_bar.dart';

class GeneralView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const GeneralView({super.key, required this.navigationShell});

  @override
  State<GeneralView> createState() => _GeneralViewState();
}

class _GeneralViewState extends State<GeneralView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.navigationShell, bottomNavigationBar: NavigationBarWidget(navigationShell: widget.navigationShell));
  }
}
