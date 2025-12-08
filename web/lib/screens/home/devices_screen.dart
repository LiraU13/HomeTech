import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hometech/screens/home/devices/cameras_screen.dart';
import 'package:hometech/screens/home/devices/lights_screen.dart';
import 'package:hometech/screens/home/devices/motors_screen.dart';
import 'package:hometech/screens/home/devices/sensors_screen.dart';
import 'package:hometech/widgets/routes.dart';

class DevicesScreen extends StatefulWidget {
  // initialIndex es requerido para el TabBar
  final int initialIndex;
  const DevicesScreen({super.key, this.initialIndex = 0});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen>
    with TickerProviderStateMixin {
  // TabBar
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // BottomNavBar
  int selectedIndex = 1;
  List screens = const [
    AppRoutes.home,
    AppRoutes.devices,
    AppRoutes.settings,
  ];
  openScreen(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.pushNamed(context, AppRoutes.home);
          break;
        case 1:
          Navigator.pushNamed(context, AppRoutes.devices);
          break;
        case 2:
          Navigator.pushNamed(context, AppRoutes.settings);
          break;
      }
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                automaticallyImplyLeading: false,
                title: Text(
                  'Dispositivos',
                  style: GoogleFonts.poppins(fontSize: 35),
                ),
                centerTitle: true,
                pinned: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  labelStyle: GoogleFonts.poppins(fontSize: 14.9),
                  labelColor: Theme.of(context).colorScheme.onSecondary,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onTertiary,
                  indicatorColor: Theme.of(context).colorScheme.onPrimary,
                  controller: _tabController,
                  tabs: const [
                    // Tab(text: 'Cámaras'),
                    Tab(text: 'Luces'),
                    Tab(text: 'Motores'),
                    Tab(text: 'Sensores'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              // CamerasScreen(),
              LightsScreen(),
              MotorsScreen(),
              SensorsScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
        onTap: (index) => openScreen(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_other),
            label: 'Dispositivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}
