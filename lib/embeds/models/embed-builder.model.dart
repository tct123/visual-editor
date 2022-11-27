import 'package:flutter/material.dart';

import '../../controller/controllers/editor-controller.dart';
import '../../documents/models/nodes/embed.model.dart';

// Key is the type of embed i.e. image, video, custom
// +++ REVIEW COMM
abstract class EmbedBuilderM {
  String get key;

  Widget build(
    BuildContext context,
    EditorController controller,
    EmbedM embed,
    bool readOnly,
  );
}
