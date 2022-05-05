import 'dart:math';

import 'package:finndata_project/constants/app_constants.dart';
import 'package:finndata_project/screens/stock_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/finn/api.dart';
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
  void initState() {
    BlocProvider.of<APICubit>(context).loadSearchResults('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
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
                  return const Center(child: CircularProgressIndicator());
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
                              'Results: ${min(symbolStock.length as int, 100)}',
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
                            child: ListTile(
                              title: const Text(
                                'Description',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(symbolStock[index].description),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _updateStockState(symbolStock[index]);
                                        },
                                        icon: Icon(myStocks
                                                .map((e) => e.symbol)
                                                .contains(
                                                    symbolStock[index].symbol)
                                            ? Icons.bookmark
                                            : Icons.bookmark_border)),
                                    const Icon(Icons.arrow_forward)
                                  ]),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StockInfoScreen(
                                        title: symbolStock[index].symbol,
                                        symbolQuery: symbolStock[index].symbol),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
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
