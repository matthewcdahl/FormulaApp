//
//  MeasureViewController.swift
//  MPIFormulas
//
//  Created by Matt Dahl on 7/25/19.
//  Copyright © 2019 mattMakes. All rights reserved.
//


//TODO Fix up error messages for 0 pounds/ream when needed
//Make it look pretty

import UIKit

class MeasureViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    

    
    @IBOutlet weak var leftPicker: UIPickerView!
    @IBOutlet weak var centerPicker: UIPickerView!
    @IBOutlet weak var rightPicker: UIPickerView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    //Labels
    @IBOutlet weak var leftAmountLabel: UILabel!
    @IBOutlet weak var centerAmountLabel: UILabel!
    @IBOutlet weak var rightAmountLabel: UILabel!
    @IBOutlet weak var poundsPerReamLabel: UILabel!
    @IBOutlet weak var poundsPerReamAmtLabel: UILabel!
    @IBOutlet weak var labelStack: UIStackView!
    @IBOutlet weak var spinnerStack: UIStackView!
    
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
    
    //MARK: Variable Declarations
    let distanceItems = ["Linear Feet", "Linear Yards"]
    let weightItems = ["Pounds", "MSF"]
    let lengthItems = ["Width in...", "cm", "inches", "ft", "meters"]
    
    
    let leftItems1 = ["Pounds", "Kilograms"]
    let leftItems2 = ["Square Inches", "Square Feet", "Square Yards", "MSI"]
    let leftItems3 = ["MSF"]
    let rightItems1 = ["Square Inches", "Square Feet", "Square Yards", "MSI", "MSF"]
    let rightItems2 = ["Pounds", "Kilograms", "MSF"]
    let rightItems3 = ["Pounds","Kilograms", "Square Yards", "MSI"]
    
    var leftItems: [String] = []
    var centerItems: [String] = []
    var rightItems: [String] = []
    let device = UIDevice.modelName
    var selectedLabel: UILabel = UILabel()
    var selectedSegment = 0
    
    var leftSelectedItem = ""
    var rightSelectedItem = ""
    var centerSelectedItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        self.leftPicker.delegate = self
        self.centerPicker.delegate = self
        self.rightPicker.delegate = self
        leftItems = distanceItems + weightItems
        rightItems = weightItems
        centerItems = lengthItems
        
        centerPicker.selectRow(2, inComponent: 0, animated: false)
        selectedLabel = leftAmountLabel
        
        //ALLOW TAPPING ON LABELS
        poundsPerReamAmtLabel.isUserInteractionEnabled = true
        leftAmountLabel.isUserInteractionEnabled = true
        centerAmountLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(poundsTapFunction))
        poundsPerReamAmtLabel.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(leftTapFunction))
        leftAmountLabel.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(centerTapFunction))
        centerAmountLabel.addGestureRecognizer(tap3)
        
        
        
        //iPhone 5 sizing
        if(device.contains("iPhone 5") || device.contains("Touch")){
            leftAmountLabel.font = leftAmountLabel.font.withSize(25)
            centerAmountLabel.font = leftAmountLabel.font.withSize(25)
            rightAmountLabel.font = leftAmountLabel.font.withSize(25)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(tabSwitchDataPass != "NO DATA"){
            let segmentIndex = Int(tabSwitchDataPass.prefix(2))
            let firstSpinnerIndex = Int(tabSwitchDataPass.prefix(5).suffix(2))!
            let secondSpinnerIndex = Int(tabSwitchDataPass.suffix(2))!
            if(segmentIndex == 0){
                segmentController.selectedSegmentIndex = 0
                updateSegments(changed: true)
                if(firstSpinnerIndex < 2) {rightItems = weightItems}
                else if(firstSpinnerIndex < 5){rightItems = distanceItems}
            }
            else{
                segmentController.selectedSegmentIndex = 1
                updateSegments(changed: true)
                if(firstSpinnerIndex < 2){rightItems = rightItems1}
                else if(firstSpinnerIndex < 6){rightItems = rightItems2}
                else{rightItems = rightItems3}
            }
            leftPicker.selectRow(firstSpinnerIndex, inComponent: 0, animated: true)
            rightPicker.reloadAllComponents()
            rightPicker.selectRow(secondSpinnerIndex, inComponent:0, animated:true)
            tabSwitchDataPass = "NO DATA"
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == leftPicker){
            return leftItems.count
        }
        else if(pickerView == centerPicker){
            return centerItems.count
        }
        else{
            return rightItems.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == leftPicker){
            return leftItems[row]
        }
        else if(pickerView == centerPicker){
            return centerItems[row]
        }
        else{
            return rightItems[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(selectedSegment == 0){
            if(pickerView == leftPicker){
                leftSelectedItem = leftItems[leftPicker.selectedRow(inComponent: 0)]
                if(distanceItems.contains(leftSelectedItem)){
                    rightItems = weightItems
                }
                else if(weightItems.contains(leftSelectedItem)){
                    rightItems = distanceItems
                }
            }
            else if(pickerView == centerPicker){
                if(row == 0){
                    pickerView.selectRow(1, inComponent: 0, animated: true)
                }
            }
        }
        else if(selectedSegment == 1){
            if(pickerView == leftPicker){
                leftSelectedItem = leftItems[leftPicker.selectedRow(inComponent: 0)]
                if(leftItems1.contains(leftSelectedItem)){
                    rightItems = rightItems1
                }
                else if(leftItems2.contains(leftSelectedItem)){
                    rightItems = rightItems2
                }
                else if(leftItems3.contains(leftSelectedItem)){
                    rightItems = rightItems3
                }
            }
        }

        self.rightPicker.reloadAllComponents()
        setLabels()
        
    }
    
    
    
    
    func setupButtons(){
        oneButton.layer.cornerRadius = 2
        oneButton.layer.borderWidth = 1
        oneButton.layer.borderColor = UIColor.black.cgColor
        oneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        twoButton.layer.cornerRadius = 2
        twoButton.layer.borderWidth = 1
        twoButton.layer.borderColor = UIColor.black.cgColor
        twoButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        threeButton.layer.cornerRadius = 2
        threeButton.layer.borderWidth = 1
        threeButton.layer.borderColor = UIColor.black.cgColor
        threeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        fourButton.layer.cornerRadius = 2
        fourButton.layer.borderWidth = 1
        fourButton.layer.borderColor = UIColor.black.cgColor
        fourButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        fiveButton.layer.cornerRadius = 2
        fiveButton.layer.borderWidth = 1
        fiveButton.layer.borderColor = UIColor.black.cgColor
        fiveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        sixButton.layer.cornerRadius = 2
        sixButton.layer.borderWidth = 1
        sixButton.layer.borderColor = UIColor.black.cgColor
        sixButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        sevenButton.layer.cornerRadius = 2
        sevenButton.layer.borderWidth = 1
        sevenButton.layer.borderColor = UIColor.black.cgColor
        sevenButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        eightButton.layer.cornerRadius = 2
        eightButton.layer.borderWidth = 1
        eightButton.layer.borderColor = UIColor.black.cgColor
        eightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        nineButton.layer.cornerRadius = 2
        nineButton.layer.borderWidth = 1
        nineButton.layer.borderColor = UIColor.black.cgColor
        nineButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        zeroButton.layer.cornerRadius = 2
        zeroButton.layer.borderWidth = 1
        zeroButton.layer.borderColor = UIColor.black.cgColor
        zeroButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        pmButton.layer.cornerRadius = 2
        pmButton.layer.borderWidth = 1
        pmButton.layer.borderColor = UIColor.black.cgColor
        pmButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        decButton.layer.cornerRadius = 2
        decButton.layer.borderWidth = 1
        decButton.layer.borderColor = UIColor.black.cgColor
        decButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        clearButton.layer.cornerRadius = 2
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.black.cgColor
        clearButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        backButton.layer.cornerRadius = 2
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        swapButton.layer.cornerRadius = 2
        swapButton.layer.borderWidth = 1
        swapButton.layer.borderColor = UIColor.black.cgColor
        swapButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        resetButton.layer.cornerRadius = 2
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        leftAmountLabel.layer.cornerRadius = 2
        leftAmountLabel.layer.borderWidth = 2
        leftAmountLabel.layer.borderColor = UIColor(displayP3Red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0).cgColor
        leftAmountLabel.adjustsFontSizeToFitWidth = true
        
        centerAmountLabel.layer.cornerRadius = 2
        centerAmountLabel.layer.borderWidth = 2
        centerAmountLabel.layer.borderColor = UIColor.black.cgColor
        centerAmountLabel.adjustsFontSizeToFitWidth = true
        

        rightAmountLabel.adjustsFontSizeToFitWidth = true
        
        poundsPerReamAmtLabel.layer.cornerRadius = 2
        poundsPerReamAmtLabel.layer.borderWidth = 2
        poundsPerReamAmtLabel.layer.borderColor = UIColor.black.cgColor
        poundsPerReamAmtLabel.adjustsFontSizeToFitWidth = true
    }
    
    @objc func poundsTapFunction(sender:UITapGestureRecognizer) {
        selectedLabel = poundsPerReamAmtLabel
        poundsPerReamAmtLabel.layer.borderColor = UIColor(displayP3Red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0).cgColor
        centerAmountLabel.layer.borderColor = UIColor.black.cgColor
        leftAmountLabel.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc func leftTapFunction(sender:UITapGestureRecognizer) {
        selectedLabel = leftAmountLabel
        leftAmountLabel.layer.borderColor = UIColor(displayP3Red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0).cgColor
        poundsPerReamAmtLabel.layer.borderColor = UIColor.black.cgColor
        centerAmountLabel.layer.borderColor = UIColor.black.cgColor


    }
    
    @objc func centerTapFunction(sender:UITapGestureRecognizer) {
        selectedLabel = centerAmountLabel
        centerAmountLabel.layer.borderColor = UIColor(displayP3Red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0).cgColor
        poundsPerReamAmtLabel.layer.borderColor = UIColor.black.cgColor
        leftAmountLabel.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func oneButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "1"}
        else{selectedLabel.text = selectedLabel.text! + "1"}
        
        setLabels()
    }
    
    @IBAction func twoButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "2"}
        else{selectedLabel.text = selectedLabel.text! + "2"}
        
        setLabels()
    }
    
    @IBAction func threeButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "3"}
        else{selectedLabel.text = selectedLabel.text! + "3"}
        setLabels()
    }
    
    @IBAction func fourButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "4"}
        else{selectedLabel.text = selectedLabel.text! + "4"}
        setLabels()
    }
    
    @IBAction func fiveButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "5"}
        else{selectedLabel.text = selectedLabel.text! + "5"}
        setLabels()
    }
    
    @IBAction func sixButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "6"}
        else{selectedLabel.text = selectedLabel.text! + "6"}
        setLabels()
    }
    
    @IBAction func sevenButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "7"}
        else{selectedLabel.text = selectedLabel.text! + "7"}
        setLabels()
    }
    
    @IBAction func eightButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "8"}
        else{selectedLabel.text = selectedLabel.text! + "8"}
        setLabels()
    }
    
    @IBAction func nineButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "9"}
        else{selectedLabel.text = selectedLabel.text! + "9"}
        setLabels()
    }
    
    @IBAction func zeroButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "0"}
        else{selectedLabel.text = selectedLabel.text! + "0"}
        setLabels()
    }
    
    @IBAction func pmButtonAction(_ sender: Any) {
        if(selectedLabel.text == "0"){selectedLabel.text = "0"}
        else{
            let curText = selectedLabel.text
            if((curText?.contains("-"))!){
                let size = selectedLabel.text?.count
                let offset = size! - 1
                selectedLabel.text = String(selectedLabel.text!.suffix(offset))
            }
            else{
                selectedLabel.text = "-" + selectedLabel.text!
            }
        }
        setLabels()
    }
    
    @IBAction func decButtonAction(_ sender: Any) {
        let curText = selectedLabel.text
        if(!(curText?.contains("."))!){
            selectedLabel.text = selectedLabel.text! + "."
        }
    }
    
    
    @IBAction func clearButtonAction(_ sender: Any) {
        leftAmountLabel.text = "0"
        centerAmountLabel.text = "0"
        rightAmountLabel.text = "0"
        poundsPerReamAmtLabel.text = "0"
        setLabels()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        if(selectedLabel.text?.count == 1 || (selectedLabel.text?.count == 2 && (selectedLabel.text?.contains("-"))!)){
            selectedLabel.text = "0"
        }
        else{
            let size = (selectedLabel.text?.count)!
            let offset = size - 1
            let pre = String(selectedLabel.text!.prefix(offset))
            selectedLabel.text = pre
            
        }
        setLabels()
    }
    
    @IBAction func swapButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        
    }
    
    func setLabels(){
        rightSelectedItem = rightItems[rightPicker.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPicker.selectedRow(inComponent: 0)]
        centerSelectedItem = centerItems[centerPicker.selectedRow(inComponent: 0)]
        convert(left: leftSelectedItem, center: centerSelectedItem, right: rightSelectedItem)
    }
    
    func convert(left: String, center: String, right: String){
        if(selectedSegment == 0){
            let leftAmount = Double(leftAmountLabel.text!)
            let centerAmount = Double(centerAmountLabel.text!)
            let poundAmount = Double(poundsPerReamAmtLabel.text!)
            print("heyy: " + centerAmountLabel.text!)
            let width = widthToInches(type: center, amount: centerAmount!)
            
            var rightAmount = 0.0
            if(left == leftItems[0]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*width*poundAmount!)/36000.0
                }
                else if(right == rightItems[1]){
                    rightAmount = leftAmount!*width / 12000.0
                }
            }
            else if(left == leftItems[1]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*width*poundAmount!)/12000.0
                }
                else if(right == rightItems[1]){
                    rightAmount = leftAmount!*width*3.0 / 12000.0
                }
            }
            else if(left == leftItems[2]){
                if(poundAmount! == 0 || width == 0){}
                if(right == rightItems[0]){
                    rightAmount = leftAmount!*36000.0/(width*poundAmount!)
                }
                else if(right == rightItems[1]){
                    rightAmount = leftAmount!*12000.0/(width*poundAmount!)
                }
            }
            else if(left == leftItems[3]){
                if(right == rightItems[0]){
                    rightAmount = leftAmount!*12000.0/(width)
                }
                else if(right == rightItems[1]){
                    rightAmount = leftAmount!*12000.0/(width*3.0)
                }
            }
            let textToPut = String(Double(round(1000000*rightAmount)/1000000))
            if(textToPut == "inf" || textToPut == "nan"){
                rightAmountLabel.text = "DIV/0!"
            }
            else{
                rightAmountLabel.text = textToPut
            }
            
        }
        else if(selectedSegment == 1){
            let leftAmount = Double(leftAmountLabel.text!)
            let poundAmount = Double(poundsPerReamAmtLabel.text!)
            var rightAmount = 0.0
            //DO ALL CONVERSIONS AND CHECKS HERE
            
            if(left == leftItems[0]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*3000.0*144)/(poundAmount!)
                }
                else if(right == rightItems[1]){
                    rightAmount = (leftAmount!*3000.0)/poundAmount!
                }
                else if(right == rightItems[2]){
                    rightAmount = (leftAmount!*3000.0)/(poundAmount!*9)
                }
                else if(right == rightItems[3]){
                    rightAmount = (leftAmount!*3000.0*144)/(poundAmount!*1000)
                }
                else if(right == rightItems[4]){
                    rightAmount = (leftAmount!*3000.0)/(poundAmount!*1000)
                }
            }
            else if(left == leftItems[1]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*2.20462*3000.0*144)/(poundAmount!)
                }
                else if(right == rightItems[1]){
                    rightAmount = (leftAmount!*2.20462*3000.0)/poundAmount!
                }
                else if(right == rightItems[2]){
                    rightAmount = (leftAmount!*2.20462*3000.0)/(poundAmount!*9)
                }
                else if(right == rightItems[3]){
                    rightAmount = (leftAmount!*2.20462*3000.0*144)/(poundAmount!*1000)
                }
                else if(right == rightItems[4]){
                    rightAmount = (leftAmount!*2.20462*3000.0)/(poundAmount!*1000)
                }
            }
            else if(left == leftItems[2]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*poundAmount!)/(3000.0*144.0)
                }
                else if(right == rightItems[1]){
                    rightAmount = (leftAmount!*poundAmount!)/(3000.0*144.0)/2.20462
                }
                else if(right == rightItems[2]){
                    rightAmount = ((leftAmount!/1296)*9)/1000
                }
            }
            else if(left == leftItems[3]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*poundAmount!)/(3000.0)
                }
                else if(right == rightItems[1]){
                    rightAmount = (leftAmount!*poundAmount!)/(3000.0)/2.20462
                }
                else if(right == rightItems[2]){
                    rightAmount = ((leftAmount!/9)*9)/1000
                }
            }
            else if(left == leftItems[4]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*poundAmount!*9)/(3000.0)
                }
                else if(right == rightItems[1]){
                    rightAmount = (leftAmount!*poundAmount!*9)/(3000.0)/2.20462
                }
                else if(right == rightItems[2]){
                    rightAmount = (leftAmount!*9)/1000
                }
            }
            else if(left == leftItems[5]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*poundAmount!*1000)/(3000.0*144)
                }
                else if(right == rightItems[1]){
                    rightAmount = (leftAmount!*poundAmount!*1000)/(3000.0*144)/2.20462
                }
                else if(right == rightItems[2]){
                    rightAmount = (leftAmount!/144)
                }
            }
            else if(left == leftItems[6]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*poundAmount!)/(3)
                }
                else if(right == rightItems[1]){
                    rightAmount = ((leftAmount!*poundAmount!)/3)/2.20462
                }
                else if(right == rightItems[2]){
                    rightAmount = (leftAmount!*1000)/9
                }
                else if(right == rightItems[3]){
                    rightAmount = (leftAmount!*144)
                }
            }

            let textToPut = String(Double(round(1000000*rightAmount)/1000000))
            if(textToPut == "inf" || textToPut == "nan"){
                rightAmountLabel.text = "DIV/0!"
            }
            else{
                rightAmountLabel.text = textToPut
            }
            
            
        }
    }
    
    func widthToInches(type: String, amount: Double) -> Double{
        if(type == centerItems[0]){
            return 0;
        }
        else if(type == centerItems[1]){
            return amount/2.54
        }
        else if(type == centerItems[2]){
            return amount
        }
        else if(type == centerItems[3]){
            return amount * 12
        }
        else if(type == centerItems[4]){
            return amount * 39.37
        }
        else {
            return 0
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        let changed = selectedSegment != segmentController.selectedSegmentIndex
        updateSegments(changed: changed)
    }
    
    func updateSegments(changed: Bool){
        selectedSegment = segmentController.selectedSegmentIndex
        if(changed == true){
            if(selectedSegment == 0){
                spinnerStack.insertArrangedSubview(centerPicker, at: 1)
                centerPicker.isHidden = false
                labelStack.insertArrangedSubview(centerAmountLabel, at: 1)
                centerAmountLabel.isHidden = false
                
                leftItems = distanceItems + weightItems
                rightItems = weightItems
            }
            else if(selectedSegment == 1){
                
                spinnerStack.removeArrangedSubview(centerPicker)
                centerPicker.isHidden = true
                labelStack.removeArrangedSubview(centerAmountLabel)
                centerAmountLabel.isHidden = true
                
                leftItems = leftItems1 + leftItems2 + leftItems3
                rightItems = rightItems1
                
            }
            leftPicker.reloadAllComponents()
            centerPicker.reloadAllComponents()
            rightPicker.reloadAllComponents()
        }
    }
    
    
}
