import 'package:spacex_app/model/spacex_model.dart';
import 'package:spacex_app/views/homepage/service/homepage_service.dart';

class HomePageRepository {
  final SpaceXService _service = SpaceXService();

  Future<SpaceX> fetchdata() async {
    return await _service.fetchdata();
  }
}
