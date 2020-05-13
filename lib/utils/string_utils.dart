extension SeparateThousands on String {
  String separateThousands() {
    var text = this.replaceAll(' ', '');
    var length = text.length;
    var subChunks = <String>[];
    String subChunk = '';
    for (int i = length - 1; i >= 0; i--) {
      subChunk = text[i] + subChunk;
      if (subChunk.length % 3 == 0 || i == 0) {
        subChunks.insert(0, subChunk);
        subChunk = '';
      }
    }
    return subChunks.join(' ');
  }
}

extension RemoveTrailingDots on String {
  String removeTrailingDots() =>
      this.replaceAll(' ', '').replaceFirst('.', '#').split('.').join('').replaceFirst('#', '.');
}

extension FormatDouble on String {
  String get formatDouble {
    if (this == null) return '';
    String text = this.removeTrailingDots();
    if (text[0] == '.') text = '0' + text;
    var chunks = text.split('.');
    chunks[0] = chunks[0].separateThousands();
    if (chunks.length > 1) {
      var trailingLength = chunks[1].length;
      chunks[1] = chunks[1].substring(0, trailingLength >= 2 ? 2 : trailingLength);
      if (chunks[1].endsWith('0')) chunks[1] = chunks[1][0];
    }
    return chunks.join('.');
  }
}

extension FormatInt on String {
  String get formatInt {
    String result = this.formatDouble;
    return result.split('.')[0];
  }
}

extension RemoveSpaces on String {
  String get removeSpaces => this.replaceAll(' ', '');
}

extension EmptyIfZero on String {
  String get emptyIfZero {
    if (this == null) return '';
    if (this.endsWith('0')) {
      var chunks = this.split('.');
      var result = int.tryParse(chunks[0]);
      return result == 0 ? '' : this;
    } else {
      return this;
    }
  }
}

extension NoDotZero on String {
  String get noDotZero {
    if (this == null) return '';
    var chunks = this.split('.');
    if (chunks.length > 1) {
      var result = int.tryParse(chunks[1]);
      return result == 0 ? chunks[0] : this;
    } else
      return this;
  }
}
