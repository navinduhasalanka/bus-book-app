import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0; // To track the selected page

  // A list of text widgets corresponding to each page
  final List<Widget> _pages = const [
    Text('Page 1', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Page 2', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Page 3', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Page 4', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Navigation Menu'),
          elevation: 0,
        ),
        body: Center(child: _pages[_selectedIndex]), // Show selected page
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavigationMenuIcon(
                    icon: Icons.home_filled,
                    label: 'Home',
                    onPressed: () => _onItemTapped(0),
                  ),
                  _NavigationMenuIcon(
                    icon: Icons.list_alt_outlined,
                    label: 'Bookings',
                    onPressed: () => _onItemTapped(1),
                  ),
                  _NavigationMenuIcon(
                    icon: Icons.settings,
                    label: 'Settings',
                    onPressed: () => _onItemTapped(2),
                  ),
                  _NavigationMenuIcon(
                    icon: Icons.account_circle, // Profile icon
                    label: 'Profile',
                    onPressed: () => _onItemTapped(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationMenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _NavigationMenuIcon({
    required this.icon,
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}