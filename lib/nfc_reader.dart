class NfcReader {
  Stream<String> get onTagDiscovered {
    return Stream.value('https://example.com');
  }
}
