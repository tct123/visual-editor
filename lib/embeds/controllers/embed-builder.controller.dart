import '../../documents/models/nodes/embed.model.dart';
import '../models/embed-builder.model.dart';
import '../models/embed-builder.typedef.dart';

// Handles builder selection based on embed types
// This is a controller because it keeps internal state of the available embed builders
class EmbedBuilderController {
  late final Iterable<EmbedBuilderM> _builders;

  // Set the controller's embed builders from the state of the editor config
  void setEmbedBuilders({required Iterable<EmbedBuilderM> builders}) =>
      _builders = builders;

  EmbedsBuilder getBuilderByEmbed(EmbedM embed) {
    // Selects the builder based on the type of the embed
    // Compares the key of the embed with the keys of the submitted embed builders
    for (final builder in _builders) {
      if (builder.key == embed.value.type) {
        return builder.build;
      }
    }

    // When no builders are found
    throw UnimplementedError(
      'Embeddable type "${embed.value.type}" is not supported by supplied '
      'embed builders. You must pass your own builder function to '
      'embedBuilders property of VisualEditor.',
    );
  }
}
