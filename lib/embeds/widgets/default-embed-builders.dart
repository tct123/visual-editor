import '../models/embed-builder.model.dart';
import '../models/embed-builders/image-embed-builder.model.dart';
import '../models/embed-builders/video-embed-builder.model.dart';

// All standard embeds will have a default embed builder that has to be present here.
// For now, image and video are the only standard embeds present in the editor.
const Iterable<EmbedBuilderM> defaultEmbedBuilders = [
  ImageEmbedBuilderM(),
  VideoEmbedBuilderM(),
];
