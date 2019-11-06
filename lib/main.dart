import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/bloc/auth/auth.dart';
import 'package:mobile_version/bloc/home/hometobloc.dart';

import 'package:mobile_version/repository/repo.dart';
import 'package:mobile_version/ui/login/loginBarrel.dart';
import 'package:mobile_version/utils/arch_sample_routes.dart';


import 'bloc/item/item.dart';
import 'common/common.dart';
import 'ui/home/home.dart';
import 'ui/item/item.dart';
import 'ui/splash/splash.dart';
import 'utils/utils.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
   final userRepository = UserRepo();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(userRepository: userRepository));
}

class App extends StatelessWidget {
  final UserRepo userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (context) {
            return AuthenticationBloc(
              userRepo: userRepository,
            )..add(AppStarted());
          },
        ),
      ],
      child: MaterialApp(
        title: FlutterBlocLocalizations().appTitle,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FlutterBlocLocalizationsDelegate(),
        ],
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<HomeBloc>(
                        builder: (context) => HomeBloc(visitRepo: VisitRepo())..add(Fetch()),
                      ),
                    ],
                    child: HomePage(),
                  );
                }
                if (state is AuthenticationUnauthenticated) {
                  return LoginPage(userRepository: UserRepo());
                }
                if (state is AuthenticationLoading) {
                  return LoadingIndicator();
                }
                return SplashPage();
              },
            );
          },
          ArchSampleRoutes.item : (context) {
            return BlocProvider<ItemBloc>(
              builder: ( context) => ItemBloc(itemCategoryRepos: ItemCategoryRepos())..add(ItemLoad()),
              child: ItemPage()
            );
          }
        },
      ),
    );
  }
}



 