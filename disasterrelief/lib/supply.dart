// The base class for the items the list will contain
abstract class ListItem {}

// A ListItem that contians data to display a heading
class HeadingText implements ListItem {
  final String heading;
  final String name;
  HeadingText(this.heading, this.name);
}

// A sample ListItem with data to display
class SupplyItem implements ListItem {
  final String name;
  final String description; 
  final String sender;
  final String cost;
  // Need Latitude and Longitude for location
  SupplyItem(this.name, this.description, this.sender, this.cost);
}



