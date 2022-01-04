//
//  QuickfindViewController.swift
//  MPIFormulas
//
//  Created by Matt Dahl on 8/10/19.
//  Copyright © 2019 mattMakes. All rights reserved.
//

import UIKit


class QuickfindViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var cardTableView: UITableView!
    
    let pictures: [UIImage] = [UIImage(named: "convertIcon.png")!, UIImage(named: "newRulerIcon.png")!, UIImage(named: "paperIcon.png")!, UIImage(named: "bill2.png")!]
    let labels0: [String] = ["Microns", "Mils", "Centimeters", "Inches", "Feet", "Meters", "Pounds", "Kilograms", "Metric Tonnes", "Farenheit", "Celcius", "Square Centimeters", "Square Inches", "Square Meters", "MSF", "Pounds/Ream", "GSM"]
    let labels1: [String] = ["Pounds (from Length)", "MSF (from Length)", "Linear Feet", "Linear Yards", "Square Inches", "Square Feet", "Square Yards", "MSI (from Weight)", "MSF (from Weight)", "Pounds (from Area)", "Kilograms", "MSF (from Area)", "Square Yards (from MSF)", "MSI (from MSF)"]
    let labels2: [String] = ["Linear Feet on a 3\" Core", "Linear Feet on a 6\" Core", "Linear Meters on a 6\" Core", "Diameter on a 3\" Core", "Diameter on a 6\" Core", "Roll Weight in Pounds"]
    let labels3: [String] = ["Price Test1", "Price Test2"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Conversions"
        }
        else if(section == 1){
            return "Measurements"
        }
        else if(section == 2){
            return "Diameters"
        }
        else if(section == 3){
            return "Pricing"
        }
        else{
            return "ERROR"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return labels0.count
        }
        else if(section == 1){
            return labels1.count
        }
        else if(section == 2){
            return labels2.count
        }
        else if(section == 3){
            return labels3.count
        }
        else{
            return labels0.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardCell
        if(indexPath.section == 0){
            cell.configure(picture: pictures[0], title: labels0[indexPath.row])
        }
        else if(indexPath.section == 1){
            cell.configure(picture: pictures[1], title: labels1[indexPath.row])
        }
        else if(indexPath.section == 2){
            cell.configure(picture: pictures[2], title: labels2[indexPath.row])
        }
        else if(indexPath.section == 3){
            cell.configure(picture: pictures[3], title: labels3[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            let index = indexPath.row
            //leftSpinner, rightSpinner
            if(index == 0){tabSwitchDataPass = "00 00"}
            else if(index == 1){tabSwitchDataPass = "00 01"}
            else if(index == 2){tabSwitchDataPass = "00 02"}
            else if(index == 3){tabSwitchDataPass = "00 03"}
            else if(index == 4){tabSwitchDataPass = "00 04"}
            else if(index == 5){tabSwitchDataPass = "00 05"}
            else if(index == 6){tabSwitchDataPass = "06 00"}
            else if(index == 7){tabSwitchDataPass = "06 01"}
            else if(index == 8){tabSwitchDataPass = "06 02"}
            else if(index == 9){tabSwitchDataPass = "09 00"}
            else if(index == 10){tabSwitchDataPass = "09 01"}
            else if(index == 11){tabSwitchDataPass = "11 00"}
            else if(index == 12){tabSwitchDataPass = "11 01"}
            else if(index == 13){tabSwitchDataPass = "11 02"}
            else if(index == 14){tabSwitchDataPass = "11 03"}
            else if(index == 15){tabSwitchDataPass = "15 00"}
            else if(index == 16){tabSwitchDataPass = "15 01"}
            self.tabBarController?.selectedIndex = 0
        }
        else if(indexPath.section == 1){
            let index = indexPath.row
            //Segment, firstSpinner, centerSpinner, rightspinner
            if(index == 0)     {tabSwitchDataPass = "00 00 00 00"}
            else if(index == 1){tabSwitchDataPass = "00 00 00 01"}
            else if(index == 2){tabSwitchDataPass = "00 02 00 00"}
            else if(index == 3){tabSwitchDataPass = "00 02 00 01"}
                
            else if(index == 4){tabSwitchDataPass = "01 00 00 00"}
            else if(index == 5){tabSwitchDataPass = "01 00 00 01"}
            else if(index == 6){tabSwitchDataPass = "01 00 00 02"}
            else if(index == 7){tabSwitchDataPass = "01 00 00 03"}
            else if(index == 8){tabSwitchDataPass = "01 00 00 04"}
            else if(index == 9){tabSwitchDataPass = "01 02 00 00"}
            else if(index == 10){tabSwitchDataPass = "01 02 00 01"}
            else if(index == 11){tabSwitchDataPass = "01 02 00 02"}
            else if(index == 12){tabSwitchDataPass = "01 06 00 02"}
            else if(index == 13){tabSwitchDataPass = "01 06 00 03"}

            self.tabBarController?.selectedIndex = 1
        }
        else if(indexPath.section == 2){
            let index = indexPath.row
            //Segment, firstSpinner, centerSpinner, rightspinner
            if(index == 0)     {tabSwitchDataPass = "00 00 00"}
            else if(index == 1){tabSwitchDataPass = "00 00 01"}
            else if(index == 2){tabSwitchDataPass = "00 00 02"}
            else if(index == 3){tabSwitchDataPass = "01 00 00"}
            else if(index == 4){tabSwitchDataPass = "01 00 01"}
            else if(index == 5){tabSwitchDataPass = "01 01 00"}
            self.tabBarController?.selectedIndex = 2
        }
        else if(indexPath.section == 3){
            self.tabBarController?.selectedIndex = 3
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }


    

    
}
