import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  final int selectedIndex;
  
  const BottomNavBar({
    super.key, 
    required this.onTabChange,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: GNav(
            selectedIndex: selectedIndex,
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            haptic: true,
            tabBorderRadius: 20,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBorder: Border.all(color: Colors.grey[300]!, width: 1),
            tabShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 8,
              )
            ],
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 300),
            gap: 8,
            color: Colors.grey[600],
            activeColor: Colors.white,
            iconSize: 24,
            tabBackgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            onTabChange: (index) {
              if (onTabChange != null) {
                onTabChange!(index);
              }
            },
            tabs: const [
              GButton(
                icon: Icons.store_rounded,
                text: 'Shop',
              ),
              GButton(
                icon: Icons.shopping_cart_rounded,
                text: 'Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}