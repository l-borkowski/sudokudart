import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sudokudart/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
)
void configureDependencies() => $initGetIt(getIt);
