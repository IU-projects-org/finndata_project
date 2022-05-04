import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/network_exceptions.dart';

part 'api_state.freezed.dart';

@freezed
abstract class APIState<T> with _$APIState<T> {
  const factory APIState.idle() = Idle<T>;

  const factory APIState.loading() = Loading<T>;

  const factory APIState.data({required T data}) = Data<T>;

  const factory APIState.error({required NetworkExceptions error}) = Error<T>;
}
