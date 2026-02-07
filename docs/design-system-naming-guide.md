# Design System Naming Guide

## Overview

Every visual decision in PinGo must be:

- **Nameable** - Every design choice has a specific, descriptive name
- **Tokenized** - Every visual property is defined as a reusable token
- **Reusable** - Every token can be applied consistently across the application

## Naming Conventions

### Color Tokens

```dart
// ✅ GOOD: Specific, descriptive names
AppColors.primary.s500  // Deep Forest (main brand accent)
AppColors.neutral.s900  // Primary text
AppColors.map.pin       // Map pin color

// ❌ BAD: Generic or ambiguous names
AppColors.blue          // Which blue?
AppColors.text          // Which text?
AppColors.main          // What does this mean?
```

### Spacing Tokens

```dart
// ✅ GOOD: Semantic and numeric aliases
AppSpacing.md           // 12px (content separation)
AppSpacing.section      // 32px (section breaks)
AppSpacing.cardPadding  // 16px (card internal padding)

// ❌ BAD: Arbitrary numbers or unclear names
AppSpacing.fourteen     // What does 14 mean?
AppSpacing.big          // How big?
AppSpacing.padding      // What kind of padding?
```

### Radius Tokens

```dart
// ✅ GOOD: Purpose-driven names
AppRadius.all12         // Cards
AppRadius.all16         // Modals, sheets
AppRadius.top16         // Top-only (sheets)

// ❌ BAD: Generic or confusing names
AppRadius.round         // How round?
AppRadius.corner        // Which corner?
AppRadius.medium        // Medium what?
```

### Elevation Tokens

```dart
// ✅ GOOD: Context-specific names
AppElevation.card       // Cards
AppElevation.floating   // Floating controls
AppElevation.modal      // Modals

// ❌ BAD: Generic or unclear names
AppElevation.shadow     // What kind of shadow?
AppElevation.level1     // What does level 1 mean?
AppElevation.up         // Up from what?
```

### Motion Tokens

```dart
// ✅ GOOD: Purpose and duration
Motion.fast             // 125ms (quick feedback)
Motion.medium           // 250ms (standard interactions)
Motion.slow             // 500ms (important transitions)

// ❌ BAD: Ambiguous or confusing names
Motion.quick            // How quick?
Motion.normal           // What's normal?
Motion.slowly           // This is an adverb, not a token
```

## Component Anatomy Naming

### Structure Elements

```dart
// ✅ GOOD: Clear hierarchy
ButtonAnatomy:
  - Container (root wrapper)
  - Label (primary text content)
  - Icon.Leading (optional leading icon)
  - Icon.Trailing (optional trailing icon)

PinAnatomy:
  - Anchor (map coordinate point)
  - Marker (visual representation)
  - State (behavioral state)

// ❌ BAD: Unclear or inconsistent
ButtonAnatomy:
  - Wrapper
  - Text
  - Icon1
  - Icon2
```

### State Names

```dart
// ✅ GOOD: Descriptive states
Button States:
  - Default (normal state)
  - Pressed (active interaction)
  - Disabled (non-interactive)
  - Loading (processing state)

Pin States:
  - Default (normal pin)
  - Selected (user interaction)
  - Draft (incomplete creation)
  - Sensitive (restricted access)

// ❌ BAD: Generic or unclear states
Button States:
  - Normal
  - Active
  - Inactive
  - Busy
```

## Usage Examples

### When Someone Says "Make it feel softer"

**Instead of:** "Make the button look softer"

**You answer with:**
```dart
// Softer button implementation
Container(
  decoration: BoxDecoration(
    color: AppColors.neutral.s100,    // Surface color
    borderRadius: AppRadius.all12,     // Rounded corners
    boxShadow: AppElevation.card,      // Subtle shadow
  ),
  child: Text(
    'Button',
    style: TextStyle(
      color: AppColors.neutral.s900,   // Primary text color
    ),
  ),
)
```

### When Someone Says "Increase spacing"

**Instead of:** "Make it bigger"

**You answer with:**
```dart
// Increased spacing implementation
Padding(
  padding: EdgeInsets.all(AppSpacing.xl), // 24px section spacing
  child: Column(
    children: [
      // Content with proper spacing
    ],
  ),
)
```

### When Someone Says "Make the animation smoother"

**Instead of:** "Make it smoother"

**You answer with:**
```dart
// Smoother animation implementation
AnimationController(
  duration: Motion.medium,           // 250ms standard duration
  vsync: this,
)..animate(
  CurvedAnimation(
    parent: controller,
    curve: Motion.gentle,             // Gentle easing curve
  ),
)
```

## Token Hierarchy

### Primary Tokens (Base Values)

```dart
// Colors
AppColors.primary.s500 = Color(0xFF2C4A52)  // Deep Forest

// Spacing
AppSpacing.md = 12.0                         // Content separation

// Radius
AppRadius.r12 = 12.0                         // Card radius

// Elevation
AppElevation.card = [BoxShadow(...)]         // Card shadow
```

### Semantic Tokens (Purpose-Driven)

```dart
// Derived from primary tokens
AppSpacing.cardPadding = AppSpacing.md       // 12px for cards
AppRadius.card = AppRadius.all12             // 12px for cards
AppElevation.floating = AppElevation.card    // Same as card
```

### Component Tokens (Component-Specific)

```dart
// Component-specific combinations
ButtonTokens.primary = {
  'color': AppColors.primary.s500,
  'padding': EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.lg,
  ),
  'radius': AppRadius.all8,
  'elevation': AppElevation.card,
}
```

## Benefits of This Naming System

1. **Consistency** - Every developer uses the same names for the same things
2. **Maintainability** - Changes propagate automatically through the system
3. **Scalability** - New components follow established patterns
4. **Communication** - Design and development teams speak the same language
5. **Quality** - Reduces visual inconsistencies and bugs

## Validation Rules

1. **Every visual property must have a token name**
2. **Every token name must be descriptive and purpose-driven**
3. **Every component must follow its anatomical structure**
4. **Every state must be explicitly defined**
5. **No hardcoded values in component code**

## Migration Strategy

When updating existing code:

1. **Identify hardcoded values** - Find magic numbers and colors
2. **Map to existing tokens** - Use appropriate existing tokens
3. **Create new tokens if needed** - Only when existing tokens don't fit
4. **Update component structure** - Ensure anatomical compliance
5. **Test thoroughly** - Verify visual consistency

This naming system ensures that PinGo's design system remains consistent, maintainable, and scalable as the application grows.