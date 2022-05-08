import 'dart:convert';

import 'package:flutter/material.dart';

import '../Localization/app_localizations.dart';
import '../constants/app_constants.dart';
import 'stock_info.dart';

class MyStocksList extends StatelessWidget {
  const MyStocksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = jsonDecode(jsonEncode(
        AppLocalizations.of(context)!.translate('saved_stocks_screen')));
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${labels['results_label']}: ${myStocks.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
          ListView.builder(
            itemCount: myStocks.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    labels['details_tile']['description'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    myStocks[index].description,
                    key: favouriteDescriptionKey,
                  ),
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [Icon(Icons.arrow_forward)]),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StockInfoScreen(
                            title: myStocks[index].symbol,
                            symbolQuery: myStocks[index].symbol),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
