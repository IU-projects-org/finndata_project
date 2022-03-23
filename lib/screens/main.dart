import 'package:finndata_project/repos/finn_api_repo.dart';
import 'package:flutter/material.dart';

import '../models/market_news.dart';
import '../widgets/news_tile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMarketNews(),
      builder: (context, AsyncSnapshot<List<dynamic>> news) {
        if (!news.hasData && news.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: Colors.black,
          );
        }
        if (news.hasError) {
          return Center(child: Text(news.error.toString()));
        }
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: (news.data)!.length,
          itemBuilder: (context, index) {
            return NewsTile(market: news.data![index]);
          },
        );
      },
    );
  }

  Future<List<MarketModel>> getMarketNews() async {
    var results = await finnApiRepo.fetchMarketNews('general') as List<dynamic>;
    List<MarketModel> news = results
        .map((value) => MarketModel.fromJson(value as Map<String, dynamic>))
        .toList();
    return news;
  }
}
