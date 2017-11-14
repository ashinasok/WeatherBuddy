//
//  weatherVC.swift
//  weatherBuddy
//
//  Created by Ashin Asok on 11/11/17.
//  Copyright © 2017 Ashin Asok. All rights reserved.
//

import UIKit

var place = "bangalore"

class weatherVC: UIViewController {
    
    var obj = weatherDataGet()
    var quo = quotes()
    var overlay : UIView?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var placeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.9
        
        view.addSubview(overlay!)
        activityIndicator.startAnimating()
        obj.getWeatherData {
            self.quotesSelect()
        }
    }

    
    func quotesSelect(){
        let condition = cond
        var index: Int!
        
        if UserDefaults.standard.object(forKey: "index") == nil{
            index = 0
        }
        else{
            index = UserDefaults.standard.object(forKey: "index") as! Int
            if index == 5{
                index = 0
            }
            else{
                index = index + 1
            }
        }
        UserDefaults.standard.set(index, forKey: "index")
        var element:[String:String] = [:]
        if condition == "Sunny" || condition == "Clear"
        {
            print("sunny")
            element = quo.sunny[index]
            weatherImage.image = UIImage(named: "clear_day")
        }
        else if condition == "Partly cloudy" || condition == "Cloudy" || condition == "Overcast"
        {
            print("cloudy")
            element = quo.cloudy[index]
            weatherImage.image = UIImage(named: "partly_cloudy_day")
        }
        else if condition == "Fog" || condition == "Freezing fog" || condition == "Blizzard" || condition == "Mist"
        {
            print("Fog")
            element = quo.fog[index]
            weatherImage.image = UIImage(named: "fog")

        }
        else if condition == "Patchy snow possible" || condition == "Patchy sleet possible" || condition == "Blowing snow" || condition == "Light sleet" || condition == "Moderate or heavy sleet" || condition == "Patchy light snow" ||
            condition == "Light snow" || condition == "Patchy moderate snow" || condition == "Moderate snow" ||
            condition == "Patchy heavy snow" || condition == "Heavy snow" || condition == "Ice pellets" || condition == "Patchy light snow with thunder" || condition == "Moderate or heavy snow with thunder"
        {
            print("snow")
            element = quo.snow[index]
            weatherImage.image = UIImage(named: "snow")
        }
        else
        {
            print("rain")
            element = quo.rain[index]
            weatherImage.image = UIImage(named: "rain")
        }
        
        activityIndicator.stopAnimating()
        overlay?.removeFromSuperview()
        
        firstLabel.text = element["firstLabel"]
        secondLabel.text = element["secondLabel"]
        thirdLabel.text = element["thirdLabel"]
        fourthLabel.text = element["fourthLabel"]
        subLabel.text = element["subLabel"]
        temperature.text = String(format: "%.0f", temp_c) + "°C"
        let highlight = element["highlightLabel"]
        
        firstLabel.textColor = UIColor.black
        secondLabel.textColor = UIColor.black
        thirdLabel.textColor = UIColor.black
        fourthLabel.textColor = UIColor.black
        
        if highlight == "secondLabel"{
            secondLabel.textColor = UIColor.blue
        }else if highlight == "thirdLabel"{
            thirdLabel.textColor = UIColor.blue
        }else if highlight == "firstLabel"{
            firstLabel.textColor = UIColor.blue
        }else{
            fourthLabel.textColor = UIColor.blue
        }
        
    }
    
    @IBAction func changePlace(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Change city", message: "Enter the name of city to be changed.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]// Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
            let newString = (textField?.text)!
            if newString != ""{
                let placeString = newString.capitalized
                self.activityIndicator.startAnimating()
                self.placeButton.setTitle(placeString, for: .normal)
                place = newString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            }
            self.viewWillAppear(true)
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
    }

}





