import 'dart:math';

import '../../controller/controllers/editor-controller.dart';
import '../../documents/models/nodes/embed.model.dart';
import '../models/embed-node.model.dart';

class EmbedUtils {
  static final _instance = EmbedUtils._privateConstructor();

  factory EmbedUtils() => _instance;

  EmbedUtils._privateConstructor();

  EmbedNodeM getEmbedNode(EditorController controller, int offset) {
    var offset = controller.selection.start;
    var embedNode = controller.queryNode(offset);

    if (embedNode == null || !(embedNode is EmbedM)) {
      offset = max(0, offset - 1);
      embedNode = controller.queryNode(offset);
    }

    if (embedNode != null && embedNode is EmbedM) {
      return EmbedNodeM(offset, embedNode);
    }

    return throw 'Embed node not found by offset $offset';
  }
}
