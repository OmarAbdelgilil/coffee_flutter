import 'dart:convert';

import 'package:coffe_front/core/providers/token_provider.dart';
import 'package:coffe_front/features/auth/presentation/auth_screen.dart';
import 'package:coffe_front/features/demand/presentation/demand_screen.dart';
import 'package:coffe_front/features/home/presentation/home_screen.dart';
import 'package:coffe_front/features/inventory/presentation/inventory_screen.dart';
import 'package:coffe_front/features/profiles/presentation/profiles_screen.dart';
import 'package:coffe_front/features/shop/presentation/shop_screen.dart';
import 'package:coffe_front/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationScreenState createState() => _NavigationScreenState();
}

bool isManager(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return false;

    final payload = base64Url.normalize(parts[1]);
    final decoded = json.decode(utf8.decode(base64Url.decode(payload)));

    return decoded['role'] == 'manager';
  } catch (e) {
    return false;
  }
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  Widget _toShow = HomeScreen();
  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Demand'),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'Orders',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Inventory'),
    if (isManager(TokenProvider().token!))
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profiles'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 1:
          _toShow = DemandScreen();
        case 2:
          _toShow = Shopscreen();
        case 3:
          _toShow = InventoryScreen();
        case 4:
          _toShow = ProfilesScreen();
        default:
          _toShow = HomeScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: ColorManager.background,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: Container(
            color: Color(0xFF415898),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.rotate(
                              angle: 0.5,
                              child: Builder(
                                builder: (context) {
                                  return IconButton(
                                    icon: const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 90),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svgs/Profile Mini.svg",
                                  ),
                                  SizedBox(height: 60),
                                  SvgPicture.asset("assets/svgs/Support.svg"),
                                  SizedBox(height: 60),
                                  SvgPicture.asset("assets/svgs/Guide.svg"),
                                  SizedBox(height: 60),
                                  SvgPicture.asset(
                                    "assets/svgs/Privacy Policy.svg",
                                  ),
                                  SizedBox(height: 50),
                                  IconButton(
                                    onPressed: () async {
                                      await TokenProvider().clearToken();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AuthScreen(),
                                        ),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    style: IconButton.styleFrom(
                                      foregroundColor: Colors.white,
                                    ),
                                    icon: Row(
                                      children: [
                                        Icon(Icons.logout),
                                        SizedBox(width: 10),
                                        Text(
                                          "Sign out",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Column(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: ColorManager.background,
      body: _toShow,
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(33),
            topRight: Radius.circular(33),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(33),
            topRight: Radius.circular(33),
          ),
          child: BottomNavigationBar(
            items: _items,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
