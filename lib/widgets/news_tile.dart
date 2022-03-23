import 'package:finndata_project/models/market_news.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({Key? key, required this.market}) : super(key: key);
  final MarketModel market;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 141,
                width: 141,
                child: Image.network(
                  market.image,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  Text(market.category),
                  // Text(market.headline),
                  Text(market.source),
                ],
              )
            ],
          ),
          Text(market.headline),
          Text(market.summary),
        ],
      ),
    );
  }
}
