import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef BlocBuilderCondition<STATE> = bool Function(STATE current);
typedef BlocListenerType<STATE> = void Function(
    STATE current, BuildContext context);

bool defaultBuildWhen<STATE>(STATE s) => true;

void useCubitListener<BLOC extends Cubit, STATE>(
  Cubit<STATE> bloc,
  BlocListenerType<STATE> listener, {
  BlocBuilderCondition<STATE>? listenWhen,
}) {
  final context = useContext();
  final listenWhenConditioner = listenWhen ?? defaultBuildWhen;
  useMemoized(() {
    final stream = bloc.stream
        .where(listenWhenConditioner)
        .listen((state) => listener(state, context));
    return stream.cancel;
  }, [bloc]);
}
