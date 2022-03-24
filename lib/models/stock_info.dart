
class StockChange {
  final String symbol;
  final double lastPrice;
  final int timestamp;

  StockChange(this.symbol, this.lastPrice, this.timestamp);

  StockChange.fromJson(Map<String, dynamic> json)
      : symbol = json['s'],
        lastPrice = json['p'],
        timestamp = json['t'];
}

class WSResponse {
  final String type;
  final List<StockChange> stockChanges;

  WSResponse({required this.type, required this.stockChanges});

  factory WSResponse.fromJson(Map<String, dynamic> json) {
    final _type = json['type'] as String;

    List<StockChange> _stockChanges = [];
    if (_type == 'trade') {
      for (var item in json['data']) {
        final stockChange = StockChange.fromJson(item as Map<String, dynamic>);
        _stockChanges.add(stockChange);
      }
    }

    return WSResponse(type: _type, stockChanges: _stockChanges);
  }
}
