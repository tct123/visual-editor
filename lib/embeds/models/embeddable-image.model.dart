import '../../documents/models/nodes/embeddable-object.model.dart';

// +++ TODO COMM
class EmbeddableImageM extends EmbeddableObjectM {
  EmbeddableImageM(String imageUrl) : super(imageKey, imageUrl);

  static const String imageKey = 'image';
}