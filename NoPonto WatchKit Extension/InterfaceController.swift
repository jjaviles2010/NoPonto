//
//  InterfaceController.swift
//  NoPonto WatchKit Extension
//
//  Created by Jose Javier Aviles Gomez on 27/03/20.
//  Copyright © 2020 Jose Javier Aviles Gomez. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var timer: WKInterfaceTimer!
    @IBOutlet weak var timerButton: WKInterfaceButton!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func timerPressed() {
        let countdown: TimeInterval = 15
        let date = Date(timeIntervalSinceNow: countdown)
        timer.setDate(date)
        timer.start()
    }
}
