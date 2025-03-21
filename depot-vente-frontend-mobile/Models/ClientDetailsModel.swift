struct ClientDetails: Codable {
    let due: Int
    let paid_amount: Int
    let soldRG: [RealGame]
    let stockedRG:[RealGame]
}
