import '../../documents/models/nodes/embed.model.dart';

// Embeds have node, the offset is the position
class EmbedNodeM {
  final int offset;
  final EmbedM embedNode;

  EmbedNodeM(
    this.offset,
    this.embedNode,
  );
}
