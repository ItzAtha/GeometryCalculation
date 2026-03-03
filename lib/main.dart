import 'dart:math';

import 'package:bangun_ruang/geometry_card.dart';
import 'package:bangun_ruang/utility.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bangun Ruang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.green.shade400)),
      home: const MainPage(title: 'Perhitungan Bangun Ruang'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final carouselController = PageController(viewportFraction: 0.7);

    final cards = [
      GeometryCard(type: GeometryType.cube).build(),
      GeometryCard(type: GeometryType.cylinder).build(),
      GeometryCard(type: GeometryType.cone).build(),
      GeometryCard(type: GeometryType.pyramid).build(),
      GeometryCard(type: GeometryType.sphere).build(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(child: Text(widget.title)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(height: 36.0),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    "Choose Geometry to Calculate the Volume Formula",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 36.0),
                ExpandablePageView.builder(
                  controller: carouselController,
                  clipBehavior: Clip.none,
                  itemCount: cards.length,
                  itemBuilder: (_, index) {
                    if (!carouselController.position.haveDimensions) {
                      return const SizedBox();
                    }
                    return AnimatedBuilder(
                      animation: carouselController,
                      builder: (_, _) => Transform.scale(
                        scale: max(
                          0.8,
                          1 - (carouselController.page! - index).abs() * 0.2,
                        ),
                        child: cards[index],
                      ),
                    );
                  },
                ),
                SizedBox(height: 64.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
