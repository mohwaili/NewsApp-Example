// swiftlint:disable superfluous_disable_command
// swiftlint:disable trailing_newline

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable identifier_name line_length type_body_length
public class Localized {
    public static let debugShowLocalizeKeys = "Show Lokalize Keys"

  // Articles
  public static var articlesTitle: String {
	return Localized.tr("Localizable", "articles_title")
  }
  // Author: %@
  public static func authorTitle(_ p1: String) -> String {
        return Localized.tr("Localizable", "author_title", p1)
      }
  // Date: %@
  public static func dateTitle(_ p1: String) -> String {
        return Localized.tr("Localizable", "date_title", p1)
      }
  // Headlines
  public static var headlinesTitle: String {
	return Localized.tr("Localizable", "headlines_title")
  }
  // Open Article
  public static var openArticleButtonTitle: String {
	return Localized.tr("Localizable", "open_article_button_title")
  }
  // Retry
  public static var retryTitle: String {
	return Localized.tr("Localizable", "retry_title")
  }
  // Search for...
  public static var searchFieldPlaceholder: String {
	return Localized.tr("Localizable", "searchField_placeholder")
  }
}
// swiftlint:enable identifier_name line_length type_body_length

extension Localized {
    public static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        if UserDefaults.standard.string(forKey: "debugCopyKey") == Localized.debugShowLocalizeKeys {
            return key
        } else {
            let localizedBundle = self.localizedBundle()
            let locale = Locale.current
            let format = NSLocalizedString(key, tableName: table, bundle: localizedBundle, comment: "")
            return String(format: format,
                          locale: locale,
                          arguments: args)
        }
    }

    private static func localizedBundle() -> Bundle {
        let bundle = Bundle(for: self)
        let bundlePath = bundle.path(forResource: Locale.current.languageCode, ofType: "lproj")
        if let localizedPath = bundlePath, let localizedBundle = Bundle(path: localizedPath) {
            return localizedBundle
        }
        if let bundlePath = bundle.path(forResource: "Base", ofType: "lproj"),
            let baseBundle = Bundle(path: bundlePath) {
                return baseBundle
        }
        fatalError("lproj files not found on project directory.")
    }
}

