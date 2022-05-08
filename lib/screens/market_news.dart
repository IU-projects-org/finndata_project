import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/finn/api_cubit.dart';
import '../bloc/finn/api_state.dart';
import '../models/network_exceptions.dart';
import '../widgets/news_tile.dart';

class MarketNews extends StatefulWidget {
  const MarketNews({Key? key}) : super(key: key);

  @override
  _MarketNewsState createState() => _MarketNewsState();
}

class _MarketNewsState extends State<MarketNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<APICubit, APIState>(
        builder: (BuildContext context, APIState state) {
          return state.when(
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            idle: () {
              return Container();
            },
            data: (news) {
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        border: Border.all(),
                      ),
                      padding: const EdgeInsets.all(13),
                      child: NewsTile(market: news[index]));
                },
              );
            },
            error: (NetworkExceptions error) {
              return Center(
                  child: Text(NetworkExceptions.getErrorMessage(error)));
            },
          );
        },
      ),
    );
  }
}
