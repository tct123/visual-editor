// Read EmbedM comm for the whole explanation.
// Data which can be encoded into a Quill document; i.e. it is embeddable.
// EmbeddableObjectM is the data that is held as value of embed node.
// Used for parsing the data in the leaf
class EmbeddableObjectM {
  const EmbeddableObjectM(this.type, this.payload);

  // The type of this object.
  final String type;

  // The data payload of this object.
  final dynamic payload;

  Map<String, dynamic> toJson() {
    return {type: payload};
  }

  // Used for explicit type conversion
  factory EmbeddableObjectM.fromObject(Object? obj) {
    final json = obj as Map<String, dynamic>;

    assert(json.length == 1, 'Embeddable map must only have one key');

    return EmbeddableObjectM(obj.keys.first, obj.values.first);
  }

  factory EmbeddableObjectM.fromMap(Map<String, dynamic> json) {
    assert(json.length == 1, 'Embeddable map must only have one key');

    return EmbeddableObjectM(json.keys.first, json.values.first);
  }
}
