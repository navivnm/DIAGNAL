//
//  CollectionViewData.swift
//  Entertainment
//
//  Created by Naveen Vijay on 23/05/18.
//  Copyright © 2018 Naveen Vijay. All rights reserved.
//

import Foundation

struct parsedData
{
    let name: String
    let imageName: String
    
    init(json: [String: Any])
    {
        name = json["name"] as? String ?? ""
        imageName = json["poster-image"] as? String ?? ""
    }
}
