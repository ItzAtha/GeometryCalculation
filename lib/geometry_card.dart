import 'package:animations/animations.dart';
import 'package:bangun_ruang/utility.dart';
import 'package:flutter/material.dart';

import 'geometry_page.dart';

class GeometryCard {
  final GeometryType _geometryType;

  GeometryCard({
    required GeometryType type,
  }) : _geometryType = type;

  Widget build() {
    String title = _geometryType.name;
    String formula = GeometryUtility.getFormula(_geometryType)[0];
    String formulaDescription = GeometryUtility.getFormula(_geometryType)[1];

    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      closedBuilder: (context, action) => Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("$title Geometry", style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              Hero(
                tag: title,
                child: Image.asset(
                  "assets/${title.toLowerCase()}.png",
                  height: 160.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text("Formula: $formula", style: const TextStyle(fontSize: 16.0)),
              Text("Where: $formulaDescription", style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
      openBuilder: (context, action) => GeometryPage(geometryType: _geometryType),
    );
  }
}