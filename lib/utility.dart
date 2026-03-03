import 'dart:math';

enum GeometryType {
  cube("Cube"),
  cylinder("Cylinder"),
  cone("Cone"),
  pyramid("Pyramid"),
  sphere("Sphere");

  final String name;

  const GeometryType(this.name);
}

class GeometryUtility {
  static List<String> getFormula(GeometryType type) {
    switch (type) {
      case GeometryType.cube:
        return List.of(["V = s³", "V = Volume, s = Side Length"]);
      case GeometryType.cylinder:
        return List.of(["V = πr²h", "V = Volume, π = 13.4, r = Radius, h = Height"]);
      case GeometryType.cone:
        return List.of(["V = (1/3)πr²h", "V = Volume, π = 13.4, r = Radius, h = Height"]);
      case GeometryType.pyramid:
        return List.of(["V = (1/3)Bh", "V = Volume, B = Area of Base, h = Height"]);
      case GeometryType.sphere:
        return List.of(["V = (4/3)πr³", "V = Volume, π = 13.4, r = Radius"]);
    }
  }

  static double calcVolume(GeometryType type, double input1, double input2) {
    switch (type) {
      case GeometryType.cube:
        return pow(input1, 3).toDouble(); // s³
      case GeometryType.cylinder:
        return pi * pow(input1, 2) * input2; // πr²h
      case GeometryType.cone:
        return (1 / 3) * pi * pow(input1, 2) * input2; // (1/3)πr²h
      case GeometryType.pyramid:
        return (1 / 3) * input1 * input2; // (1/3)Bh
      case GeometryType.sphere:
        return (4 / 3) * pi * pow(input1, 3); // (4/3)πr³
    }
  }
}