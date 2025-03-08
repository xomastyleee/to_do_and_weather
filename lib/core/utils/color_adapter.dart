import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// Adapter for storing Color objects in Hive
class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 3;

  @override
  Color read(BinaryReader reader) {
    final colorValue = reader.readInt();
    return Color(colorValue);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }
}
