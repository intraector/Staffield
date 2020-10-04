extension SeparateThousands on String {
  String get separateThousands {
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
    return subChunks.join(String.fromCharCode(0x00A0));
  }
}

extension RemoveTrailingDots on String {
  String get removeTrailingDots =>
      this.removeSpaces.replaceFirst('.', '#').split('.').join('').replaceFirst('#', '.');
}

extension RemoveSpaces on String {
  String get removeSpaces => this.replaceAll(' ', '').replaceAll(String.fromCharCode(0x00A0), '');
}

extension EmptyIfZero on String {
  String get emptyIfZero {
    if (this == null) return '';
    if (this.endsWith('0')) {
      var chunks = this.split('.');
      var result = int.tryParse(chunks.first);
      return result == 0 ? '' : this;
    } else {
      return this;
    }
  }
}

extension NoDotZero on String {
  ///cuts first occurence of ".00" and everything after it
  String get noDotZero {
    if (this == null) return '';
    var chunks = this.split('.');
    if (chunks.length > 1) {
      var result = int.tryParse(chunks[1]);
      return result == 0 ? chunks.first : this;
    } else
      return this;
  }
}

extension CutTrailingSymbols on String {
  String limitSymbols(int symbols) =>
      this.substring(0, this.length >= symbols ? symbols : this.length);
}

extension FormatAsCurrency on String {
  ///input is a String or a num, otherwise returns empty String
  String formatAsCurrency({int decimals = 0, String ifNullReturn}) {
    String output;
    if (this == null) return ifNullReturn;
    if (this.isEmpty) return '';
    output = this.removeTrailingDots;
    if (output[0] == '.') output = '0' + output;
    var chunks = output.split('.');
    chunks.first = chunks.first.separateThousands;
    if (decimals == 0 || chunks.length == 1) return chunks.first;
    chunks[1] = chunks[1].limitSymbols(decimals);
    if (chunks[1].endsWith('0')) chunks[1] = chunks[1][0];
    return chunks.join('.');
  }
}
