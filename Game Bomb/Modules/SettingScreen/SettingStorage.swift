import Foundation

final class SettingStorage {
    static let shared = SettingStorage()
    
    private init () {}
    
    func save<T>(value: T, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func get<T>(key: String) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }
    
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
