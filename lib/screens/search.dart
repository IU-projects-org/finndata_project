import 'dart:math';

import 'package:finndata_project/screens/stock_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/finn/api.dart';
import '../models/network_exceptions.dart';
import '../models/symbol_result.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<SymbolResultModel>? symbolStock;
  String query = '';

  @override
  void initState() {
    BlocProvider.of<APICubit>(context).loadSearchResults(query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
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
                          .loadSearchResults(query);
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 13,
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
                  return ListView.builder(
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
                            'Description',
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
                          ),
                          trailing: Icon(Icons.arrow_forward,
                              color: Theme.of(context).iconTheme.color),
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
}
