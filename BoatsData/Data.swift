//
//  Data.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public let DataReloadNotification: String = "DataReloadNotification"
public let DataReloadCompletion: String = "DataReloadCompletion"

public final class Data {
    private let URL: Foundation.URL = Foundation.URL(string: "https://toddheasley.github.io/boats/data.json")!
    public private(set) var name: String = ""
    public private(set) var description: String = ""
    public private(set) var providers: [Provider] = []
    
    public func provider(code: String) -> Provider? {
        for provider in providers {
            if (code == provider.code) {
                return provider
            }
        }
        return nil
    }
    
    public func reloadData(completion: ((Bool) -> Void)? = nil) {
        URLSession.shared.dataTask(with: URL) { data, response, error in
            guard let data = data, let JSON = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()), self.refresh(JSON: JSON) else {
                DispatchQueue.main.async {
                    completion?(false)
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: DataReloadNotification), object: self, userInfo: [
                    DataReloadCompletion: false
                ])
                return
            }
            UserDefaults.standard.data = data
            DispatchQueue.main.async{
                completion?(true)
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: DataReloadNotification), object: self, userInfo: [
                DataReloadCompletion: true
            ])
        }.resume()
    }
    
    public init() {
        if let data = UserDefaults.standard.data, let JSON = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) {
            let _ = refresh(JSON: JSON)
        }
    }
}

extension Data: JSONEncoding, JSONDecoding {
    private func refresh(JSON: AnyObject) -> Bool {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let description = JSON["description"] as? String, let providers = JSON["providers"] as? [AnyObject], let zone = JSON["zone"] as? String, let timeZone = TimeZone(name: zone) else {
            return false
        }
        Date.formatter.timeZone = timeZone
        self.name = name
        self.description = description
        self.providers = []
        for providerJSON in providers {
            guard let provider = Provider(JSON: providerJSON) else {
                return false
            }
            self.providers.append(provider)
        }
        return true
    }
    
    var JSON: AnyObject {
        return [
            "name": name,
            "description": description,
            "providers": providers.map { $0.JSON },
            "zone": Date.formatter.timeZone.name
        ]
    }
    
    convenience init?(JSON: AnyObject) {
        self.init()
        if (!refresh(JSON: JSON)) {
            return nil
        }
    }
}

extension UserDefaults {
    var data: Foundation.Data? {
        set {
            set(newValue, forKey: "data")
            synchronize()
        }
        get {
            return object(forKey: "data") as? Foundation.Data
        }
    }
}
