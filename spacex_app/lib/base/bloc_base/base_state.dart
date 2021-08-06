import 'package:flutter/widgets.dart';
import 'package:spacex_app/model/spacex_model.dart';

abstract class SpaceXState {}

class SpaceXInitial extends SpaceXState {}

class SpaceXLoading extends SpaceXState {}

class SpaceXLoaded extends SpaceXState {
  final SpaceX spaceX;
  SpaceXLoaded(this.spaceX);
}

class SpaceXError extends SpaceXState {}
