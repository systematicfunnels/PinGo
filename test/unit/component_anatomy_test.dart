import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pingo/core/theme/component_anatomy.dart';

void main() {
  group('Component Anatomy', () {
    test('Button anatomy has correct structure', () {
      final button = ButtonAnatomy();
      final structure = button.getStructure();

      expect(structure, contains('Container'));
      expect(structure, contains('Label'));
      expect(structure, contains('Icon.Leading (optional)'));
      expect(structure, contains('Icon.Trailing (optional)'));
    });

    test('Button anatomy has correct states', () {
      final button = ButtonAnatomy();
      final states = button.getStates();

      expect(states, contains('Default'));
      expect(states, contains('Pressed'));
      expect(states, contains('Disabled'));
      expect(states, contains('Loading'));
    });

    test('Pin anatomy has correct structure', () {
      final pin = PinAnatomy();
      final structure = pin.getStructure();

      expect(structure, contains('Anchor'));
      expect(structure, contains('Marker'));
      expect(structure, contains('State'));
    });

    test('Pin anatomy has correct states', () {
      final pin = PinAnatomy();
      final states = pin.getStates();

      expect(states, contains('Default'));
      expect(states, contains('Selected'));
      expect(states, contains('Draft'));
      expect(states, contains('Sensitive'));
    });

    test('Card anatomy has correct structure', () {
      final card = CardAnatomy();
      final structure = card.getStructure();

      expect(structure, contains('Header'));
      expect(structure, contains('Content'));
      expect(structure, contains('Metadata'));
      expect(structure, contains('Actions (optional)'));
    });

    test('Card anatomy has correct states', () {
      final card = CardAnatomy();
      final states = card.getStates();

      expect(states, contains('Default'));
      expect(states, contains('Selected'));
      expect(states, contains('Disabled'));
    });

    test('Sheet anatomy has correct structure', () {
      final sheet = SheetAnatomy();
      final structure = sheet.getStructure();

      expect(structure, contains('Handle'));
      expect(structure, contains('Title'));
      expect(structure, contains('Content'));
      expect(structure, contains('Actions'));
    });

    test('Sheet anatomy has correct states', () {
      final sheet = SheetAnatomy();
      final states = sheet.getStates();

      expect(states, contains('Default'));
      expect(states, contains('Expanded'));
      expect(states, contains('Collapsed'));
    });
  });

  group('Component Anatomy Registry', () {
    test('Registry provides correct anatomies', () {
      expect(ComponentAnatomyRegistry.button, isA<ButtonAnatomy>());
      expect(ComponentAnatomyRegistry.pin, isA<PinAnatomy>());
      expect(ComponentAnatomyRegistry.card, isA<CardAnatomy>());
      expect(ComponentAnatomyRegistry.sheet, isA<SheetAnatomy>());
    });

    test('Registry returns null for unknown component types', () {
      final anatomy = ComponentAnatomyRegistry.getAnatomy('unknown');
      expect(anatomy, isNull);
    });

    test('Registry validates component structure correctly', () {
      // Valid button structure
      final validButtonStructure = [
        'Container',
        'Label',
        'Icon.Leading (optional)',
        'Icon.Trailing (optional)',
      ];
      expect(
        ComponentAnatomyRegistry.validateStructure(
            'button', validButtonStructure),
        isTrue,
      );

      // Invalid button structure (missing required element)
      final invalidButtonStructure = [
        'Label',
        'Icon.Leading (optional)',
      ];
      expect(
        ComponentAnatomyRegistry.validateStructure(
            'button', invalidButtonStructure),
        isFalse,
      );

      // Valid card structure with optional actions
      final validCardStructure = [
        'Header',
        'Content',
        'Metadata',
        'Actions (optional)',
      ];
      expect(
        ComponentAnatomyRegistry.validateStructure('card', validCardStructure),
        isTrue,
      );

      // Valid card structure without optional actions
      final validCardStructureWithoutActions = [
        'Header',
        'Content',
        'Metadata',
      ];
      expect(
        ComponentAnatomyRegistry.validateStructure(
            'card', validCardStructureWithoutActions),
        isTrue,
      );
    });
  });

  group('Component Builder', () {
    test('Button builder creates widget with proper structure', () {
      final button = ComponentBuilder.buildButton(
        label: 'Test Button',
        leadingIcon: const Icon(Icons.add),
        trailingIcon: const Icon(Icons.arrow_forward),
      );

      expect(button, isA<Row>());
      // Note: We can't easily test the internal structure without rendering
      // but we can verify the widget is created successfully
    });

    test('Card builder creates widget with proper structure', () {
      final card = ComponentBuilder.buildCard(
        header: const Text('Header'),
        content: const Text('Content'),
        metadata: const Text('Metadata'),
        actions: [const Text('Action')],
      );

      expect(card, isA<Column>());
      // Note: We can't easily test the internal structure without rendering
      // but we can verify the widget is created successfully
    });

    test('Sheet builder creates widget with proper structure', () {
      final sheet = ComponentBuilder.buildSheet(
        title: 'Sheet Title',
        content: const Text('Content'),
        actions: [const Text('Action')],
      );

      expect(sheet, isA<Column>());
      // Note: We can't easily test the internal structure without rendering
      // but we can verify the widget is created successfully
    });
  });
}
