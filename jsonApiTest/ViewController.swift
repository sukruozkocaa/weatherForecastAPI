//
//  ViewController.swift
//  jsonApiTest
//
//  Created by Şükrü Özkoca on 12.05.2022.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let picker = UIPickerView()
    let citys = ["İstanbul","Ankara","İzmir","Elazığ"]
    let coordinats1 = ["41.010260","39.907287","38.407369","38.447187"]
    let coordinats2 = ["28.972721","32.894815","26.9396337","39.309582"]
    
    var selectedCountry = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citys.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citys[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewText.text = citys[row]
        selectedCountry = String(pickerViewText.text!)
    }
    
    
    
    @IBOutlet weak var pickerViewText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather API"
        
        pickerViewText.layer.borderColor = UIColor.orange.cgColor
        pickerViewText.layer.borderWidth
        pickerViewText.layer.cornerRadius = 10
      
        picker.delegate = self
        picker.dataSource = self
        pickerViewText.inputView = picker
        pickerToolbar()
    }
    
    @IBAction func getClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    func pickerToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        pickerViewText.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.done, target: self, action: #selector(dissMiss))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func dissMiss() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destination = segue.destination as! SecondViewController
            if selectedCountry == "İstanbul" {
                destination.targetCoordinats1 = coordinats1[0]
                destination.targetCoordinats2 = coordinats2[0]
            }
            else if selectedCountry == "Ankara" {
                destination.targetCoordinats1 = coordinats1[1]
                destination.targetCoordinats2 = coordinats2[1]
            }
            else if selectedCountry == "İzmir" {
                destination.targetCoordinats1 = coordinats1[2]
                destination.targetCoordinats2 = coordinats2[2]
            }
            else {
                destination.targetCoordinats1 = coordinats1[3]
                destination.targetCoordinats2 = coordinats2[3]
            }
        }
    }
        
}
    
   
    




