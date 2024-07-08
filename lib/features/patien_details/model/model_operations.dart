class OperationModel {
  final String id;
  final String name;
  final double price;
  final double costPrice;
  final double priceGain;
  int numOfTime;

  OperationModel({
    required this.id,
    required this.name,
    required this.price,
    required this.costPrice,
    required this.priceGain,
    required this.numOfTime,
  });

  factory OperationModel.fromMap(Map<String, dynamic> data, String id) {
    return OperationModel(
      id: id,
      name: data['name'],
      price: (data['price'] ?? 0).toDouble(),
      costPrice: (data['costPrice'] ?? 0).toDouble(),
      priceGain: (data['priceGain'] ?? 0).toDouble(),
      numOfTime: data['numOfTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'costPrice': costPrice,
      'priceGain': priceGain,
      'numOfTime': numOfTime,
    };
  }
}