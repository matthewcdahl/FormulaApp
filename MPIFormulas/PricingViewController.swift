//
//  PricingViewController.swift
//  MPIFormulas
//
//  Created by Matt Dahl on 7/25/19.
//  Copyright © 2019 mattMakes. All rights reserved.
//

import UIKit

class PricingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    //UI Elements
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var backButton1: UIButton!
    @IBOutlet weak var backButton2: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var screen1Stack: UIStackView!
    @IBOutlet weak var screen3Stack: UIStackView!
    @IBOutlet weak var fieldsStack: UIStackView!
    @IBOutlet weak var field1Stack: UIStackView!
    @IBOutlet weak var field2Stack: UIStackView!
    @IBOutlet weak var field3Stack: UIStackView!
    
    //Buttons
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var pmButton: UIButton!
    @IBOutlet weak var decButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    //Screen3 Labels
    @IBOutlet weak var field1: UILabel!
    @IBOutlet weak var field2: UILabel!
    @IBOutlet weak var field3: UILabel!
    @IBOutlet weak var field4: UILabel!
    @IBOutlet weak var value1: UILabel!
    @IBOutlet weak var value2: UILabel!
    @IBOutlet weak var value3: UILabel!
    @IBOutlet weak var value4: UILabel!
    
    
    
    //Variables
    var screenIndex = 0
    var firstSelectedIndex = 3
    var secondSelectedIndex = 0
    
    
    //PickerOptions
    var currSpinnerItems: [String] = []
    let masterSpinnerItems = ["$/Linear Foot", "$/Linear Yard", "$/Linear Meter", "$/Square Foot", "$/Square Yard", "$/Square Meter", "$/MSI", "$/MSF", "$/Pound", "$/Kilogram", "Order Value in $"]
    let lfItems = ["$/MSF + Width(Inches)"]
    let lyItems = ["$/MSF + Width(Inches)"]
    let lmItems = ["$/MSF + Width(Inches)"]
    let sfItems = ["$/MSF"]
    let syItems = ["$/MSF"]
    let smItems = ["$/MSF", "Pounds + Pounds/Ream"]
    let msiItems = ["$/MSF"]
    let msfItems = ["Square Foot", "Square Meter", "Linear ft + Width(Inches)", "MSI", "$/Pounds + Pounds/Ream"]
    let poundItems = ["MSF + Pounds/Ream"]
    let kgItems = ["MSF + Pounds/Ream"]
    let ovItems = ["MSF + $/MSF", "Linear ft + Width(in) + $/MSF", "lbs + lbs/Ream + $/MSF"]
    var allItemsArray:[[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        initializeAllArray()
        setupScreen(prevScreen: 0)
        
        //iPhone 5 sizing
        let device = UIDevice.modelName
        if(device.contains("iPhone 5") || device.contains("Touch")){
            field1.font = field1.font.withSize(25)
            field2.font = field2.font.withSize(25)
            field3.font = field3.font.withSize(25)
            field4.font = field4.font.withSize(25)
            value1.font = value1.font.withSize(25)
            value2.font = value2.font.withSize(25)
            value3.font = value3.font.withSize(25)
            value4.font = value4.font.withSize(25)

        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(currSpinnerItems.count)
        return currSpinnerItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currSpinnerItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func initializeAllArray(){
        allItemsArray.append(lfItems)
        allItemsArray.append(lyItems)
        allItemsArray.append(lmItems)
        allItemsArray.append(sfItems)
        allItemsArray.append(syItems)
        allItemsArray.append(smItems)
        allItemsArray.append(msiItems)
        allItemsArray.append(msfItems)
        allItemsArray.append(poundItems)
        allItemsArray.append(kgItems)
        allItemsArray.append(ovItems)
    }
    
    func setupScreen(prevScreen: Int){
        if(screenIndex == 0){
            screen1Stack.isHidden = false
            screen3Stack.isHidden = true
            buttonStack.removeArrangedSubview(backButton1)
            backButton1.isHidden = true
            currSpinnerItems = masterSpinnerItems
            picker.reloadAllComponents()

            picker.selectRow(firstSelectedIndex, inComponent: 0, animated: false)
            promptLabel.textColor = UIColor.black
            promptLabel.text = "I Want to Calculate"
        }
        else if(screenIndex == 1){
            screen1Stack.isHidden = false
            screen3Stack.isHidden = true
            buttonStack.insertArrangedSubview(backButton1, at: 0)
            backButton1.isHidden = false
            if(prevScreen == 0){firstSelectedIndex = picker.selectedRow(inComponent: 0)}
            currSpinnerItems = allItemsArray[firstSelectedIndex]
            picker.reloadAllComponents()
            picker.selectRow(secondSelectedIndex, inComponent: 0, animated: false)
            promptLabel.textColor = UIColor(red:0.26, green:0.59, blue:0.21, alpha:1.0)
            promptLabel.numberOfLines = 3
            let stringToShow = "I Want to Calculate\n" + masterSpinnerItems[firstSelectedIndex] + "\nUsing..."
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringToShow)
            attributedString.setColor(color: UIColor.black, forText: "I Want to Calculate")
            attributedString.setColor(color: UIColor.black, forText: "Using...")
            promptLabel.attributedText = attributedString
        }
        else if(screenIndex == 2){
            field4.text = masterSpinnerItems[firstSelectedIndex]
            secondSelectedIndex = picker.selectedRow(inComponent: 0)
            screen1Stack.isHidden = true
            screen3Stack.isHidden = false
            if(currSpinnerItems == lfItems){
                if(secondSelectedIndex == 0){
                    twoFieldsSetup()
                    field1.text = "$/MSF"
                    field2.text = "Width (in)"
                }
            }
            else if(currSpinnerItems == sfItems){
                if(secondSelectedIndex == 0){
                    oneFieldSetup()
                    field1.text = "$/MSF"
                }
            }
            else if(currSpinnerItems == smItems){
                if(secondSelectedIndex == 0){
                    oneFieldSetup()
                    field1.text = "$/MSF"
                }
                else if(secondSelectedIndex == 1){
                    twoFieldsSetup()
                    field1.text = "Pounds"
                    field2.text = "Pounds/Ream"
                }
            }
            else if(currSpinnerItems == msfItems){
                if(secondSelectedIndex == 0){
                    oneFieldSetup()
                    field1.text = "Square Feet"
                }
                else if(secondSelectedIndex == 1){
                    oneFieldSetup()
                    field1.text = "Square Meters"
                }
                else if(secondSelectedIndex == 2){
                    twoFieldsSetup()
                    field1.text = "Linear Feet"
                    field2.text = "Width (in)"
                }
                if(secondSelectedIndex == 3){
                    oneFieldSetup()
                    field1.text = "MSI"
                }
                else if(secondSelectedIndex == 4){
                    twoFieldsSetup()
                    field1.text = "$/Pound"
                    field2.text = "Pounds/Ream"
                }
            }
            else if(currSpinnerItems == poundItems){
                if(secondSelectedIndex == 0){
                    twoFieldsSetup()
                    field1.text = "MSF"
                    field2.text = "Pounds/Ream"
                }
            }
            else if(currSpinnerItems == ovItems){
                if(secondSelectedIndex == 0){
                    twoFieldsSetup()
                    field1.text = "MSF"
                    field2.text = "$/MSF"
                }
                else if(secondSelectedIndex == 1){
                    threeFieldsSetup()
                    field1.text = "Linear Feet"
                    field2.text = "Width (in)"
                    field3.text = "$/MSF"
                }
                else if(secondSelectedIndex == 2){
                    threeFieldsSetup()
                    field1.text = "Pounds"
                    field2.text = "Pounds/Ream"
                    field3.text = "$/MSF"
                }
            }
        }
    }
    
    func oneFieldSetup(){
        fieldsStack.insertArrangedSubview(field1Stack, at: 0)
        field1Stack.isHidden = false
        fieldsStack.removeArrangedSubview(field2Stack)
        field2Stack.isHidden = true
        fieldsStack.removeArrangedSubview(field3Stack)
        field3Stack.isHidden = true
    }
    func twoFieldsSetup(){
        fieldsStack.insertArrangedSubview(field1Stack, at: 0)
        field1Stack.isHidden = false
        fieldsStack.insertArrangedSubview(field2Stack, at: 1)
        field2Stack.isHidden = false
        fieldsStack.removeArrangedSubview(field3Stack)
        field3Stack.isHidden = true
    }
    func threeFieldsSetup(){
        fieldsStack.insertArrangedSubview(field1Stack, at: 0)
        field1Stack.isHidden = false
        fieldsStack.insertArrangedSubview(field2Stack, at: 1)
        field2Stack.isHidden = false
        fieldsStack.insertArrangedSubview(field3Stack, at: 2)
        field3Stack.isHidden = false
    }
    
    @IBAction func nextPageAction(_ sender: Any) {
        screenIndex += 1
        setupScreen(prevScreen: screenIndex-1)
    }
    @IBAction func backPageAction(_ sender: Any) {
        screenIndex -= 1
        setupScreen(prevScreen: screenIndex+1)
    }
    @IBAction func back3Action(_ sender: Any) {
        screenIndex -= 1
        setupScreen(prevScreen: screenIndex+1)
    }
    
    
    
    
}

extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
