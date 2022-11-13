//
//  PasswordEntropy.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 12.11.2022.
//

import Foundation

public class PasswordEntropy {
    
    public struct AnalyzeResult {
        
        public enum Entropy {
            
            case veryWeak
            case weak
            case reasonable
            case strong
            case veryStrong
            
            init(bitsOfEntropy: Double) {
                switch bitsOfEntropy {
                case 0..<28:
                    self = .veryWeak
                case 28..<35:
                    self = .weak
                case 36..<59:
                    self = .reasonable
                case 59..<127:
                    self = .strong
                case 127..<Double.infinity:
                    self = .veryStrong
                default:
                    preconditionFailure("Невалидное количество бит экнтропии \(bitsOfEntropy)")
                }
            }
        }
        
        public let time: String
        public let entropy: Entropy
    }
    
    public let characterSet =  [
        "abcdefghijklmnopqrstuvwxyz",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "0123456789",
        "!@#$%^&*()",
    ]
    
    public func analyze(_ password: String) -> AnalyzeResult {
        var poolSize: Double = 0
        let count = Double(password.count)
        
        characterSet.forEach { characterSet in
            if let _ = password.rangeOfCharacter(from: CharacterSet(charactersIn: characterSet)) {
                poolSize += Double(characterSet.count)
            }
        }
        
        guard !password.isEmpty, poolSize > 0 else {
            return AnalyzeResult(
                time: "мгновенно",
                entropy: .veryWeak
            )
        }
        
        let bitsOfEntropy = log2(poolSize) * count
        let entropy = AnalyzeResult.Entropy(bitsOfEntropy: bitsOfEntropy)
        
        let size = size(from: poolSize, and: count)
        let time = TimeInterval(size) / 100000000000
        
        if Int(time) < 1 {
            return AnalyzeResult(
                time: "мгновенно",
                entropy: entropy
            )
        }
        
        if Int(time.year) > 20 {
            return AnalyzeResult(
                time: "бесконечно",
                entropy: entropy
            )
        }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        let formattedTime = formatter.string(from: time)!
        
        return AnalyzeResult(
            time: formattedTime,
            entropy: entropy
        )
    }
    
    func size(from poolSize: Double, and count: Double) -> Double {
        guard count > 0 else { return poolSize }
        return poolSize + pow(poolSize, count - 1)
    }
}
