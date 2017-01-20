public extension NSLocale {

  public func currencySymbolsForCurrencyCode(_ code: String) ->  (localeIdentifier: String, symbol: String)
  return NSLocale
    .availableLocaleIdentifiers
    .map { NSLocale(localeIdentifier: $0) }
    .filter {
      if let code = $0.object(forKey: .currencyCode) as? String {
        return code == currencyCode
      } else {
        return false
      }
    }
    .map {
      ($0.localeIdentifier, $0.object(forKey: .currencySymbol)!)
  }
}