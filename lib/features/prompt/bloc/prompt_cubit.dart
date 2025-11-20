import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'prompt_cubit.freezed.dart';

@freezed
class PromptState with _$PromptState {
  const factory PromptState({@Default('') String value}) = _PromptState;

  const PromptState._();

  bool get isValid => value.trim().isNotEmpty;
}

@injectable
class PromptCubit extends Cubit<PromptState> {
  PromptCubit() : super(const PromptState());

  void updatePrompt(String value) {
    emit(state.copyWith(value: value));
  }
}
