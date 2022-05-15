//
//  SecondViewController.swift
//  jsonApiTest
//
//  Created by Şükrü Özkoca on 13.05.2022.
//

import UIKit

class SecondViewController: UIViewController {
    let api = "4d49d72c726270ba09ee6e631d6afc6a"
    @IBOutlet weak var currentLabel: UILabel!
    
    @IBOutlet weak var feelsLabel: UILabel!
    
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var viewCurrent: UIView!
    @IBOutlet weak var viewFeels: UIView!
    @IBOutlet weak var viewWind: UIView!
    var targetCoordinats1 = ""
    var targetCoordinats2 = ""
    
    
    var city = ""
    var country = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dataGet()
        viewLocation.layer.cornerRadius = 8
        viewLocation.layer.borderColor = UIColor.white.cgColor
        viewLocation.layer.borderWidth = 2
        
        viewCurrent.layer.cornerRadius = 25
        viewFeels.layer.cornerRadius = 25
        viewWind.layer.cornerRadius = 25
       
    }
    func dataGet() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(targetCoordinats1)&lon=\(targetCoordinats2)&appid=\(api)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                print("error!")
            }
            else{
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        
                        DispatchQueue.main.async {
                            //print(jsonResponse!["main"] as Any)
                            if let main = jsonResponse!["main"] as? [String:Any] {
                                if let temp = main["temp"] as? Double {
                                    self.currentLabel.text = String(Int(temp-272.15))
                                }
                                if let feels = main["feels_like"] as? Double {
                                    self.feelsLabel.text = String(Int(feels-272.15))
                                }
                            }
                            if let wind = jsonResponse!["wind"] as? [String:Any] {
                                if let speed = wind["speed"] as? Double{
                                    self.windLabel.text = String(Int(speed))
                                }
                            }
                            if let sys = jsonResponse!["sys"] as? [String:Any] {
                                if let countryGet = sys["country"] as? String{
                                    self.country = countryGet
                                    
                                }
                            }
                            if let cityGet = jsonResponse!["name"] as? String {
                                self.cityLabel.text = cityGet + "," + self.country
                            }
                            
                        }
                        
                    }
                    catch{
                        
                    }
                }
            }
            
        }
        task.resume()

 }
}
