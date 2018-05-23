//
//  ViewController.swift
//  Entertainment
//
//  Created by Naveen Vijay on 23/05/18.
//  Copyright © 2018 Naveen Vijay. All rights reserved.
//

import UIKit

/*struct parsedData: Decodable
{
    let name: String
    let imageName: String
    
    init(json: [String: Any])
    {
        name = json["name"] as? String ?? ""
        imageName = json["poster-image"] as? String ?? ""
    }
}*/

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate
{
    //var cellColor = true
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationName: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var jsonCall = jsonClass()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "nav_bar.png")
        navigationBar.setBackgroundImage(image, for: .default)
        
        funcJsonPath()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //json
    
    func funcJsonPath()
    {
        
        self.jsonCall.jsonStatus = {[weak self] (status: String) in
            print("****************", status)
            DispatchQueue.main.async {
                if status == "0"
                {
                    self?.funcAlert(title: "no data", message: "unable to find json")
                }
                else
                {
                    self?.funcAlert(title: "got data", message: "got json data")
                    for i in (self?.jsonCall.arrayImageName)!
                    {
                        print(i)
                    }
                }
            }
        }
        jsonCall.funcJsonParse()
        /*let path = Bundle.main.path(forResource: "CONTENTLISTINGPAGE-PAGE1", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
            //print(json as Any)
            guard let page = json.value(forKey: "page") as? NSDictionary else {
                return
            }
            //let page = json.value(forKey: "page") as! NSDictionary
            guard let contentitems = page.value(forKey: "content-items") as? NSDictionary else {
                return
            }
            for i in contentitems.value(forKey: "content") as! NSArray
            {
                guard let result = i as? NSDictionary else {
                    return
                }
                let parse = parsedData(json: result as! [String : Any])
                print(parse.name,"url", parse.imageName)
            }
        
        } catch  {
            print("errr")
        }*/
    }
    
    func funcAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    //collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return jsonCall.arrayName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let title = jsonCall.arrayName[indexPath.row]
        
        let image = UIImage(named: jsonCall.arrayImageName[indexPath.row])!
        cell.funcDisplayCollection(image: image, title: title)
        //cell.backgroundColor = cellColor ? .red : .blue
        //cellColor = !cellColor
        return cell
    }
}

