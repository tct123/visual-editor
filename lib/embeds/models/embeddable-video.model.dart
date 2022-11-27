import '../../documents/models/nodes/embeddable-object.model.dart';

// +++ TODO COMM
class EmbeddableVideoM extends EmbeddableObjectM {
  EmbeddableVideoM(String videoUrl) : super(videoKey, videoUrl);

  static const String videoKey = 'video';
}
