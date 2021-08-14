//
//  LanguageManager.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/9/21.
//

import Foundation

class LanguageManager: NSObject {
    
    private static var CurrentLanguageDictionary = [String: String]()
    
    // MARK: Keys for strings in app (unique per language file)
    
    public static let countries =                                                                      "countries"
    public static let select_countries =                                                               "select_countries"
    public static let search_for_countries =                                                           "search_for_countries"
    public static let add =                                                                            "add"
    public static let added =                                                                          "added"
    public static let done =                                                                           "done"
    public static let choose =                                                                         "choose"
    public static let your_selected_countries_are_here =                                               "your_selected_countries_are_here"
    public static let ok =                                                                             "ok"

    static var currentLanguage: Languages = .English
    
    override init() {
        super.init()
        self.configLanguageAssets()
    }
    
    func configLanguageAssets() {
        // Check if there is any saved language and set english as default if there is no saved language
        let savedLanguageValue = UserDefaults.standard.string(forKey: "Language") ?? "English"
        let fileName = "\(savedLanguageValue)"
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, String> {
                    LanguageManager.CurrentLanguageDictionary = jsonResult
                }
            } catch {
                LanguageManager.CurrentLanguageDictionary = [String: String]()
                Logger.printToConsole(error)
                Logger.printToConsole("Error: Could not serialize JSON data from language file \(path)")
            }
        }
    }
    
    /**
        Method will return default value in case of not finding value for key
        Also we will return defaultValue for default language (English) instetad of looking for key pair in dictinary to reach better performance
     */
    static func getStringValue(forKey: String, defaultValue: String) -> String {
        let finalValue = (LanguageManager.currentLanguage == .English) ? defaultValue : LanguageManager.CurrentLanguageDictionary[forKey]
        return (finalValue == nil) ? defaultValue : (finalValue ?? defaultValue)
    }
}

public enum Languages: String {
    case English
    
    func getShortForm() -> String {
        let result: String
        switch self {
        case .English:
            result = "EN"
            return result
        }
    }
}
