import Foundation
public enum Level: Int {
    case Driver, Passenger, Bag, BigCat, SmallCat, Mouse
    var legs: Int {
        get {
            switch self {
            case .Bag:
                return 0
            case .Driver, .Passenger:
                return 2
            case .BigCat, .SmallCat, .Mouse:
                return 4
            }
        }
    }
    static var allValues: [Level] {
        get { return [.Driver, .Passenger, .Bag, .BigCat, .SmallCat, .Mouse] }
    }
}

func calc() -> Int {
    var legs = 0
    for level in Level.allValues {
        let count = Int(powf(5, Float(level.rawValue))) // 5 ^ level
        legs += count * level.legs
    }
    legs += 4 // horse
    return legs
}
calc()
