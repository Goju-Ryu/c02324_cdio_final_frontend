class FoodDTO {
  final int foodId;
  final String foodName, userName, expDate, location, category;

  FoodDTO({this.foodId, this.foodName, this.userName, this.expDate, this.location, this.category});

  factory FoodDTO.fromJson(Map<String, dynamic> json) {
    return FoodDTO(
        foodId: json['id'],
        foodName: json['name'],
        userName: json['userName'],
        expDate: json['expDate'],
        location: json['location'],
        category: json['category']
    );
  }
}