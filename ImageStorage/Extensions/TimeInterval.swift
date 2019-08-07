//
//  TimeInterval.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 8/7/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import Foundation

extension TimeInterval{
    func convertToFormattedString() -> String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600) % 24
        
        if hours == 0{
            return String(format: "%d:%02d", minutes, seconds)
        }else{
            fatalError("TimeInterval to String conversion has not been tested for intervals over 1 hour.")
//            return String(format: "%d:%02d%02d", hours, minutes, seconds)
        }
    }
}
