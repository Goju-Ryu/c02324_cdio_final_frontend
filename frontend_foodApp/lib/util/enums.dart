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
      throw new Exception("Unknown Location: \"" + loc.toString() + "\"");
  }
}

ELocation getLocationEnum(String loc) {
  switch (loc) {
    case "Freezer":
      return ELocation.Freezer;
    case "Fridge":
      return ELocation.Fridge;
    case "Pantry":
      return ELocation.Pantry;
    default:
      throw new Exception("Unknown Location: \"" + loc + "\"");
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
      return "Dairy";
    case ECategory.Bread:
      return "Bread";
    case ECategory.Other:
      return "Other";
  }
}

ECategory getCategoryEnum(String cat) {
  switch (cat) {

    case "Fish":
      return ECategory.Fish;
    case "Beef":
      return ECategory.Beef;
    case "Poultry":
      return ECategory.Poultry;
    case "Pork":
      return ECategory.Pork;
    case "Vegetables":
      return ECategory.Vegetable;
    case "Fruit":
      return ECategory.Fruit;
    case "Dairy":
      return ECategory.Dairy;
    case "Bread":
      return ECategory.Bread;
    case "Other":
      return ECategory.Other;
    default:
      throw new Exception("Unknown Location: \"" + cat + "\"");
  }
}