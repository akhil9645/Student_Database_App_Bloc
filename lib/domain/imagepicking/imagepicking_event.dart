part of '../imagepicking/imagepicking_bloc.dart';

@immutable
abstract class ImagepickingEvent {}

class ChangeImg extends ImagepickingEvent {
  final String image;
  ChangeImg({required this.image});
}
