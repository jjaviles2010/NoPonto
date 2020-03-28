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
    @IBOutlet weak var btTimer: WKInterfaceButton!    
    @IBOutlet weak var lbWeight: WKInterfaceLabel!
    @IBOutlet weak var textGroup: WKInterfaceGroup!
    @IBOutlet weak var lbCook: WKInterfaceLabel!
    @IBOutlet weak var slider: WKInterfaceSlider!
    @IBOutlet weak var imageGroup: WKInterfaceGroup!
    @IBOutlet weak var weightPicker: WKInterfacePicker!
    @IBOutlet weak var lbTemperature: WKInterfaceLabel!
    @IBOutlet weak var temperaturePicker: WKInterfacePicker!
    
    // MARK: - Properties
    var timerRunning = false
    var kg = 0.1
    var increment = 0.1
    var cookTemp: MeatTemperature = .rare
   
    // MARK: - Super Methods
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        imageGroup.setHidden(true)
        updateConfiguration()
        setupPickers()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    // MARK: - IBActions
    @IBAction func timerPressed() {
        if timerRunning {
            timer.stop()
            btTimer.setTitle("Iniciar Timer")
        } else {
            let countdown: TimeInterval = cookTemp.cookTimeForKg(kg)
            let date = Date(timeIntervalSinceNow: countdown)
            timer.setDate(date)
            timer.start()
            btTimer.setTitle("Interromper Timer")
        }
        timerRunning.toggle()
    }
    
    
    @IBAction func onMinusPressed() {
        if kg > 0.1 {
            kg -= increment
            updateConfiguration()
        }
    }
    
    @IBAction func onPlusPressed() {
        if kg < 1.0 {
                  kg += increment
                  updateConfiguration()
              }
    }
    
    @IBAction func onSliderTempChange(_ value: Float) {
        if let temp = MeatTemperature(rawValue: Int(value)) {
            cookTemp = temp
            updateConfiguration()
        }
        
    }
    
    @IBAction func onWeightChange(_ value: Int) {
        kg = Double(value+1) * increment
        updateConfiguration()
    }
    
    @IBAction func onPickerTempChange(_ value: Int) {
        cookTemp = MeatTemperature(rawValue: value)!
        updateConfiguration()
        slider.setValue(Float(value))
    }
    
    @IBAction func onModeChange(_ value: Bool) {
        imageGroup.setHidden(!value)
        textGroup.setHidden(value)
        updateConfiguration()

        let index = Int(round(kg/increment) - 1)
        weightPicker.setSelectedItemIndex(index)
    }
    
    
    // MARK: - Methods
    func updateConfiguration() {
        kg = get2DecimalPlaces(for: kg)
        lbWeight.setText("Total: \(kg) kg")
        lbCook.setText(cookTemp.stringValue)
        lbTemperature.setText(cookTemp.stringValue)
        temperaturePicker.setSelectedItemIndex(cookTemp.rawValue)
    }
    
    func get2DecimalPlaces(for number: Double) -> Double {
        return round(number*100)/100
    }
    
    func setupPickers() {
        //Picker de quantidade
        var weightItems: [WKPickerItem] = []
        for number in stride(from: 0.1, through: 1.0, by: increment) {
            let item = WKPickerItem()
            item.title = "\(get2DecimalPlaces(for: number))"
            weightItems.append(item)
        }
        weightPicker.setItems(weightItems)
        weightPicker.setSelectedItemIndex(0)
        
        //Picker de ponto da carne
        var tempItems: [WKPickerItem] = []
        for index in 1...4 {
          let item = WKPickerItem()
          item.contentImage = WKImage(imageName: "temp-\(index)")
          tempItems.append(item)
        }
          temperaturePicker.setItems(tempItems)
          temperaturePicker.setSelectedItemIndex(0)
    }
}
