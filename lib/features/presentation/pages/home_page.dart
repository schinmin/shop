// lib/features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:vendox/features/presentation/pages/home_feed_page.dart';
import 'package:vendox/features/presentation/pages/order_page.dart';
import 'package:vendox/features/presentation/pages/profile_page.dart';
import 'package:vendox/features/presentation/pages/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  
  late final List<Widget> _pages;
  late final List<GlobalKey<NavigatorState>> _navigatorKeys;

  @override
  void initState() {
    super.initState();
    _navigatorKeys = [
      GlobalKey<NavigatorState>(), // Home Feed
      GlobalKey<NavigatorState>(), // Wishlist
      GlobalKey<NavigatorState>(), // Orders
      GlobalKey<NavigatorState>(), // Profile
    ];
    
    _pages = [
      const HomeFeedPage(),
      const WishlistPage(),
      const OrdersPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = 
            !await _navigatorKeys[_currentIndex].currentState!.maybePop();
        
        if (isFirstRouteInCurrentTab) {
          if (_currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages.asMap().entries.map((entry) {
            return _buildOffstageNavigator(entry.value, entry.key);
          }).toList(),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (index) {
              if (_currentIndex == index) {
                // Pop to first route when tapping same tab
                _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
              } else {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey[400],
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                activeIcon: Icon(Icons.shopping_bag),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(Widget page, int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => page,
          );
        },
      ),
    );
  }
}