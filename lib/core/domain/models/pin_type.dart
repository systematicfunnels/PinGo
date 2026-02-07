enum PinType {
  memory, // Default: A personal memory or note
  safety, // Safety warning or note
  landmark, // Interesting place
  restroom, // Public restroom
  water, // Water source
  scenic, // Scenic view
}

extension PinTypeExtension on PinType {
  String get label {
    switch (this) {
      case PinType.memory:
        return 'Memory';
      case PinType.safety:
        return 'Safety Warning';
      case PinType.landmark:
        return 'Landmark';
      case PinType.restroom:
        return 'Restroom';
      case PinType.water:
        return 'Water Source';
      case PinType.scenic:
        return 'Scenic View';
    }
  }
}
