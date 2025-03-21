import Foundation

struct Session: Identifiable, Codable {
    let id: Int
    let begin_date: Date
    let end_date: Date
    let commission: Int
    let fees: Int
}
