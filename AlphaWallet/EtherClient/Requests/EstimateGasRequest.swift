// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import JSONRPCKit
import BigInt

struct EstimateGasRequest: JSONRPCKit.Request {
    typealias Response = String

    let from: AlphaWallet.Address
    let to: AlphaWallet.Address?
    let value: BigInt
    let data: Data

    var method: String {
        return "eth_estimateGas"
    }

    var parameters: Any? {
        let results = [
            [
                "from": from.description,
                "to": to?.description ?? "",
                "value": "0x" + String(value, radix: 16) ?? "0x0",
                "data": data.hexEncoded,
            ],
        ]
        return results
    }

    func response(from resultObject: Any) throws -> Response {
        if let response = resultObject as? Response {
            return response
        } else {
            throw CastError(actualValue: resultObject, expectedType: Response.self)
        }
    }
}
