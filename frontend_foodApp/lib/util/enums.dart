enum ELocation {
  Freezer, Fridge, Pantry
}

String getLocationName(ELocation loc) {
  switch (loc) {
    case ELocation.Freezer:
      return "Freezer";
    case ELocation.Fridge:
      return "Fridge";
    case ELocation.Pantry:
      return "Pantry";
    default:
      throw new Exception("UnKnown Location");
  }
}


enum ECategory {
  Fish, Beef, Poultry, Pork, Vegetable, Fruit, Dairy, Bread, Other
}

String getCategoryName(ECategory cat) {
  switch (cat) {

    case ECategory.Fish:
      return "Fish";
    case ECategory.Beef:
      return "Beef";
    case ECategory.Poultry:
      return "Poultry";
    case ECategory.Pork:
      return "Pork";
    case ECategory.Vegetable:
      return "Vegetables";
    case ECategory.Fruit:
      return "Fruit";
    case ECategory.Dairy:
      return "Daiary";
    case ECategory.Bread:
      return "Bread";
    case ECategory.Other:
      return "Other";
  }
}