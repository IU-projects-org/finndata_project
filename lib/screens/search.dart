import 'package:finndata_project/repos/finn_api_repo.dart';
import 'package:finndata_project/screens/stock_info.dart';
import 'package:flutter/material.dart';

import '../models/symbol_result.dart';

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
                      await getQueryStocks(_controller.text);
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                  ),
                ],
              ),
              symbolStock != null
                  ? Container(
                      padding: const EdgeInsets.all(13),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Results: ${symbolStock!.length}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                  : Wrap(),
              symbolStock != null
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: symbolStock!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          title: const Text(
                            "Description",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(symbolStock![index].description),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => StockInfoScreen(
                                    title: symbolStock![index].symbol,
                                    symbolQuery: symbolStock![index].symbol),
                              ),
                            );
                          },
                        ));
                      },
                    )
                  : Wrap(),
            ],
          ),
        ));
  }

  getQueryStocks(String query) async {
    var results = await finnApiRepo.searchQuery(query);
    List<SymbolResultModel> resultModel = results
        .map((value) =>
            SymbolResultModel.fromJson(value as Map<String, dynamic>))
        .toList();
    setState(() {
      symbolStock = resultModel;
    });
    // return result;
  }
}
