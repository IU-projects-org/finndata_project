import 'package:finndata_project/bloc/finn/api_state.dart';
import 'package:finndata_project/repos/finn_api_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/api_result.dart';
import '../../models/market_news.dart';
import '../../models/network_exceptions.dart';

class APICubit extends Cubit<APIState<List<MarketModel>>> {
  APICubit({required this.apiRepository}) : super(const Idle());
  final FinnHubAPIRepository apiRepository;

  Future<void> loadNews() async {
    emit(const APIState.loading());
    final ApiResult<List<MarketModel>> apiResult =
        await apiRepository.getMarketNews();
    apiResult.when(success: (List<MarketModel> data) {
      emit(APIState.data(data: data));
    }, failure: (NetworkExceptions error) {
      emit(APIState.error(error: error));
    });
  }
}
