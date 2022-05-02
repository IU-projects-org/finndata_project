import 'package:flutter/material.dart';

import '../repos/finn_api_repo.dart';
import '../widgets/news_tile.dart';

class MarketNews extends StatefulWidget {
  const MarketNews({Key? key}) : super(key: key);

  @override
  _MarketNewsState createState() => _MarketNewsState();
}

class _MarketNewsState extends State<MarketNews> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: finnApiRepo.getMarketNews(),
        builder: (context, AsyncSnapshot<List<dynamic>> news) {
          if (!news.hasData &&
              news.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          }
          if (news.hasError) {
            return Center(child: Text(news.error.toString()));
          }
          return ListView.builder(
            itemCount: (news.data)!.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3D3D3),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(),
                  ),
                  padding: const EdgeInsets.all(13),
                  child: NewsTile(market: news.data![index]));
            },
          );
        },
      ),
    );
  }
}
