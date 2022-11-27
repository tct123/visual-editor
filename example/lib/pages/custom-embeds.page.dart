import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visual_editor/embeds/widgets/default-embed-builders.dart';
import 'package:visual_editor/visual-editor.dart';

import '../models/custom-widget-embed-builder.model.dart';
import '../models/embeddable-custom-widget.model.dart';
import '../widgets/demo-page-scaffold.dart';

class CustomEmbedsPage extends StatefulWidget {
  const CustomEmbedsPage({Key? key}) : super(key: key);

  @override
  State<CustomEmbedsPage> createState() => _CustomEmbedsPageState();
}

class _CustomEmbedsPageState extends State<CustomEmbedsPage> {
  late EditorController _controller;
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _setupEditorController();
    _loadDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _scaffold(
        children: [
          _editor(),
          _toolbar(),
        ],
      );

  Widget _toolbar() => EditorToolbar.basic(
        controller: _controller,
        customIcons: [
          _insertEmbed(),
        ],
      );

  // Button used to demo custom embed insertion
  EditorCustomButtonM _insertEmbed() => EditorCustomButtonM(
        icon: Icons.star,
        onTap: () {
          final embed = EmbeddableCustomWidgetM();

          _controller.document.insert(
            _controller.selection.start,
            embed,
          );

          // +++ REMOVE
          print('+++ doc ${_controller.document.toDelta().toJson()}');
        },
      );

  Widget _scaffold({required List<Widget> children}) => DemoPageScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      );

  Widget _editor() => Expanded(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: VisualEditor(
              controller: _controller,
              scrollController: _scrollController,
              focusNode: _focusNode,
              config: EditorConfigM(
                placeholder: 'Enter text',
                embedBuilders: [
                  ...defaultEmbedBuilders,
                  CustomWidgetEmbedBuilderM(),
                ],
              ),
            ),
          ),
        ),
      );

  // === UTILS ===

  void _setupEditorController() {
    _controller = EditorController(
      document: DocumentM.fromJson(
        jsonDecode(LOREM_LIPSUM_DOC_JSON),
      ),
    );
  }

  Future<void> _loadDocument() async {
    final doc = await rootBundle.loadString(
      'assets/docs/custom-embeds.json',
    );
    final delta = DocumentM.fromJson(jsonDecode(doc)).toDelta();

    _controller.update(
      delta,

      // Prevents the insertion of the caret if the editor is not focused
      ignoreFocus: true,
    );
  }
}
