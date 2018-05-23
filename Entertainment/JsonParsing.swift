//
//  JsonParsing.swift
//  Entertainment
//
//  Created by Naveen Vijay on 23/05/18.
//  Copyright © 2018 Naveen Vijay. All rights reserved.
//

import Foundation

class jsonClass
{
    var jsonStatus: ((_ status: String) -> Void)?
    var arrayName = [String]()
    var arrayImageName = [String]()
    
    func funcJsonParse()
    {
        let path = Bundle.main.path(forResource: "CONTENTLISTINGPAGE-PAGE1", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
            //print(json as Any)
            guard let page = json.value(forKey: "page") as? NSDictionary else {
                jsonStatus?("0")
                return
            }
            //let page = json.value(forKey: "page") as! NSDictionary
            guard let contentitems = page.value(forKey: "content-items") as? NSDictionary else {
                jsonStatus?("0")
                return
            }
            for i in contentitems.value(forKey: "content") as! NSArray
            {
                guard let result = i as? NSDictionary else {
                    jsonStatus?("0")
                    return
                }
                let parse = parsedData(json: result as! [String : Any])
                arrayName.append(parse.name)
                arrayImageName.append(parse.imageName)
                //print(parse.name,"url", parse.imageName)
            }
            print("--------")
            jsonStatus?("1")
            
        } catch  {
            print("errr")
        }
    }
}
