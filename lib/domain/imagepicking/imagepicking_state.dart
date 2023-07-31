part of '../imagepicking/imagepicking_bloc.dart';

class ImagePickingState {
  String image;
  ImagePickingState({required this.image});
}

class ImagepickingInitial extends ImagePickingState {
  ImagepickingInitial() : super(image: "");
}
