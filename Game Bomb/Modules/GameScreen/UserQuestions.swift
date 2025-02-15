import Foundation

final class UserQuestions {
    static let shared = UserQuestions()
    
    private let key = "selectedCategories"
    private init () {}
    
    /// Сохранение выбранных категорий
    func saveCategories(_ categories: [String]) {
        UserDefaults.standard.set(categories, forKey: key)
    }
    
    /// Получение сохранённых категорий
    func getCategories() -> [String] {
        return UserDefaults.standard.stringArray(forKey: key) ?? ["sportQuestions"]
    }
    
    /// Получение вопросов по сохранённым категориям
    func getSelectedQuestions() -> [String] {
        let selectedCategories = getCategories()
        let allQuestions = MockData()
        var result: [String] = []
        
        for category in selectedCategories {
            switch category {
            case "sportQuestions":
                result.append(contentsOf: allQuestions.sportQuestions)
            case "anotherQuestions":
                result.append(contentsOf: allQuestions.anotherQuestions)
            case "lifeQuestions":
                result.append(contentsOf: allQuestions.lifeQuestions)
            case "famousQuestions":
                result.append(contentsOf: allQuestions.famousQuestions)
            case "filmQuestions":
                result.append(contentsOf: allQuestions.filmQuestions)
            case "natureQuestions":
                result.append(contentsOf: allQuestions.natureQuestions)
            default:
                break
            }
        }
        return result
    }
}

//// сохранение
//UserQuestions.shared.saveCategories(["sportQuestions", "filmQuestions"])
//// получение
//let questions = UserQuestions.shared.getSelectedQuestions()
