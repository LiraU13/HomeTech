import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometech/screens/home/settings/devices_edit/cameras_edit_screen.dart';
import 'package:hometech/screens/home/settings/devices_edit/lights_edit_screen.dart';
import 'package:hometech/screens/home/settings/devices_edit/motors_edit_screen.dart';
import 'package:hometech/screens/home/settings/devices_edit/sensors_edit_screen.dart';

class DevicesEditScreen extends StatefulWidget {
  // initialIndex es requerido para el TabBar
  final int initialIndex;
  const DevicesEditScreen({super.key, this.initialIndex = 0});

  @override
  State<DevicesEditScreen> createState() => _DevicesEditScreenState();
}

class _DevicesEditScreenState extends State<DevicesEditScreen>
    with TickerProviderStateMixin {
  // TabBar
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                automaticallyImplyLeading: true,
                title: Text(
                  'Editar mis dispositivos',
                  style: GoogleFonts.poppins(fontSize: 25),
                ),
                centerTitle: false,
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
                    Tab(text: "Cámaras"),
                    Tab(text: "Luces"),
                    Tab(text: "Motores"),
                    Tab(text: "Sensores"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              CamerasEditScreen(),
              LightsEditScreen(),
              MotorsEditScreen(),
              SensorsEditScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
