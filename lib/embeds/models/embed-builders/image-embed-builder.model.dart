import 'package:flutter/cupertino.dart';

import '../../../controller/controllers/editor-controller.dart';
import '../../../documents/models/attributes/attributes.model.dart';
import '../../../documents/models/nodes/embed.model.dart';
import '../../../shared/utils/platform.utils.dart';
import '../../../shared/utils/string.utils.dart';
import '../../services/image.utils.dart';
import '../../widgets/option-menu-editable-image.dart';
import '../../widgets/option-menu-for-readonly-image.dart';
import '../content-size.model.dart';
import '../embed-builder.model.dart';
import '../embeddable-image.model.dart';

// +++ REVIEW
// Default embed builder for image embeds
class ImageEmbedBuilderM implements EmbedBuilderM {
  const ImageEmbedBuilderM();

  @override
  String get key => EmbeddableImageM.imageKey;

  @override
  Widget build(
    BuildContext context,
    EditorController controller,
    EmbedM embed,
    bool readOnly,
  ) {
    final _imageUtils = ImageUtils();

    late ContentSizeM _imageContentSize;
    late Widget _image;
    final _imageUrl = _imageUtils.standardizeImageUrl(embed.value.payload);
    final _style = embed.style.attributes?['style'];

    if (isMobile() && _style != null) {
      final _attrs = parseKeyValuePairs(
        _style.value.toString(),
        {
          AttributesM.mobileWidth,
          AttributesM.mobileHeight,
          AttributesM.mobileMargin,
          AttributesM.mobileAlignment
        },
      );

      if (_attrs.isNotEmpty) {
        // We force the image to have a certain size, margins or alignments
        assert(
          _attrs[AttributesM.mobileWidth] != null &&
              _attrs[AttributesM.mobileHeight] != null,
          'mobileWidth and mobileHeight must be specified',
        );

        final width = double.parse(_attrs[AttributesM.mobileWidth]!);
        final height = double.parse(_attrs[AttributesM.mobileHeight]!);
        _imageContentSize = ContentSizeM(width, height);

        final padding = _attrs[AttributesM.mobileMargin] == null
            ? 0.0
            : double.parse(_attrs[AttributesM.mobileMargin]!);

        final alignment = getAlignment(_attrs[AttributesM.mobileAlignment]);

        _image = Padding(
          padding: EdgeInsets.all(padding),
          child: _imageUtils.getImageByUrl(
            _imageUrl,
            width: width,
            height: height,
            alignment: alignment,
          ),
        );
      }
    } else {
      // When NO attributes are present we get the content size from the widget itself
      _image = _imageUtils.getImageByUrl(_imageUrl);
      _imageContentSize = ContentSizeM(
        (_image as Image).width,
        _image.height,
      );
    }

    if (!readOnly && isMobile()) {
      return OptionMenuEditableImage(
        controller: controller,
        imageContentSize: _imageContentSize,
        child: _image,
      );
    }

    final _isImageBase64 = _imageUtils.isImageBase64(_imageUrl);

    if (!readOnly || !isMobile() || _isImageBase64) {
      return _image;
    }

    // We provide option menu for mobile platforms excluding base64 images
    return OptionMenuForReadOnlyImage(
      imageUrl: _imageUrl,
      child: _image,
    );
  }
}
