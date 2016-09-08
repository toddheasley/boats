//
//  Data.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

public let DataReloadNotification: String = "DataReloadNotification"

public struct Data {
    public fileprivate(set) var name: String = ""
    public fileprivate(set) var description: String = ""
    public fileprivate(set) var providers: [Provider] = []
    
    public var routes: [Route] {
        return providers.flatMap { $0.routes }
    }
    
    public func provider(route: Route) -> Provider? {
        for provider in providers {
            if let _ = provider.route(code: route.code) {
                return provider
            }
        }
        return nil
    }
    
    public func provider(code: String) -> Provider? {
        for provider in providers {
            if code == provider.code {
                return provider
            }
        }
        return nil
    }
}

extension Data: JSONEncoding, JSONDecoding {
    var JSON: Any {
        return [
            "name": name,
            "description": description,
            "providers": providers.map { $0.JSON },
            "zone": Date.formatter.timeZone.identifier
        ]
    }
    
    init?(JSON: Any) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let description = JSON["description"] as? String, let providers = JSON["providers"] as? [AnyObject], let zone = JSON["zone"] as? String, let timeZone = TimeZone(identifier: zone) else {
            return nil
        }
        Date.formatter.timeZone = timeZone
        self.name = name
        self.description = description
        self.providers = []
        for providerJSON in providers {
            guard let provider = Provider(JSON: providerJSON) else {
                return nil
            }
            self.providers.append(provider)
        }
    }
}

extension Data {
    private static let URL: Foundation.URL = Foundation.URL(string: "https://toddheasley.github.io/boats/data.json")!
    private(set) public static var shared: Data = Data(fromDefaults: true)
    
    public static func refresh(completion: ((Bool) -> Void)? = nil) {
        URLSession.shared.dataTask(with: Data.URL) { data, response, error in
            guard let data = data, let JSON = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()), let sharedData = Data(JSON: JSON) else {
                DispatchQueue.main.async {
                    completion?(false)
                }
                return
            }
            UserDefaults.standard.data = data
            Data.shared = sharedData
            DispatchQueue.main.async{
                completion?(true)
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: DataReloadNotification), object: Data.shared)
        }.resume()
    }
    
    init(fromDefaults: Bool) {
        if fromDefaults, let data = UserDefaults.standard.data, let JSON = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()), let defaultsData = Data(JSON: JSON) {
            self = defaultsData
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
