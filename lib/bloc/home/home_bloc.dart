import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/response/response..dart';
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
    } else if (event is FilterBongkarMuat) {
      yield* _mapBongkarMuatToState(event);
    }
  }

  Stream<HomeState> _mapLoadHomeToState() async* {
    try {
      final Visit visitData = await this.visitRepo.getVisitRepo();
      final BongkarMuatResponse bongkarMuatData =
          await this.visitRepo.getBongkarMuatRepo();
      yield HomeLoaded(visit: visitData, bongkarMuat: bongkarMuatData);
    } catch (error) {
      yield HomeNotLoaded(error: error.toString());
    }
  }

  Stream<HomeState> _mapAddVisitToState() async* {
    try {
      await this.visitRepo.addVisitRepo();
      yield* _mapLoadHomeToState();
    } catch (error) {
      yield HomeNotLoaded(error: error.toString());
    }
  }

  Stream<HomeState> _mapBongkarMuatToState(FilterBongkarMuat event) async* {
    try {
      final Visit visitData = await this.visitRepo.getVisitRepo();
      final bongkarmuat = await this
          .visitRepo
          .getBongkarMuatRepoFilter(event.startDate, event.endDate);
      yield HomeLoaded(visit: visitData, bongkarMuat: bongkarmuat);
    } catch (error) {
      yield HomeNotLoaded(error: error.toString());
    }
  }
}
