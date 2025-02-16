import Foundation

final class UserQuestionsService {
    static let shared = UserQuestionsService()
    
    private let key = "selectedCategories"
    private init () {}
    
    /// Сохранение выбранных категорий
    func appendCategory(_ label: String) {
        if checkCategoryExists(category: label) {
            return
        }
        
        var currentSelectedCategories = getSelectedCategoriesFromUserDefaults()
        currentSelectedCategories.append(label)
        UserDefaults.standard.set(currentSelectedCategories, forKey: key)
    }
    
    /// Удаление категории
    func removeCategory(_ label: String) {
        let filteredCategories = getSelectedCategoriesFromUserDefaults().filter({ $0 != label }).map(\.self)
        
        UserDefaults.standard.set(filteredCategories, forKey: key)
    }
    
    /// Проверить выбрана ли категория
    func checkCategoryExists(category: String) -> Bool {
        return getSelectedCategoriesFromUserDefaults().contains(category)
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
    
    private func getSelectedCategoriesFromUserDefaults() -> [String] {
        return UserDefaults.standard.stringArray(forKey: key) ?? []
    }
}

//// сохранение
//UserQuestionsService.shared.saveCategories(["sportQuestions", "filmQuestions"])
//// получение
//let questions = UserQuestions.shared.getSelectedQuestions()
