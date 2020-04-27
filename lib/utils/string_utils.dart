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

extension FormatCurrency on String {
  String formatCurrency() {
    if (this == null) return '';
    String text = this.removeTrailingDots();
    if (text[0] == '.') text = '0' + text;
    var chunks = text.split('.');
    chunks[0] = chunks[0].separateThousands();
    if (chunks.length > 1) {
      var trailingLength = chunks[1].length;
      chunks[1] = chunks[1].substring(0, trailingLength >= 2 ? 2 : trailingLength);
    }
    return chunks.join('.');
  }
}

extension FormatCurrencyDecimal on String {
  String formatCurrencyDecimal() {
    String result = this.formatCurrency();
    return result.split('.')[0];
  }
}

extension RemoveSpaces on String {
  String removeSpaces() => this.replaceAll(' ', '');
}
