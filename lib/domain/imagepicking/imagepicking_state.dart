part of '../imagepicking/imagepicking_bloc.dart';

class ImagePickingState {
  String image;
  ImagePickingState({required this.image});
}

class ImagePickingInitial extends ImagePickingState {
  ImagePickingInitial() : super(image: "");
}
