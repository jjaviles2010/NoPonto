//
//  MeatTemperature.swift
//  NoPonto WatchKit Extension
//
//  Created by Jose Javier Aviles Gomez on 27/03/20.
//  Copyright © 2020 Jose Javier Aviles Gomez. All rights reserved.
//

import Foundation

enum MeatTemperature: Int {
    case rare = 0, mediumRare, medium, wellDone
    
    var stringValue: String {
        let temperature = ["Cru", "Mal passado", "Ao ponto", "Bem passado"]
        return temperature[self.rawValue]
    }
    
    var timeModifier: Double {
        let modifier = [0.5, 0.75, 1.0, 1.5]
        return modifier[self.rawValue]
    }
    
    func cookTimeForKg(_ kg: Double) -> TimeInterval {
        let  baseTime: TimeInterval = 13 * 60
        let baseWeight = 0.5
        let weightModifier = kg/baseWeight
        return baseTime * weightModifier * timeModifier
    }
    
}
