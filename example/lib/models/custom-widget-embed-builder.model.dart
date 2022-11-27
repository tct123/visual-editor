import 'package:flutter/material.dart';
import 'package:visual_editor/controller/controllers/editor-controller.dart';
import 'package:visual_editor/documents/models/nodes/embed.model.dart';
import 'package:visual_editor/embeds/models/embed-builder.model.dart';

// Widget created for demo purposes, "key" has to match the value of the key
// from the delta doc:
//  {
//     "insert": {
//       "customWidget": {
//         "value": "NaN"
//       }
//     }
//  }
// Note! Depending on the complexity of the builder some params may not be used
// i.e. controller, node, readOnly; However they cannot be removed from the function signature
// due to the need to implement the EmbedBuilderM interface.
class CustomWidgetEmbedBuilderM implements EmbedBuilderM {
  const CustomWidgetEmbedBuilderM();

  @override
  final String key = 'customWidget';

  @override
  Widget build(
    BuildContext context,
    EditorController controller,
    EmbedM node,
    bool readOnly,
  ) =>
      Container(
        height: 100,
        width: 300,
        color: Colors.amber,
        child: Center(
          child: Text(
            'Test demo custom embed',
          ),
        ),
      );
}
