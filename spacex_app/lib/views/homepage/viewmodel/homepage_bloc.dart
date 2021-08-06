import 'package:bloc/bloc.dart';
import 'package:spacex_app/base/bloc_base/base_event.dart';
import 'package:spacex_app/base/bloc_base/base_state.dart';
import 'package:spacex_app/model/spacex_model.dart';
import 'package:spacex_app/views/homepage/model/homepage_model.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  final HomePageRepository _repository;

  SpaceXBloc(this._repository) : super(SpaceXInitial());

  @override
  Stream<SpaceXState> mapEventToState(SpaceXEvent event) async* {
    if (event is SpaceXFetchEvent) {
      yield SpaceXLoading();
      try {
        final SpaceX spaceX = await _repository.fetchdata();
        yield SpaceXLoaded(spaceX);
      } catch (e) {
        yield SpaceXError();
      }
    }
  }
}
