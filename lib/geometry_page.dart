import 'dart:math';

import 'package:bangun_ruang/utility.dart';
import 'package:flutter/material.dart';

class GeometryPage extends StatefulWidget {
  GeometryType geometryType;

  GeometryPage({super.key, required this.geometryType});

  @override
  State<StatefulWidget> createState() => _GeometryPageState();
}

class _GeometryPageState extends State<GeometryPage> {
  TextEditingController input1Controller = TextEditingController();
  TextEditingController input2Controller = TextEditingController();

  Widget getGeometryInputFields(GeometryType type) {
    switch (type) {
      case GeometryType.cube:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Side Length (s)   =   ", style: const TextStyle(fontSize: 16.0)),
            Expanded(child: TextField(controller: input1Controller, decoration: const InputDecoration(labelText: "Side Length (s)"), keyboardType: TextInputType.number)),
          ],
        );
      case GeometryType.cylinder || GeometryType.cone:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Radius (r)   =   ", style: const TextStyle(fontSize: 16.0)),
            Expanded(child: TextField(controller: input1Controller, decoration: const InputDecoration(labelText: "Radius (r)"), keyboardType: TextInputType.number, textInputAction: TextInputAction.next)),
            SizedBox(width: 16.0),
            Text("Height (h)   =   ", style: const TextStyle(fontSize: 16.0)),
            Expanded(child: TextField(controller: input2Controller, decoration: const InputDecoration(labelText: "Height (h)"), keyboardType: TextInputType.number)),
          ],
        );
      case GeometryType.pyramid:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Base Area (B)   =   ", style: const TextStyle(fontSize: 16.0)),
            Expanded(child: TextField(controller: input1Controller, decoration: const InputDecoration(labelText: "Base Area (B)"), keyboardType: TextInputType.number, textInputAction: TextInputAction.next)),
            SizedBox(width: 16.0),
            Text("Height (h)   =   ", style: const TextStyle(fontSize: 16.0)),
            Expanded(child: TextField(controller: input2Controller, decoration: const InputDecoration(labelText: "Height (h)"), keyboardType: TextInputType.number)),
          ],
        );
      case GeometryType.sphere:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Radius (r)   =   ", style: const TextStyle(fontSize: 16.0)),
            Expanded(child: TextField(controller: input1Controller, decoration: const InputDecoration(labelText: "Radius (r)"), keyboardType: TextInputType.number)),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.geometryType.name;
    String formula = GeometryUtility.getFormula(widget.geometryType)[0];
    String formulaDescription = GeometryUtility.getFormula(widget.geometryType)[1];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("$title Geometry"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              SizedBox(
                height: widget.geometryType == GeometryType.cube ? MediaQuery.of(context).size.height * 0.34 : MediaQuery.of(context).size.height * 0.365,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Card(
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
                        Text("Where: $formulaDescription", style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Text("Input the required parameters to calculate the volume of the $title.", style: const TextStyle(fontSize: 16.0), textAlign: TextAlign.center),
              const SizedBox(height: 32.0),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: getGeometryInputFields(widget.geometryType)),
              const SizedBox(height: 42.0),
              ElevatedButton(
                onPressed: () {
                  double input1 = double.tryParse(input1Controller.text) ?? 0.0;
                  double input2 = double.tryParse(input2Controller.text) ?? 0.0;

                  var dialog = AlertDialog(
                    title: Center(child: Text("Calculate Result")),
                    content: Text("The volume of the $title is: ${GeometryUtility.calcVolume(widget.geometryType, input1, input2).toStringAsFixed(2)}"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
                    ],
                  );

                  showDialog(context: context, builder: (context) => dialog);
                },
                child: const Text("Calculate Volume"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}