//
//  TimeInterval+converting.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 12.11.2022.
//

import Foundation

extension TimeInterval {
    
    var minute: Int {
        return Int(self) / 60
    }
    
    var hour: Int {
        return minute / 60
    }
    
    var day: Int {
        return hour / 24
    }
    
    var year: Int {
        return day / 365
    }
}
