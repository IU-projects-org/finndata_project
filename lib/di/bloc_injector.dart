import 'package:injectable/injectable.dart';
import 'package:injector/injector.dart';

import '../main.dart';
import 'bloc_injector.inject.dart' as g;
import 'bloc_module.dart';

@Injector()
abstract class BlocInjector {
  @provide
  MyApp get app;

  @provide
  BlocModule get blocModule;

  static final create = g.BlocInjector$Injector.create;
}
