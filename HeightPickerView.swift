//
//  HeightPickerView.swift
//  Goals
//
//  Created by Michael Miscampbell on 31/01/2016.
//  Copyright © 2016 Miscampbell App Design. All rights reserved.
//

import UIKit

protocol HeightPickerViewDelegate {
    func heightValueChanged(pickerView: HeightPickerView)
}

class HeightPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var heightMeasurement: HeightMeasurement = .Centimetre
    private var customBackgroundColor: UIColor?
    
    internal var heightPickerViewdelegate: HeightPickerViewDelegate?
    
    private(set) internal var heightTextValue: String = ""
    private(set) internal var heightDoubleValue: Double = 0.0
    
    enum HeightMeasurement: Int {
        case Centimetre = 0
        case Foot = 1
    }
    
    init()
    {
        super.init(frame: CGRectZero)

        self.delegate = self
        self.dataSource = self
        
        self.selectRow(0, inComponent: 2, animated: false)
    }
    
    convenience init(customBackgroundColor: UIColor) {
        self.init()
        self.customBackgroundColor = customBackgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 3
    }
    
    internal func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch heightMeasurement {
            case .Centimetre:
                return numberOfRowsInComponentForCentimetres(component)
            case .Foot:
                return numberOfRowsInComponentForFoot(component)
        }
    }
    
    private func numberOfRowsInComponentForCentimetres(component: Int) -> Int {
        switch component {
            case 0:
                return 400
            case 1:
                return 10
            default:
                return 2
        }
    }
    
    private func numberOfRowsInComponentForFoot(component: Int) -> Int {
        switch component {
        case 0:
            return 10
        case 1:
            return 11
        default:
            return 2
        }
    }
    
    //  MARK: UIPickerViewDelegate
    internal func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if let customBackgroundColor = customBackgroundColor {
            pickerView.backgroundColor = customBackgroundColor
        }
        
        switch heightMeasurement {
            case .Centimetre:
                return titleForRowWithCentimetres(component, row: row)
            case .Foot:
                return titleForRowWithFoot(component, row: row)
        }
    }
    
    private func titleForRowWithCentimetres(component: Int, row: Int) -> String
    {
        switch component {
            case 0:
                return "\(row)"
            case 1:
                return "\(row)"
            default:
                return titleForHeightMeasurement(HeightMeasurement(rawValue: row)!)
        }
    }
    
    private func titleForRowWithFoot(component: Int, row: Int) -> String
    {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        default:
            return titleForHeightMeasurement(HeightMeasurement(rawValue: row)!)
        }
    }
    
    private func titleForHeightMeasurement(measurementType: HeightMeasurement) -> String
    {
        switch measurementType {
            case .Centimetre:
                return "cm"
            case .Foot:
                return "ft"
        }
    }
    
    internal func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (component == 2)
        {
            heightMeasurement = HeightMeasurement(rawValue: row)!
            pickerView.reloadAllComponents()
        }
        
        let tempHeightTextValue = "\(pickerView.selectedRowInComponent(0)).\(pickerView.selectedRowInComponent(1))"
        heightDoubleValue = Double(tempHeightTextValue)!
        heightTextValue = "\(tempHeightTextValue) \(titleForHeightMeasurement(heightMeasurement))"
        
        heightPickerViewdelegate?.heightValueChanged(self)
    }
    
    
}
