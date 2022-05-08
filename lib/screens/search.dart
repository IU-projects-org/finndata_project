import 'dart:convert';
import 'dart:math';

import 'package:finndata_project/constants/app_constants.dart';
import 'package:finndata_project/screens/stock_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Localization/app_localizations.dart';
import '../bloc/finn/api_cubit.dart';
import '../bloc/finn/api_state.dart';
import '../models/network_exceptions.dart';
import '../models/symbol_result.dart';
import '../utils/local_storage_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<SymbolResultModel>? symbolStock;
  @override
  Widget build(BuildContext context) {
    final labels = jsonDecode(
        jsonEncode(AppLocalizations.of(context)!.translate('search_screen')));
    return Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await BlocProvider.of<APICubit>(context)
                          .loadSearchResults(_controller.text);
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Text(
                      labels['search_button'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              BlocBuilder<APICubit, APIState>(
                  builder: (BuildContext context, APIState state) {
                return state.when(loading: () {
                  return Center(
                      child: CircularProgressIndicator(
                          color:
                              Theme.of(context).progressIndicatorTheme.color));
                }, idle: () {
                  return Container();
                }, data: (symbolStock) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${labels['results']}: ${min(symbolStock.length as int, 100)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                      ListView.builder(
                          itemCount: symbolStock
                              .sublist(0, min(symbolStock.length as int, 100))
                              .length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Theme.of(context).cardColor,
                              child: ListTile(
                                  title: Text(
                                    labels['search_tile']['description'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            ?.color),
                                  ),
                                  subtitle: Text(
                                    symbolStock[index].description,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            ?.color),
                                    key: favouriteDescriptionKey,
                                  ),
                                  trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            key: addFavouriteButtonKey,
                                            onPressed: () {
                                              _updateStockState(
                                                  symbolStock[index]);
                                            },
                                            icon: Icon(
                                                myStocks
                                                        .map(
                                                          (e) => e.symbol,
                                                        )
                                                        .contains(
                                                            symbolStock[index]
                                                                .symbol)
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_border,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color)),
                                        Icon(Icons.arrow_forward,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color)
                                      ]),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => StockInfoScreen(
                                          title: symbolStock[index].symbol,
                                          symbolQuery:
                                              symbolStock[index].symbol),
                                    ));
                                  }),
                            );
                          }),
                    ],
                  );
                }, error: (NetworkExceptions error) {
                  return Center(
                      child: Text(NetworkExceptions.getErrorMessage(error)));
                });
              }),
            ],
          ),
        ));
  }

  void _updateStockState(SymbolResultModel stock) {
    if (myStocks.map((e) => e.symbol).contains(stock.symbol)) {
      setState(() {
        myStocks.remove(stock);
      });
      StockSubscriptionsStorage().removeSubscription(stock);
    } else {
      setState(() {
        myStocks.add(stock);
      });
      StockSubscriptionsStorage().addSubscription(stock);
    }
  }
}
