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
    var title = String()
    
    //parse json
    func funcJsonParse(jsonFile: String)
    {
        if let path = Bundle.main.path(forResource: jsonFile, ofType: "json")
        {
            do
            {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                //print(json as Any)
                guard let page = json.value(forKey: "page") as? NSDictionary else {
                    jsonStatus?("0")
                    return
                }
                
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
                    if parse.imageName == "posterthatismissing.jpg"
                    {
                        arrayImageName.append("placeholder_for_missing_posters.png")
                    }
                    else
                    {
                        arrayImageName.append(parse.imageName)
                    }
                    title = page.value(forKey: "title") as? String ?? "Title"
                    //print(parse.name,"url", parse.imageName)
                }
                //print("--------")
                jsonStatus?("1")
            
            }catch{
                //print("errr")
                jsonStatus?("0")
            }
        }
    }
}
