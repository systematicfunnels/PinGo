import 'package:flutter/material.dart';

/// Component Anatomy defines the structural composition of UI components
/// without specifying visual styles. This ensures consistent component
/// structure across the application.
///
/// Based on the design system specification:
/// - Components have defined structural hierarchies
/// - States are handled through separate styling
/// - No nested tap targets unless critical for functionality

/// Base component anatomy mixin for all interactive components
mixin ComponentAnatomy {
  /// Returns the structural hierarchy of the component
  List<String> getStructure();

  /// Returns available states for the component
  List<String> getStates();
}

/// Button Component Anatomy
///
/// Structure:
/// - Container (root wrapper)
/// - Label (primary text content)
/// - Icon.Leading (optional leading icon)
/// - Icon.Trailing (optional trailing icon)
///
/// States:
/// - Default (normal state)
/// - Pressed (active interaction)
/// - Disabled (non-interactive)
/// - Loading (processing state)
class ButtonAnatomy with ComponentAnatomy {
  @override
  List<String> getStructure() => [
        'Container',
        'Label',
        'Icon.Leading (optional)',
        'Icon.Trailing (optional)',
      ];

  @override
  List<String> getStates() => [
        'Default',
        'Pressed',
        'Disabled',
        'Loading',
      ];
}

/// Pin Component Anatomy
///
/// Structure:
/// - Anchor (map coordinate point)
/// - Marker (visual representation based on type)
/// - State (behavioral state)
///
/// States:
/// - Default (normal pin)
/// - Selected (user interaction)
/// - Draft (incomplete creation)
/// - Sensitive (restricted access)
class PinAnatomy with ComponentAnatomy {
  @override
  List<String> getStructure() => [
        'Anchor',
        'Marker',
        'State',
      ];

  @override
  List<String> getStates() => [
        'Default',
        'Selected',
        'Draft',
        'Sensitive',
      ];
}

/// Card Component Anatomy
///
/// Structure:
/// - Header (title and primary information)
/// - Content (main body content)
/// - Metadata (secondary information)
/// - Actions (optional interactive elements)
///
/// Rules:
/// - Card is tappable as a whole
/// - No nested tap targets unless critical
class CardAnatomy with ComponentAnatomy {
  @override
  List<String> getStructure() => [
        'Header',
        'Content',
        'Metadata',
        'Actions (optional)',
      ];

  @override
  List<String> getStates() => [
        'Default',
        'Selected',
        'Disabled',
      ];
}

/// Bottom Sheet / Modal Component Anatomy
///
/// Structure:
/// - Handle (swipe indicator)
/// - Title (header text)
/// - Content (main body)
/// - Actions (footer buttons)
///
/// Rules:
/// - Swipe down always dismisses
/// - No full-screen modals unless required
class SheetAnatomy with ComponentAnatomy {
  @override
  List<String> getStructure() => [
        'Handle',
        'Title',
        'Content',
        'Actions',
      ];

  @override
  List<String> getStates() => [
        'Default',
        'Expanded',
        'Collapsed',
      ];
}

/// Component Anatomy Registry
///
/// Central registry for all component anatomies to ensure
/// consistent structure across the application.
class ComponentAnatomyRegistry {
  static final ButtonAnatomy _button = ButtonAnatomy();
  static final PinAnatomy _pin = PinAnatomy();
  static final CardAnatomy _card = CardAnatomy();
  static final SheetAnatomy _sheet = SheetAnatomy();

  static ButtonAnatomy get button => _button;
  static PinAnatomy get pin => _pin;
  static CardAnatomy get card => _card;
  static SheetAnatomy get sheet => _sheet;

  /// Get anatomy for a specific component type
  static ComponentAnatomy? getAnatomy(String componentType) {
    switch (componentType.toLowerCase()) {
      case 'button':
        return _button;
      case 'pin':
        return _pin;
      case 'card':
        return _card;
      case 'sheet':
      case 'modal':
        return _sheet;
      default:
        return null;
    }
  }

  /// Validate component structure against anatomy
  static bool validateStructure(String componentType, List<String> structure) {
    final anatomy = getAnatomy(componentType);
    if (anatomy == null) return false;

    final expectedStructure = anatomy.getStructure();

    // Check if all required elements are present
    for (final element in expectedStructure) {
      if (!element.contains('(optional)') &&
          !structure.contains(element.replaceAll(' (optional)', ''))) {
        return false;
      }
    }

    return true;
  }
}

/// Component Builder Utilities
///
/// Helper utilities for building components according to their anatomical structure
class ComponentBuilder {
  /// Build a button with proper anatomical structure
  static Widget buildButton({
    required String label,
    VoidCallback? onPressed,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool isLoading = false,
    bool isEnabled = true,
  }) {
    // Container (root wrapper)
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon.Leading (optional)
        if (leadingIcon != null) leadingIcon,

        // Label (primary text content)
        Text(label),

        // Icon.Trailing (optional)
        if (trailingIcon != null) trailingIcon,
      ],
    );
  }

  /// Build a card with proper anatomical structure
  static Widget buildCard({
    required Widget header,
    required Widget content,
    Widget? metadata,
    List<Widget>? actions,
    VoidCallback? onTap,
  }) {
    // Header (title and primary information)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,

        // Content (main body content)
        content,

        // Metadata (secondary information)
        if (metadata != null) metadata,

        // Actions (optional interactive elements)
        if (actions != null && actions.isNotEmpty)
          Row(
            children: actions,
          ),
      ],
    );
  }

  /// Build a bottom sheet with proper anatomical structure
  static Widget buildSheet({
    required String title,
    required Widget content,
    List<Widget>? actions,
    bool isModal = false,
  }) {
    // Handle (swipe indicator)
    return Column(
      children: [
        // Title (header text)
        Text(title),

        // Content (main body)
        content,

        // Actions (footer buttons)
        if (actions != null && actions.isNotEmpty)
          Row(
            children: actions,
          ),
      ],
    );
  }
}
