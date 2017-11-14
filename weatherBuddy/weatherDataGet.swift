//
//  weatherDataGet.swift
//  weatherBuddy
//
//  Created by Ashin Asok on 12/11/17.
//  Copyright © 2017 Ashin Asok. All rights reserved.
//

import Foundation

var cond: String!
var temp_c: Double!

class weatherDataGet{
    
    func getWeatherData(completionHandler:@escaping ()->Void){
        let urlLink = "http://api.apixu.com/v1/current.json?key=7bc4186cc8054f2a923111234170611&q=" + place
        let url = URL(string: urlLink)!
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    let current = json["current"] as! [String: AnyObject]
                    temp_c = current["temp_c"] as! Double
                    let condition = current["condition"] as! [String: AnyObject]
                    let searchTerm = condition["text"] as! String
                    cond = searchTerm
                    print(searchTerm)
                    completionHandler()
                    
                }catch{
                    print(error)
                }
                
            }
        }
        session.resume()
        
       
    }

}
