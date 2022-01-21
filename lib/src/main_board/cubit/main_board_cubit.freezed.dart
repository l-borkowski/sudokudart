// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main_board_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MainBoardStateTearOff {
  const _$MainBoardStateTearOff();

  _MainBoardState call(
      {bool isLoading = false, List<List<int>> sudokuList = const []}) {
    return _MainBoardState(
      isLoading: isLoading,
      sudokuList: sudokuList,
    );
  }
}

/// @nodoc
const $MainBoardState = _$MainBoardStateTearOff();

/// @nodoc
mixin _$MainBoardState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<List<int>> get sudokuList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainBoardStateCopyWith<MainBoardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainBoardStateCopyWith<$Res> {
  factory $MainBoardStateCopyWith(
          MainBoardState value, $Res Function(MainBoardState) then) =
      _$MainBoardStateCopyWithImpl<$Res>;
  $Res call({bool isLoading, List<List<int>> sudokuList});
}

/// @nodoc
class _$MainBoardStateCopyWithImpl<$Res>
    implements $MainBoardStateCopyWith<$Res> {
  _$MainBoardStateCopyWithImpl(this._value, this._then);

  final MainBoardState _value;
  // ignore: unused_field
  final $Res Function(MainBoardState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? sudokuList = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      sudokuList: sudokuList == freezed
          ? _value.sudokuList
          : sudokuList // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
    ));
  }
}

/// @nodoc
abstract class _$MainBoardStateCopyWith<$Res>
    implements $MainBoardStateCopyWith<$Res> {
  factory _$MainBoardStateCopyWith(
          _MainBoardState value, $Res Function(_MainBoardState) then) =
      __$MainBoardStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, List<List<int>> sudokuList});
}

/// @nodoc
class __$MainBoardStateCopyWithImpl<$Res>
    extends _$MainBoardStateCopyWithImpl<$Res>
    implements _$MainBoardStateCopyWith<$Res> {
  __$MainBoardStateCopyWithImpl(
      _MainBoardState _value, $Res Function(_MainBoardState) _then)
      : super(_value, (v) => _then(v as _MainBoardState));

  @override
  _MainBoardState get _value => super._value as _MainBoardState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? sudokuList = freezed,
  }) {
    return _then(_MainBoardState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      sudokuList: sudokuList == freezed
          ? _value.sudokuList
          : sudokuList // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
    ));
  }
}

/// @nodoc

class _$_MainBoardState implements _MainBoardState {
  const _$_MainBoardState({this.isLoading = false, this.sudokuList = const []});

  @JsonKey(defaultValue: false)
  @override
  final bool isLoading;
  @JsonKey(defaultValue: const [])
  @override
  final List<List<int>> sudokuList;

  @override
  String toString() {
    return 'MainBoardState(isLoading: $isLoading, sudokuList: $sudokuList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MainBoardState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other.sudokuList, sudokuList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(sudokuList));

  @JsonKey(ignore: true)
  @override
  _$MainBoardStateCopyWith<_MainBoardState> get copyWith =>
      __$MainBoardStateCopyWithImpl<_MainBoardState>(this, _$identity);
}

abstract class _MainBoardState implements MainBoardState {
  const factory _MainBoardState({bool isLoading, List<List<int>> sudokuList}) =
      _$_MainBoardState;

  @override
  bool get isLoading;
  @override
  List<List<int>> get sudokuList;
  @override
  @JsonKey(ignore: true)
  _$MainBoardStateCopyWith<_MainBoardState> get copyWith =>
      throw _privateConstructorUsedError;
}
