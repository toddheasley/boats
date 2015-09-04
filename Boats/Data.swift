//
//  Data.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import Foundation

protocol JSONDecoding {
    init?(JSON: AnyObject)
}

protocol JSONEncoding {
    var JSON: AnyObject {
        get
    }
}

class Data: JSONEncoding {
    static let sharedData = Data()
    private(set) var routes: [Route] = []
    private(set) var local: Bool = false
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "routes": routes.map{$0.JSON}
        ]
    }
    
    func refresh(completion: (error: Error) -> Void) {
        var URL: NSURL? =  NSURL(string: "https://raw.githubusercontent.com/toddheasley/boats/master/data.json")
        if (local) {
            guard let path = NSBundle.mainBundle().pathForResource("data", ofType: "json") else {
                completion(error: .URL)
                return
            }
            URL = NSURL.fileURLWithPath(path)
        }
        
        guard let _ = URL else {
            completion(error: .URL)
            return
        }
        NSURLSession.sharedSession().dataTaskWithURL(URL!){ data, response, error in
            if let _ = error {
                completion(error: .HTTP)
                return
            }
            if (!self.local) {
                guard let response = response as? NSHTTPURLResponse where response.statusCode == 200 else {
                    completion(error: .HTTP)
                    return
                }
            }
            guard let data = data else {
                completion(error: .HTTP)
                return
            }
            do {
                guard let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject], let _ = JSON["routes"] as? [AnyObject] else {
                    completion(error: .JSONDecoding)
                    return
                }
                var routes: [Route] = []
                for routeJSON in (JSON["routes"] as! [AnyObject]) {
                    guard let route = Route(JSON: routeJSON) else {
                        completion(error: .JSONDecoding)
                        return
                    }
                    routes.append(route)
                }
                self.routes = routes
                completion(error: .None)
            } catch  {
                completion(error: .JSONDecoding)
            }
        }.resume()
    }
    
    convenience init(local: Bool) {
        self.init()
        self.local = local
    }
}

struct Route: JSONDecoding, JSONEncoding {
    private(set) var name: String
    private(set) var destination: Location
    private(set) var origin: Location
    private(set) var schedules: [Schedule]
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "name": name,
            "destination": destination.JSON,
            "origin": origin.JSON,
            "schedules": schedules.map{$0.JSON}
        ]
    }
    
    // MARK: JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let _ = JSON["destination"], let destination = Location(JSON: JSON["destination"]!), let _ = JSON["origin"], let origin = Location(JSON: JSON["origin"]!), let _ = JSON["schedules"] as? [AnyObject] else {
            return nil
        }
        var schedules: [Schedule] = []
        for scheduleJSON in (JSON["schedules"] as! [AnyObject]) {
            guard let scheduleJSON = scheduleJSON as? [String: AnyObject], let schedule = Schedule(JSON: scheduleJSON) else {
                return nil
            }
            schedules.append(schedule)
        }
        self.name = name
        self.destination = destination
        self.origin = origin
        self.schedules = schedules
    }
}

struct Schedule: JSONDecoding, JSONEncoding {
    private(set) var season: Season
    private(set) var dates: (start: Date, end: Date)
    private(set) var holidays: [Holiday]
    private(set) var departures: [Departure]
    
    func departures(day: Day, reverse: Bool = false) -> [Departure] {
        return departures.filter{
            return ($0.days.contains(day) || $0.days.contains(Day.Everyday)) && $0.reverse == reverse
        }
    }
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "season": season.rawValue,
            "dates": "\(dates.start.JSON),\(dates.end.JSON)",
            "holidays": holidays.map{$0.JSON},
            "departures": departures.map{$0.JSON}
        ]
    }
    
    // MARK: JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let _ = JSON["season"] as? String, let season = Season(rawValue: JSON["season"] as! String), let dates = JSON["dates"] as? String, let _ = JSON["holidays"] as? [AnyObject], let _ = JSON["departures"] as? [AnyObject] else {
            return nil
        }
        let components = dates.characters.split{$0 == ","}.map{String($0)}
        if (components.count != 2) {
            return nil
        }
        guard let start = Date(JSON: components[0]), let end = Date(JSON: components[1]) else {
            return nil
        }
        var holidays: [Holiday] = []
        for holidayJSON in (JSON["holidays"] as! [AnyObject]) {
            guard let holidayJSON = holidayJSON as? [String: String], let holiday = Holiday(JSON: holidayJSON) else {
                return nil
            }
            holidays.append(holiday)
        }
        var departures: [Departure] = []
        for departureJSON in (JSON["departures"] as! [AnyObject]) {
            guard let departureJSON = departureJSON as? [String: AnyObject], let departure = Departure(JSON: departureJSON) else {
                return nil
            }
            departures.append(departure)
        }
        self.season = season
        self.dates = (start: start, end: end)
        self.holidays = holidays
        self.departures = departures //.sort(return )
    }
}

struct Departure: JSONDecoding, JSONEncoding {
    private(set) var days: [Day]
    private(set) var time: Time
    private(set) var reverse: Bool = false
    private(set) var cars: Bool = false
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "days": days.map{$0.rawValue},
            "time": time.JSON,
            "reverse": reverse,
            "cars": cars
        ]
    }
    
    // MARK: JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let _ = JSON["days"] as? [String], let _ = JSON["days"] as? [String], let _ = JSON["time"] as? String, let time = Time(JSON: JSON["time"]!), let reverse = JSON["reverse"] as? Bool, let cars = JSON["cars"] as? Bool else {
            return nil
        }
        var days: [Day] = []
        for dayJSON in (JSON["days"] as! [String]) {
            guard let day = Day(rawValue: dayJSON) else {
                return nil
            }
            days.append(day)
        }
        self.days = days
        self.time = time
        self.reverse = reverse
        self.cars = cars
    }
}

struct Location: JSONDecoding, JSONEncoding {
    private(set) var name: String
    private(set) var description: String
    private(set) var coordinate: Coordinate
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "name": name,
            "description": description,
            "coordinate": coordinate.JSON
        ]
    }
    
    // MARK: JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, let description = JSON["description"] as? String, let _ = JSON["coordinate"] as? String, let coordinate = Coordinate(JSON: JSON["coordinate"]!) else {
            return nil
        }
        self.name = name
        self.description = description
        self.coordinate = coordinate
    }
}

struct Coordinate: JSONDecoding, JSONEncoding {
    private(set) var latitude: Double
    private(set) var longitude: Double
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return "\(latitude),\(longitude)"
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.characters.split{$0 == ","}.map{String($0)}
        if (components.count != 2) {
            return nil
        }
        guard let latitude = Double(components[0]), let longitude = Double(components[1]) where !latitude.isNaN && !longitude.isNaN else {
            return nil
        }
        self.latitude = latitude
        self.longitude = longitude
    }
}

struct Holiday: JSONDecoding, JSONEncoding {
    private(set) var name: String
    private(set) var date: Date
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            "name": name,
            "date": date.JSON
        ]
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? [String: AnyObject], let name = JSON["name"] as? String, _ = JSON["date"] as? String, let date = Date(JSON: JSON["date"]!) else {
            return nil
        }
        self.name = name
        self.date = date
    }
}

struct Date: JSONDecoding, JSONEncoding {
    private(set) var year: Int
    private(set) var month: Int
    private(set) var day: Int
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            String(format: "%04d", year),
            String(format: "%02d", month),
            String(format: "%02d", day)
        ].joinWithSeparator("-")
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.characters.split{$0 == "-"}.map{String($0)}
        if (components.count != 3) {
            return nil
        }
        guard let year = Int(components[0]), let month = Int(components[1]), let day = Int(components[2]) else {
            return nil
        }
        self.year = max(2015, year)
        self.month = max(1, month)
        self.month = min(12, self.month)
        self.day = max(1, day)
        switch self.month {
        case 4, 6, 9, 11:
            self.day = min(30, self.day)
        case 2:
            self.day = min(((self.year - 2012) % 4 == 0) ? 29 : 28, self.day)
        default:
            self.day = min(31, self.day)
        }
    }
}

struct Time: JSONDecoding, JSONEncoding {
    private(set) var hour: Int
    private(set) var minute: Int
    
    // MARK: JSONEncoding
    var JSON: AnyObject {
        return [
            String(format: "%02d", hour),
            String(format: "%02d", minute)
        ].joinWithSeparator(":")
    }
    
    // MARK JSONDecoding
    init?(JSON: AnyObject) {
        guard let JSON = JSON as? String else {
            return nil
        }
        let components = JSON.characters.split{$0 == ":"}.map{String($0)}
        if (components.count != 2) {
            return nil
        }
        guard let hour = Int(components[0]), let minute = Int(components[1]) else {
            return nil
        }
        self.hour = max(0, hour)
        self.hour = min(23, self.hour)
        self.minute = max(0, minute)
        self.minute = min(59, self.minute)
    }
}

enum Season: String {
    case Spring = "Spring"
    case Summer = "Summer"
    case Fall = "Fall"
    case Winter = "Winter"
}

enum Day: String {
    case Everyday = "Everyday"
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
    case Sunday = "Sunday"
    case Holiday = "Holiday"
}

enum Error: Int {
    case None = 0
    case JSONDecoding
    case JSONEncoding
    case HTTP
    case URL
}
