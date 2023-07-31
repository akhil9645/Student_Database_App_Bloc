import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'imagepicking_event.dart';
part 'imagepicking_state.dart';

class ImagepickingBloc extends Bloc<ImagepickingEvent, ImagePickingState> {
  ImagepickingBloc() : super(ImagepickingInitial()) {
    on<ChangeImg>((event, emit) {
      return emit(ImagePickingState(image: event.image));
    });
  }
}
