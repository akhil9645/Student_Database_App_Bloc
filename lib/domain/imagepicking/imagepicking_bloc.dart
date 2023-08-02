import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'imagepicking_event.dart';
part 'imagepicking_state.dart';

class ImagePickingBloc extends Bloc<ImagePickingEvent, ImagePickingState> {
  ImagePickingBloc() : super(ImagePickingInitial()) {
    on<ChangeImg>((event, emit) {
      return emit(ImagePickingState(image: event.image));
    });
  }
}
