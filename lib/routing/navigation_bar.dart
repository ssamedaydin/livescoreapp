import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livescoreapp/utils/responsive.dart';
import 'package:livescoreapp/utils/strings.dart';

class NavigationBarWidget extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationBarWidget({super.key, required this.navigationShell});
  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: Color(0xff820002),
              size: ResponsiveHelper.isTablet() ? ResponsiveHelper.width(20) : ResponsiveHelper.width(24),
            );
          }
          return IconThemeData(
            color: Colors.grey.shade600,
            size: ResponsiveHelper.isTablet() ? ResponsiveHelper.width(20) : ResponsiveHelper.width(20),
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: ResponsiveHelper.isTablet() ? ResponsiveHelper.fontSize(10) : ResponsiveHelper.fontSize(14),
              fontWeight: FontWeight.bold,
              color: Color(0xff820002),
            );
          }
          return TextStyle(
            fontSize: ResponsiveHelper.isTablet() ? ResponsiveHelper.fontSize(10) : ResponsiveHelper.fontSize(12),
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade600,
          );
        }),
      ),
      child: NavigationBar(
        backgroundColor: Colors.white,
        elevation: 8,
        height: 70,
        animationDuration: Duration(milliseconds: 500),
        shadowColor: Colors.black38,
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: widget.navigationShell.goBranch,
        destinations: [
          buildNavigationDestination(icon: Icons.live_tv, selectedIcon: Icons.live_tv, label: AppStrings.liveMatchs),
          buildNavigationDestination(icon: Icons.border_all, selectedIcon: Icons.border_all, label: AppStrings.fixtures),
          buildNavigationDestination(icon: Icons.star_border, selectedIcon: Icons.star, label: AppStrings.favorites),
          buildNavigationDestination(icon: Icons.person_outline, selectedIcon: Icons.person, label: AppStrings.profile),
        ],
      ),
    );
  }

  NavigationDestination buildNavigationDestination({required IconData icon, required IconData selectedIcon, required String label}) {
    return NavigationDestination(
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon),
      label: label,
    );
  }
}
