import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:to_do_and_weather/core/utils/color_adapter.dart';
import 'color_adapter_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<BinaryWriter>(),
  MockSpec<BinaryReader>(),
])
void main() {
  group('ColorAdapter', () {
    late ColorAdapter adapter;
    late MockBinaryWriter writer;
    late MockBinaryReader reader;

    setUp(() {
      adapter = ColorAdapter();
      writer = MockBinaryWriter();
      reader = MockBinaryReader();
    });

    test('should write Color value to binary', () {
      const color = Colors.blue;

      adapter.write(writer, color);

      verify(writer.writeInt(color.value)).called(1);
    });

    test('should read Color from binary', () {
      final colorValue = Colors.red.value;
      when(reader.readInt()).thenReturn(colorValue);

      final result = adapter.read(reader);

      expect(result.value, Colors.red.value);
      verify(reader.readInt()).called(1);
    });
  });
}
