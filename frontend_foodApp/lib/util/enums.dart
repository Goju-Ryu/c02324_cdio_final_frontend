enum ELocation { freezer, fridge, pantry }

String getLocationName(ELocation loc) {
  switch (loc) {

    case ELocation.freezer:
      return "freezer";
    case ELocation.fridge:
      return "fridge";
    case ELocation.pantry:
      return "pantry";
  }
}