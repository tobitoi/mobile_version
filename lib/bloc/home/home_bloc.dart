import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/repository/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hometobloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VisitRepo visitRepo;

  HomeBloc({@required this.visitRepo});

  @override
  HomeState get initialState => HomeLoading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is Fetch) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String username = preferences.getString("username");
      yield LoginSuccess(username: username);
      yield* _mapLoadHomeToState();
    } else if (event is AddVisit) {
      yield* _mapAddVisitToState();
    }
  }

  Stream<HomeState> _mapLoadHomeToState() async* {
    try {
      final Visit visitData = await this.visitRepo.getVisitRepo();
      yield HomeLoaded(visit: visitData);
    } catch (error) {
      yield HomeNotLoaded(error: error.toString());
    }
  }

  Stream<HomeState> _mapAddVisitToState() async* {
    try {
      await this.visitRepo.addVisitRepo();
    } catch (error) {
      yield HomeNotLoaded(error: error.toString());
    }
  }
}
