import XCTest
@testable import BoatsKit

class TimetableTests: XCTestCase {
    func testTrips() {
        guard let timetable: Timetable = try? JSONDecoder.shared.decode(Timetable.self, from: JSON_Data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(timetable.trips.count, 14)
        XCTAssertEqual(timetable.trips(from: Time(hour: 5, minute: 44)).count, 14)
        XCTAssertEqual(timetable.trips(from: Time(hour: 5, minute: 44)).first?.origin?.time, Time(hour: 5, minute: 45))
        XCTAssertEqual(timetable.trips(from: Time(hour: 5, minute: 45)).count, 14)
        XCTAssertNil(timetable.trips(from: Time(hour: 5, minute: 45)).first?.origin)
        XCTAssertEqual(timetable.trips(from: Time(hour: 5, minute: 45)).first?.destination?.time, Time(hour: 6, minute: 15))
        XCTAssertEqual(timetable.trips(from: Time(hour: 22, minute: 29)).count, 1)
        XCTAssertEqual(timetable.trips(from: Time(hour: 22, minute: 29)).first?.origin?.time, Time(hour: 22, minute: 30))
        XCTAssertEqual(timetable.trips(from: Time(hour: 22, minute: 30)).count, 1)
        XCTAssertNil(timetable.trips(from: Time(hour: 22, minute: 30)).first?.origin)
        XCTAssertEqual(timetable.trips(from: Time(hour: 22, minute: 30)).first?.destination?.time, Time(hour: 22, minute: 55))
        XCTAssertEqual(timetable.trips(from: Time(hour: 22, minute: 54)).count, 1)
        XCTAssertTrue(timetable.trips(from: Time(hour: 22, minute: 55)).isEmpty)
    }
}

extension TimetableTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Timetable(trips: [], days: [.monday, .tuesday, .wednesday, .thursday]).description, "Mon-Thu")
        XCTAssertEqual(Timetable(trips: [], days: [.monday, .tuesday, .wednesday, .holiday]).description, "Mon-Wed/Hol")
        XCTAssertEqual(Timetable(trips: [], days: [.thursday, .friday, .saturday, .holiday]).description, "Thu-Sat/Hol")
        XCTAssertEqual(Timetable(trips: [], days: [.saturday, .sunday, .holiday]).description, "Sat/Sun/Hol")
        XCTAssertEqual(Timetable(trips: [], days: [.tuesday, .thursday, .friday]).description, "Tue/Thu/Fri")
        XCTAssertEqual(Timetable(trips: [], days: [.sunday, .holiday]).description, "Sun/Hol")
    }
}

extension TimetableTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        guard let html: [String] = String(data: HTML_Data, encoding: .utf8)?.find("<table[^>]*>(.*?)</table>"), html.count == 4 else {
            XCTFail()
            return
        }
        XCTAssertEqual(try? Timetable(from: "\(html[0])").trips.count, 14)
        XCTAssertEqual(((try? Timetable(from: "\(html[0])").trips.first?.origin?.time) as Time??), Time(hour: 5, minute: 45))
        XCTAssertEqual(((try? Timetable(from: "\(html[0])").trips.last?.destination?.time) as Time??), Time(hour: 22, minute: 55))
        XCTAssertEqual(try? Timetable(from: "\(html[0])").days, [.monday, .tuesday, .wednesday, .thursday])
        XCTAssertEqual(try? Timetable(from: "\(html[1])").trips.count, 15)
        XCTAssertEqual(((try? Timetable(from: "\(html[1])").trips.first?.origin?.time) as Time??), Time(hour: 5, minute: 45))
        XCTAssertEqual(((try? Timetable(from: "\(html[1])").trips.last?.destination?.time) as Time??), Time(hour: 23, minute: 55))
        XCTAssertEqual(try? Timetable(from: "\(html[1])").days, [.friday])
        XCTAssertEqual(try? Timetable(from: "\(html[2])").trips.count, 15)
        XCTAssertEqual(((try? Timetable(from: "\(html[2])").trips.first?.origin?.time) as Time??), Time(hour: 5, minute: 45))
        XCTAssertEqual(((try? Timetable(from: "\(html[2])").trips.last?.destination?.time) as Time??), Time(hour: 23, minute: 55))
        XCTAssertEqual(try? Timetable(from: "\(html[2])").days, [.saturday])
        XCTAssertEqual(try? Timetable(from: "\(html[3])").trips.count, 12)
        XCTAssertEqual(((try? Timetable(from: "\(html[3])").trips.first?.origin?.time) as Time??), Time(hour: 6, minute: 45))
        XCTAssertEqual(((try? Timetable(from: "\(html[3])").trips.last?.destination?.time) as Time??), Time(hour: 21, minute: 45))
        XCTAssertEqual(try? Timetable(from: "\(html[3])").days, [.sunday, .holiday])
    }
}

private let JSON_Data: Data = """
{
    "trips": [
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 5
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 6
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 6
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 7
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 7
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 8
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 30,
                    "hour": 9
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 0,
                    "hour": 10
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 10
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 11
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 12
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 12
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 14
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 14
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 15,
                    "hour": 15
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 45,
                    "hour": 15
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 30,
                    "hour": 16
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 0,
                    "hour": 17
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 35,
                    "hour": 17
                },
                "deviations": []
            },
            "destination": {
                "services": [
                    "car"
                ],
                "time": {
                    "minute": 0,
                    "hour": 18
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [],
                "time": {
                    "minute": 15,
                    "hour": 19
                },
                "deviations": []
            },
            "destination": {
                "services": [],
                "time": {
                    "minute": 45,
                    "hour": 19
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [],
                "time": {
                    "minute": 15,
                    "hour": 20
                },
                "deviations": []
            },
            "destination": {
                "services": [],
                "time": {
                    "minute": 45,
                    "hour": 20
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [],
                "time": {
                    "minute": 15,
                    "hour": 21
                },
                "deviations": []
            },
            "destination": {
                "services": [],
                "time": {
                    "minute": 45,
                    "hour": 21
                },
                "deviations": []
            }
        },
        {
            "origin": {
                "services": [],
                "time": {
                    "minute": 30,
                    "hour": 22
                },
                "deviations": []
            },
            "destination": {
                "services": [],
                "time": {
                    "minute": 55,
                    "hour": 22
                },
                "deviations": []
            }
        }
    ],
    "days": [
        "monday",
        "tuesday",
        "wednesday",
        "thursday"
    ]
}
""".data(using: .utf8)!

private let HTML_Data: Data = """
<table id="tablepress-3" class="tablepress tablepress-id-3">
<thead>
<tr class="row-1 odd">
<th class="column-1">&nbsp;</th><th colspan="2" class="column-2">Mon.-Thurs.</th>
</tr>
</thead>
<tbody>
<tr class="row-2 even">
<td class="column-1"></td><td class="column-2">Depart Portland</td><td class="column-3">Depart Peaks</td>
</tr>
<tr class="row-3 odd">
<td rowspan="5" class="column-1">AM</td><td class="column-2">5:45 cf</td><td class="column-3">6:15 cf</td>
</tr>
<tr class="row-4 even">
<td class="column-2">6:45 cf</td><td class="column-3">7:15 cf</td>
</tr>
<tr class="row-5 odd">
<td class="column-2">7:45 cf</td><td class="column-3">8:15 cf</td>
</tr>
<tr class="row-6 even">
<td class="column-2">9:30 cf</td><td class="column-3">10:00 cf</td>
</tr>
<tr class="row-7 odd">
<td class="column-2">10:45 cf</td><td class="column-3">11:15 cf</td>
</tr>
<tr class="row-8 even">
<td rowspan="9" class="column-1">PM</td><td class="column-2">12:15 cf</td><td class="column-3">12:45 cf</td>
</tr>
<tr class="row-9 odd">
<td class="column-2">2:15 cf</td><td class="column-3">2:45 cf</td>
</tr>
<tr class="row-10 even">
<td class="column-2">3:15 cf</td><td class="column-3">3:45 cf</td>
</tr>
<tr class="row-11 odd">
<td class="column-2">4:30 cf</td><td class="column-3">5:00 cf</td>
</tr>
<tr class="row-12 even">
<td class="column-2">5:35 cf</td><td class="column-3">6:00 cf</td>
</tr>
<tr class="row-13 odd">
<td class="column-2">7:15</td><td class="column-3">7:45 </td>
</tr>
<tr class="row-14 even">
<td class="column-2">8:15 </td><td class="column-3">8:45 </td>
</tr>
<tr class="row-15 odd">
<td class="column-2">9:15 </td><td class="column-3">9:45 </td>
</tr>
<tr class="row-16 even">
<td class="column-2">10:30</td><td class="column-3">10:55</td>
</tr>
</tbody>
</table>
<!-- #tablepress-3 from cache --><br />

<table id="tablepress-5" class="tablepress tablepress-id-5">
<thead>
<tr class="row-1 odd">
<th class="column-1"></th><th colspan="2" class="column-2">Friday</th>
</tr>
</thead>
<tbody>
<tr class="row-2 even">
<td class="column-1"></td><td class="column-2">Departs Portland</td><td class="column-3">Departs Peaks</td>
</tr>
<tr class="row-3 odd">
<td rowspan="5" class="column-1">AM</td><td class="column-2">5:45 cf</td><td class="column-3">6:15 cf</td>
</tr>
<tr class="row-4 even">
<td class="column-2">6:45 cf</td><td class="column-3">7:15 cf</td>
</tr>
<tr class="row-5 odd">
<td class="column-2">7:45 cf</td><td class="column-3">8:15 cf</td>
</tr>
<tr class="row-6 even">
<td class="column-2">9:30 cf</td><td class="column-3">10:00 cf</td>
</tr>
<tr class="row-7 odd">
<td class="column-2">10:45 cf</td><td class="column-3">11:15 cf</td>
</tr>
<tr class="row-8 even">
<td class="column-1">PM</td><td class="column-2">12:15 cf</td><td class="column-3">12:45 cf</td>
</tr>
<tr class="row-9 odd">
<td rowspan="10" class="column-1"></td><td class="column-2"></td><td class="column-3"></td>
</tr>
<tr class="row-10 even">
<td class="column-2">2:15 cf</td><td class="column-3">2:45 cf</td>
</tr>
<tr class="row-11 odd">
<td class="column-2">3:15 cf</td><td class="column-3">3:45 cf</td>
</tr>
<tr class="row-12 even">
<td class="column-2">4:30 cf</td><td class="column-3">5:00 cf</td>
</tr>
<tr class="row-13 odd">
<td class="column-2">5:35 cf</td><td class="column-3">6:00 cf</td>
</tr>
<tr class="row-14 even">
<td class="column-2">7:15 cf</td><td class="column-3">7:45 cf</td>
</tr>
<tr class="row-15 odd">
<td class="column-2">8:15 cf</td><td class="column-3">8:45 cf</td>
</tr>
<tr class="row-16 even">
<td class="column-2">9:15 cf</td><td class="column-3">9:45 cf</td>
</tr>
<tr class="row-17 odd">
<td class="column-2">10:30 cf</td><td class="column-3">10:55 cf</td>
</tr>
<tr class="row-18 even">
<td class="column-2">11:30 cf</td><td class="column-3">11:55 cf</td>
</tr>
</tbody>
</table>
<!-- #tablepress-5 from cache --><br />

<table id="tablepress-6" class="tablepress tablepress-id-6">
<thead>
<tr class="row-1 odd">
<th class="column-1">&nbsp;</th><th colspan="2" class="column-2">Saturday </th>
</tr>
</thead>
<tbody>
<tr class="row-2 even">
<td class="column-1"></td><td class="column-2">Departs Portland</td><td class="column-3">Departs Peaks</td>
</tr>
<tr class="row-3 odd">
<td rowspan="5" class="column-1">AM</td><td class="column-2">5:45 cf</td><td class="column-3">6:15 cf</td>
</tr>
<tr class="row-4 even">
<td class="column-2">6:45 cf</td><td class="column-3">7:15 cf</td>
</tr>
<tr class="row-5 odd">
<td class="column-2">7:45 cf</td><td class="column-3">8:15 cf</td>
</tr>
<tr class="row-6 even">
<td class="column-2">9:30 cf</td><td class="column-3">10:00 cf</td>
</tr>
<tr class="row-7 odd">
<td class="column-2">10:45 cf</td><td class="column-3">11:15 cf</td>
</tr>
<tr class="row-8 even">
<td rowspan="10" class="column-1">PM</td><td class="column-2">12:15 cf</td><td class="column-3">12:45 cf</td>
</tr>
<tr class="row-9 odd">
<td class="column-2">2:15 cf</td><td class="column-3">2:45 cf</td>
</tr>
<tr class="row-10 even">
<td class="column-2">3:15 cf</td><td class="column-3">3:45 cf</td>
</tr>
<tr class="row-11 odd">
<td class="column-2">4:30 cf</td><td class="column-3">5:00 cf</td>
</tr>
<tr class="row-12 even">
<td class="column-2">5:35 cf</td><td class="column-3">6:00 cf</td>
</tr>
<tr class="row-13 odd">
<td class="column-2">7:15 </td><td class="column-3">7:45 </td>
</tr>
<tr class="row-14 even">
<td class="column-2">8:15 </td><td class="column-3">8:45 </td>
</tr>
<tr class="row-15 odd">
<td class="column-2">9:15 </td><td class="column-3">9:45 </td>
</tr>
<tr class="row-16 even">
<td class="column-2">10:30 </td><td class="column-3">10:55 </td>
</tr>
<tr class="row-17 odd">
<td class="column-2">11:30 </td><td class="column-3">11:55 </td>
</tr>
</tbody>
</table>
<!-- #tablepress-6 from cache --><br />

<table id="tablepress-8" class="tablepress tablepress-id-8">
<thead>
<tr class="row-1 odd">
<th class="column-1">&nbsp;</th><th colspan="2" class="column-2">Sun/Holiday</th>
</tr>
</thead>
<tbody>
<tr class="row-2 even">
<td class="column-1"></td><td class="column-2">Departs Portland</td><td class="column-3">Departs Peaks</td>
</tr>
<tr class="row-3 odd">
<td rowspan="4" class="column-1">AM</td><td class="column-2">6:45 cf</td><td class="column-3">7:15 cf</td>
</tr>
<tr class="row-4 even">
<td class="column-2">7:45 cf</td><td class="column-3">8:15 cf</td>
</tr>
<tr class="row-5 odd">
<td class="column-2">9:30 cf</td><td class="column-3">10:00 cf</td>
</tr>
<tr class="row-6 even">
<td class="column-2">10:45 cf</td><td class="column-3">11:15 cf</td>
</tr>
<tr class="row-7 odd">
<td rowspan="9" class="column-1">PM</td><td class="column-2">12:15 cf</td><td class="column-3">12:45 cf</td>
</tr>
<tr class="row-8 even">
<td class="column-2">2:15 cf</td><td class="column-3">2:45 cf</td>
</tr>
<tr class="row-9 odd">
<td class="column-2">3:15 cf</td><td class="column-3">3:45 cf</td>
</tr>
<tr class="row-10 even">
<td class="column-2">4:30 cf</td><td class="column-3">5:00 cf</td>
</tr>
<tr class="row-11 odd">
<td class="column-2">5:35 cf</td><td class="column-3">6:00 cf</td>
</tr>
<tr class="row-12 even">
<td class="column-2">7:15</td><td class="column-3">7:45 </td>
</tr>
<tr class="row-13 odd">
<td class="column-2">8:15starts 11/1</td><td class="column-3">12:20 ends 10/31</td><td class="column-3">8:45 </td>
</tr>
<tr class="row-14 even">
<td class="column-2">9:15 xh ends 10/31</td><td class="column-3">9:45 xh starts 11/1</td>
</tr>
<tr class="row-15 odd">
<td class="column-2"></td><td class="column-3"></td>
</tr>
</tbody>
</table>
<!-- #tablepress-8 from cache --></p>
<p style="text-align: center;"><strong>Holiday Schedule is on:</strong><br />
Veteran&#8217;s Day<br />
Thanksgiving<br />
Christmas Day<br />
New Year&#8217;s Day</p>
<p style="text-align: center;"><strong>On Christmas Eve last trip:</strong><br />
to Peaks Island at 9:15 PM<br />
from Peaks Island at 9:45 PM</p>
<p style="text-align: center;"><strong>On New Year&#8217;s Eve last trip:</strong><br />
to Peaks Island at 10:30 PM<br />
from Peaks Island at 10:55 PM</p>
<p style="text-align: center;"><strong>New Year&#8217;s Eve Special:</strong><br />
1:00 AM departure to all islands</p>
""".data(using: .utf8)!
