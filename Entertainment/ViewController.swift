//
//  ViewController.swift
//  Entertainment
//
//  Created by Naveen Vijay on 23/05/18.
//  Copyright © 2018 Naveen Vijay. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate
{
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationName: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewItemInfo: UIView!
    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var labelInfo: UILabel!
    
    var jsonCall = jsonClass()
    var callCount = 0
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

    //back button action
    @IBAction func btnBackAction(_ sender: Any)
    {
        //hide viewinfo
        if viewItemInfo.isHidden == false
        {
            navigationName.title = jsonCall.title
            viewItemInfo.isHidden = true
        }
    }
    
    //json cal
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
                    self?.collectionView.reloadData()
                    self?.navigationName.title = self?.jsonCall.title
                    //self?.funcAlert(title: "got data", message: "got json data")
                    /*for i in (self?.jsonCall.arrayImageName)!
                    {
                        print(i)
                    }*/
                }
            }
        }
        
        switch callCount
        {
            case 0:
                jsonCall.funcJsonParse(jsonFile: "CONTENTLISTINGPAGE-PAGE1")
            case 1:
                jsonCall.funcJsonParse(jsonFile: "CONTENTLISTINGPAGE-PAGE2")
            case 2:
                jsonCall.funcJsonParse(jsonFile: "CONTENTLISTINGPAGE-PAGE3")
            //case 3:
              //  callCount = 0
            default:
                break
        }
        callCount = callCount + 1
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
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        
        if indexPath.row == jsonCall.arrayImageName.count - 1
        {
            print(indexPath.row)
            funcJsonPath()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(jsonCall.arrayName[indexPath.row],jsonCall.arrayImageName[indexPath.row])
        viewItemInfo.isHidden = false
        imageInfo.image = UIImage(named: jsonCall.arrayImageName[indexPath.row])
        let temp = jsonCall.arrayName[indexPath.row]
        labelInfo.text = temp
        navigationName.title = temp
    }
}

