import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_user_id_event.dart';
part 'get_user_id_state.dart';

class GetUserIdBloc extends Bloc<GetUserIdEvent, GetUserIdState> {
  final UserRepository _userRepository;
  GetUserIdBloc(this._userRepository) : super(const GetUserIdState()) {
    on<GetUserIdEvent>((event, emit) {
      final id = _userRepository.getUserId();
      emit(GetUserIdState(userId: id));
    });
  }
}
