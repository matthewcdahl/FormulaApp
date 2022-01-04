//
//  MetricViewController.swift
//  MPIFormulas
//
//  Created by Matt Dahl on 7/25/19.
//  Copyright © 2019 mattMakes. All rights reserved.
//

import UIKit

var testing = 0


class MetricViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    //MARK: Outlets
    @IBOutlet weak var leftPickerView: UIPickerView!
    @IBOutlet weak var rightPickerView: UIPickerView!
    
    //Labels
    @IBOutlet weak var leftAmountLabel: UILabel!
    @IBOutlet weak var rightAmountLabel: UILabel!
    
    
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
    let distanceItems = ["Microns", "Mils", "Centimeters", "Inches", "Feet", "Meters"]
    let weightItems = ["Pounds", "Kilograms", "Metric Tonnes"]
    let tempItems = ["Farenheit", "Celcius"]
    let areaItems = ["Square Centimeters", "Square Inches", "Square Meters", "MSF"]
    let specialItems = ["Pounds/Ream", "GSM"]
    var leftItems: [String] = []
    var rightItems: [String] = []
    
    var leftSelectedItem = ""
    var rightSelectedItem = ""
    
    //MARK Functions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftPickerView.delegate = self
        self.rightPickerView.delegate = self
        leftItems = distanceItems + weightItems + tempItems + areaItems + specialItems
        rightItems = weightItems
        leftPickerView.selectRow(6, inComponent:0, animated:false)
        rightPickerView.selectRow(1, inComponent:0, animated:false)
        setupButtons()
        oneButton.layer.cornerRadius = 2
        oneButton.layer.borderWidth = 1
        oneButton.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(tabSwitchDataPass != "NO DATA"){
            let firstSpinnerIndex = Int(tabSwitchDataPass.prefix(2))!
            let secondSpinnerIndex = Int(tabSwitchDataPass.suffix(2))!
            leftPickerView.selectRow(firstSpinnerIndex, inComponent:0, animated:true)
            if(firstSpinnerIndex < 6){rightItems = distanceItems}
            else if(firstSpinnerIndex < 9){rightItems = weightItems}
            else if(firstSpinnerIndex < 11){rightItems = tempItems}
            else if(firstSpinnerIndex < 15){rightItems = areaItems}
            else if(firstSpinnerIndex < 17){rightItems = specialItems}
            self.rightPickerView.reloadAllComponents()
            rightPickerView.selectRow(secondSpinnerIndex, inComponent:0, animated:true)
            tabSwitchDataPass = "NO DATA"
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == leftPickerView){
            return leftItems.count
        }
        else{
            return rightItems.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == leftPickerView){
            return leftItems[row]
        }
        else{
            return rightItems[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == leftPickerView){
            leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
            if(distanceItems.contains(leftSelectedItem)){
                rightItems = distanceItems;
            }
            else if(weightItems.contains(leftSelectedItem)){
                rightItems = weightItems;
            }
            else if(tempItems.contains(leftSelectedItem)){
                rightItems = tempItems;
            }
            else if(areaItems.contains(leftSelectedItem)){
                rightItems = areaItems;
            }
            else if(specialItems.contains(leftSelectedItem)){
                rightItems = specialItems;
            }
            else{
                rightItems = leftItems
            }
            self.rightPickerView.reloadAllComponents()
        }
        
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    
    func convert(left: String, right: String){
        /*
         let distanceItems = ["Micron", "Mil", "Centimeters", "Inches", "Feet", "Meters"]
         let weightItems = ["Pounds", "Kilograms", "Metric Tonnes"]
         let tempItems = ["Farenheit", "Celcius"]
         let areaItems = ["Square Centimeters", "Square Inches", "Square Meters", "MSF"]
         let specialItems = ["Pounds/Ream", "GSM"] */
        
        if(distanceItems.contains(left)){distConvert(left: left, right: right)}
        else if(weightItems.contains(left)){weightConvert(left: left, right: right)}
        else if(tempItems.contains(left)){tempConvert(left: left, right: right)}
        else if(areaItems.contains(left)){areaConvert(left: left, right: right)}
        else if(specialItems.contains(left)){specialConvert(left: left, right: right)}
        
    }
    
    func distConvert(left: String, right: String){
        let leftValue = Double(leftAmountLabel.text!)
        var rightValue: Double = 0.0
        if(left == distanceItems[0]){
            if(right == distanceItems[0]){rightValue = leftValue!}
            else if(right == distanceItems[1]){rightValue = leftValue!/25.4}
            else if(right == distanceItems[2]){rightValue = leftValue!/1000}
            else if(right == distanceItems[3]){rightValue = leftValue!/25400}
            else if(right == distanceItems[4]){rightValue = leftValue!/304800}
            else if(right == distanceItems[5]){rightValue = leftValue!/1000000}
        }
        else if(left == distanceItems[1]){
            if(right == distanceItems[0]){rightValue = leftValue!*25.4}
            else if(right == distanceItems[1]){rightValue = leftValue!}
            else if(right == distanceItems[2]){rightValue = leftValue!*0.00254}
            else if(right == distanceItems[3]){rightValue = leftValue!/1000}
            else if(right == distanceItems[4]){rightValue = leftValue!/12000}
            else if(right == distanceItems[5]){rightValue = leftValue!*0.0000254}
        }
        else if(left == distanceItems[2]){
            if(right == distanceItems[0]){rightValue = leftValue!*1000}
            else if(right == distanceItems[1]){rightValue = leftValue!*393.7007874015748}
            else if(right == distanceItems[2]){rightValue = leftValue!}
            else if(right == distanceItems[3]){rightValue = leftValue!/2.54}
            else if(right == distanceItems[4]){rightValue = leftValue!/30.48}
            else if(right == distanceItems[5]){rightValue = leftValue!/100}
        }
        else if(left == distanceItems[3]){
            if(right == distanceItems[0]){rightValue = leftValue!*25400}
            else if(right == distanceItems[1]){rightValue = leftValue!*1000}
            else if(right == distanceItems[2]){rightValue = leftValue!*2.54}
            else if(right == distanceItems[3]){rightValue = leftValue!}
            else if(right == distanceItems[4]){rightValue = leftValue!/12}
            else if(right == distanceItems[5]){rightValue = leftValue!/39.37}
        }
        else if(left == distanceItems[4]){
            if(right == distanceItems[0]){rightValue = leftValue!*304800}
            else if(right == distanceItems[1]){rightValue = leftValue!*12000}
            else if(right == distanceItems[2]){rightValue = leftValue!*30.48}
            else if(right == distanceItems[3]){rightValue = leftValue!*12}
            else if(right == distanceItems[4]){rightValue = leftValue!}
            else if(right == distanceItems[5]){rightValue = leftValue!/3.28084}
        }
        else if(left == distanceItems[5]){
            if(right == distanceItems[0]){rightValue = leftValue!*1000000}
            else if(right == distanceItems[1]){rightValue = leftValue!*39370.079}
            else if(right == distanceItems[2]){rightValue = leftValue!*100}
            else if(right == distanceItems[3]){rightValue = leftValue!*39.3701}
            else if(right == distanceItems[4]){rightValue = leftValue!*3.28084}
            else if(right == distanceItems[5]){rightValue = leftValue!}
        }
        rightAmountLabel.text = String(Double(round(1000000*rightValue)/1000000))
        
    }
    func weightConvert(left: String, right: String){
        let leftValue = Double(leftAmountLabel.text!)
        var rightValue: Double = 0.0
        if(left == weightItems[0]){
            if(right == weightItems[0]){rightValue = leftValue!}
            else if(right == weightItems[1]){rightValue = leftValue!/2.20462}
            else if(right == weightItems[2]){rightValue = leftValue!/2204.623}
        }
        else if(left == weightItems[1]){
            if(right == weightItems[0]){rightValue = leftValue!*2.20462}
            else if(right == weightItems[1]){rightValue = leftValue!}
            else if(right == weightItems[2]){rightValue = leftValue!/1000}
        }
        else if(left == weightItems[2]){
            if(right == weightItems[0]){rightValue = leftValue!*2204.623}
            else if(right == weightItems[1]){rightValue = leftValue!*1000}
            else if(right == weightItems[2]){rightValue = leftValue!}
        }
        rightAmountLabel.text = String(Double(round(1000000*rightValue)/1000000))

    }
    func tempConvert(left: String, right: String){
        let leftValue = Double(leftAmountLabel.text!)
        var rightValue: Double = 0.0
        if(left == tempItems[0]){
            if(right == tempItems[0]){rightValue = leftValue!}
            else if(right == tempItems[1]){rightValue = (leftValue!-32)*(5.0/9.0)}
        }
        else if(left == tempItems[1]){
            if(right == tempItems[0]){rightValue = (leftValue!*(9.0/5.0))+32.0}
            else if(right == tempItems[1]){rightValue = leftValue!}
        }
        rightAmountLabel.text = String(Double(round(1000000*rightValue)/1000000))

    }
    func areaConvert(left: String, right: String){
        let leftValue = Double(leftAmountLabel.text!)
        var rightValue: Double = 0.0
        if(left == areaItems[0]){
            if(right == areaItems[0]){rightValue = leftValue!}
            else if(right == areaItems[1]){rightValue = leftValue!/6.452}
            else if(right == areaItems[2]){rightValue = leftValue!/10000}
            else if(right == areaItems[3]){rightValue = (leftValue!/10000)/(1000/(3.280839895*3.280839895))}
        }
        else if(left == areaItems[1]){
            if(right == areaItems[0]){rightValue = leftValue!*6.452}
            else if(right == areaItems[1]){rightValue = leftValue!}
            else if(right == areaItems[2]){rightValue = leftValue!/155.003}
            else if(right == areaItems[3]){rightValue = (leftValue!/1550.003)/(1000/(3.280839895*3.280839895))}
        }
        else if(left == areaItems[2]){
            if(right == areaItems[0]){rightValue = leftValue!*10000}
            else if(right == areaItems[1]){rightValue = leftValue!*155.003}
            else if(right == areaItems[2]){rightValue = leftValue!}
            else if(right == areaItems[3]){rightValue = (leftValue!/(1000/(3.280839895*3.280839895)))}
        }
        else if(left == areaItems[3]){
            if(right == areaItems[0]){rightValue = (leftValue!*10000)*(1000)/(3.280839895*3.280839895)}
            else if(right == areaItems[1]){rightValue = (leftValue!*155.003)*(1000)/(3.280839895*3.280839895)}
            else if(right == areaItems[2]){rightValue = leftValue!*1000/(3.280839895*3.280839895)}
            else if(right == areaItems[3]){rightValue = leftValue!}
        }
        rightAmountLabel.text = String(Double(round(1000000*rightValue)/1000000))

    }
    func specialConvert(left: String, right: String){
        let leftValue = Double(leftAmountLabel.text!)
        var rightValue: Double = 0.0
        if(left == specialItems[0]){
            if(right == specialItems[0]){rightValue = leftValue!}
            else if(right == specialItems[1]){rightValue = leftValue!*(16*28.34952313*3.280839895*3.280839895)/3000}
        }
        if(left == specialItems[1]){
            if(right == specialItems[0]){rightValue = leftValue!/((16*28.34952313*3.280839895*3.280839895)/3000)}
            else if(right == specialItems[1]){rightValue = leftValue!}
        }
        rightAmountLabel.text = String(Double(round(1000000*rightValue)/1000000))
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

        
        rightAmountLabel.adjustsFontSizeToFitWidth = true

    }
    

    @IBAction func oneButtonAction(_ sender: Any) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "1"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "1"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func twoButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "2"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "2"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func threeButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "3"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "3"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func fourButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "4"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "4"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func fiveButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "5"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "5"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func sixButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "6"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "6"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func sevenButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "7"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "7"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func eightButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "8"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "8"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func nineButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "9"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "9"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func zeroButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "0"}
        else{leftAmountLabel.text = leftAmountLabel.text! + "0"}
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func pmButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text == "0"){leftAmountLabel.text = "0"}
        else{
            let curText = leftAmountLabel.text
            if((curText?.contains("-"))!){
                let size = leftAmountLabel.text?.count
                let offset = size! - 1
                leftAmountLabel.text = String(leftAmountLabel.text!.suffix(offset))
            }
            else{
                leftAmountLabel.text = "-" + leftAmountLabel.text!
            }
        }
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func decButtonAction(_ sender: UIButton) {
        let curText = leftAmountLabel.text
        if(!(curText?.contains("."))!){
            leftAmountLabel.text = leftAmountLabel.text! + "."
        }
    }
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        leftAmountLabel.text = "0"
        rightAmountLabel.text = "0"
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        if(leftAmountLabel.text?.count == 1 || (leftAmountLabel.text?.count == 2 && (leftAmountLabel.text?.contains("-"))!)){
            leftAmountLabel.text = "0"
        }
        else{
            let size = (leftAmountLabel.text?.count)!
            let offset = size - 1
            let pre = String(leftAmountLabel.text!.prefix(offset))
            leftAmountLabel.text = pre
            
        }
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        
        convert(left: leftSelectedItem, right: rightSelectedItem)
    }
    @IBAction func swapButtonAction(_ sender: UIButton) {
        let leftInt = leftPickerView.selectedRow(inComponent: 0)
        let rightInt = rightPickerView.selectedRow(inComponent: 0)
        
        if(leftInt <= 5){
            rightPickerView.selectRow(leftInt, inComponent: 0, animated: true)
            leftPickerView.selectRow(rightInt, inComponent: 0, animated: true)
        }
        else if(leftInt <= 8){
            rightPickerView.selectRow(leftInt-6, inComponent: 0, animated: true)
            leftPickerView.selectRow(6+rightInt, inComponent: 0, animated: true)
        }
        else if(leftInt <= 10){
            rightPickerView.selectRow(leftInt-9, inComponent: 0, animated: true)
            leftPickerView.selectRow(9+rightInt, inComponent: 0, animated: true)
        }
        else if(leftInt <= 14){
            rightPickerView.selectRow(leftInt-11, inComponent: 0, animated: true)
            leftPickerView.selectRow(11+rightInt, inComponent: 0, animated: true)
            
        }
        else if(leftInt <= 16){
            rightPickerView.selectRow(leftInt-15, inComponent: 0, animated: true)
            leftPickerView.selectRow(15+rightInt, inComponent: 0, animated: true)
        }
        
        rightSelectedItem = rightItems[rightPickerView.selectedRow(inComponent: 0)]
        leftSelectedItem = leftItems[leftPickerView.selectedRow(inComponent: 0)]
        convert(left: leftSelectedItem, right: rightSelectedItem)

    }
    @IBAction func resetButtonAction(_ sender: UIButton) {
        rightItems = weightItems
        rightPickerView.reloadAllComponents()
        leftPickerView.selectRow(6, inComponent:0, animated:true)
        rightPickerView.selectRow(1, inComponent:0, animated:true)
        clearButtonAction(clearButton)
    }
    
}
