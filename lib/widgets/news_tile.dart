import 'package:finndata_project/models/market_news.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({Key? key, required this.market}) : super(key: key);
  final MarketModel market;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              // height: 141,
              width: 120,
              child: Image.network(
                market.image,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
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
                Text(market.category,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline3?.color)),
                Text(market.source,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline3?.color)),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Summary',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headline3?.color),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            market.headline,
            style:
                TextStyle(color: Theme.of(context).textTheme.headline3?.color),
          ),
        ),
      ],
    );
  }
}
