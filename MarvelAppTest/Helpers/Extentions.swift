//
//  Extentions.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import Foundation
import CommonCrypto

extension String {
    func withReplacedCharacters(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
}

extension String {
    var md5Value: String {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            var digest = [UInt8](repeating: 0, count: length)
            
            if let d = self.data(using: .utf8) {
                _ = d.withUnsafeBytes { body -> String in
                    CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
                    return ""
                }
            }
            
            return (0 ..< length).reduce("") {
                $0 + String(format: "%02x", digest[$1])
            }
        }
}

extension Date {
    func currentTimeInMillis() -> Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
}
