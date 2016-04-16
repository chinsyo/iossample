//: Playground - noun: a place where people can play

import Foundation

enum Suit: String {
    case Spades = "♠️"
    case Hearts = "❤️"
    case Clubs = "♣️"
    case Diamonds = "♦️"
}

enum Rank: Int, CustomStringConvertible {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    var description: String {
        switch self {
        case .Ace:
            return "A"
        case .Jack:
            return "J"
        case .Queen:
            return "Q"
        case .King:
            return "K"
        default:
            return String(rawValue)
        }
    }
}

protocol EnumeratableEnumType {
    static var allValues: [Self] { get }
}

extension Suit: EnumeratableEnumType {
    static var allValues: [Suit] {
        return [.Spades, .Hearts, .Clubs, .Diamonds]
    }
}

extension Rank: EnumeratableEnumType {
    static var allValues: [Rank] {
        return [.Ace, .Two, .Three, .Four, .Five, .Six,.Seven, .Eight, .Nine, .Ten, .Jack, .Queen, .King]
    }
}

public struct Poker {
    var suit: Suit
    var rank: Rank
}

var pokers = [Poker]()
for suit in Suit.allValues {
    for rank in Rank.allValues {
        let poker = Poker(suit: suit, rank: rank)
        pokers.append(poker)
    }
}
pokers
