//
//  DiameterViewController.swift
//  MPIFormulas
//
//  Created by Matt Dahl on 7/25/19.
//  Copyright © 2019 mattMakes. All rights reserved.
//

import UIKit

class DiameterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    
    
    @IBOutlet weak var leftPicker: UIPickerView!
    @IBOutlet weak var centerPicker: UIPickerView!
    @IBOutlet weak var rightPicker: UIPickerView!
    //Labels
    
    
    @IBOutlet weak var leftAmountLabel: UILabel!
    @IBOutlet weak var centerAmountLabel: UILabel!
    @IBOutlet weak var rightAmountLabel: UILabel!
    @IBOutlet weak var poundsPerReamLabel: UILabel!
    @IBOutlet weak var poundsPerReamAmtLabel: UILabel!
    
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

    let leftItems1 = ["DM (inch)"]
    let leftItems2 = ["Linear (ft)"]
    let centerItems1 = ["Caliper(mils)"]
    let centerItems2 = ["Caliper(mils)", "Width(in)"]
    let rightItems1 = ["LF 3\" Core", "LF 6\" Core", "LM 6\" Core"]
    let rightItems2 = ["DM 3\" Core", "DM 6\" Core"]
    let rightItems3 = ["Roll Weight(lbs)"]

    
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
        leftItems = leftItems1 + leftItems2
        rightItems = rightItems1
        centerItems = centerItems1
        
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
            let leftSpinnerIndex = Int(tabSwitchDataPass.prefix(2))!
            let middleSpinnerIndex = Int(tabSwitchDataPass.prefix(5).suffix(2))!
            let rightSpinnerIndex = Int(tabSwitchDataPass.suffix(2))!
            
            if(leftSpinnerIndex == 0){rightItems = rightItems1; centerItems = centerItems1}
            else if(leftSpinnerIndex == 1){
                if(middleSpinnerIndex == 0){
                    rightItems = rightItems2;
                }
                else if(middleSpinnerIndex == 1){
                    rightItems = rightItems3
                }
                
            }
            
            
            leftPicker.selectRow(leftSpinnerIndex, inComponent:0, animated:true)
            centerPicker.selectRow(middleSpinnerIndex, inComponent: 0, animated: true)
            self.rightPicker.reloadAllComponents()
            rightPicker.selectRow(rightSpinnerIndex, inComponent:0, animated:true)
            tabSwitchDataPass = "NO DATA"
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    //resize text in pickers so it fits
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        if(pickerView == leftPicker){
            label.text = leftItems[row]
        }
        else if(pickerView == centerPicker){
            label.text = centerItems[row]
        }
        else{
            label.text = rightItems[row]
        }
        
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
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
        if(pickerView == leftPicker){
            leftSelectedItem = leftItems[leftPicker.selectedRow(inComponent: 0)]
            if(leftItems1.contains(leftSelectedItem)){
                centerItems = centerItems1
                rightItems = rightItems1
            }
            else if(leftItems2.contains(leftSelectedItem)){
                centerItems = centerItems2
                rightItems = rightItems2
            }
        }
        if(pickerView == centerPicker){
            if(row == 0){
                rightItems = rightItems2
            }
            else{
                rightItems = rightItems3
            }
            
        }
        
        
        self.rightPicker.reloadAllComponents()
        self.centerPicker.reloadAllComponents()
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
        
        let leftAmount = Double(leftAmountLabel.text!)
        let centerAmount = Double(centerAmountLabel.text!)
        let poundAmount = Double(poundsPerReamAmtLabel.text!)
        var rightAmount = 0.0
        //DO ALL CONVERSIONS AND CHECKS HERE
        
        if(left == leftItems[0]){
            if(right == rightItems[0]){
                rightAmount = (((leftAmount!*leftAmount!)-9)*65.4536)/centerAmount!
            }
            else if(right == rightItems[1]){
                rightAmount = (((leftAmount!*leftAmount!)-36)*65.4536)/centerAmount!
            }
            else if(right == rightItems[2]){
                rightAmount = (((((leftAmount!*leftAmount!)-36)*65.4536)/centerAmount!)*12*2.54)/100
            }
        }
        if(left == leftItems[1]){
            if(center == centerItems[0]){
                if(right == rightItems[0]){
                    rightAmount = ((leftAmount!/(65.4536/centerAmount!))+9).squareRoot()
                }
                else if(right == rightItems[1]){
                    rightAmount = ((leftAmount!/(65.4536/centerAmount!))+36).squareRoot()
                }
            }
            else if(center == centerItems[1]){
                if(right == rightItems[0]){
                    rightAmount = (leftAmount!*centerAmount!*poundAmount!)/36000
                }
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
    
    
    
    
    
}
