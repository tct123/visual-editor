import 'package:visual_editor/documents/models/nodes/embeddable-object.model.dart';

// the Delta json customWidgetKey has the match the CustomWidgetEmbedBuilderM key
class EmbeddableCustomWidgetM extends EmbeddableObjectM {
  EmbeddableCustomWidgetM(): super(customWidgetKey, '');

  static const String customWidgetKey = 'customWidget';
}