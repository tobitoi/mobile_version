import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version/repository/repo.dart';

import 'auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo userRepo;

  AuthenticationBloc({@required this.userRepo})
      : assert(userRepo != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepo.hasToken();
      
      if (hasToken) {
         final data = await userRepo.getuser();
        yield AuthenticationAuthenticated(data.username, data.email, data.avatar);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepo.persistToken(event.token);
      final data = await userRepo.getuser();
      yield AuthenticationAuthenticated(data.username, data.email, data.avatar);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepo.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}