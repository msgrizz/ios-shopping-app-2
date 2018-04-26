//
//  UpdateViewController.swift
//  PCShoppingApp
//
//  Created by user139368 on 4/25/18.
//  Copyright © 2018 user139368. All rights reserved.
//

import UIKit
import CoreData


class UpdateViewController: UIViewController {
    
    //var delegate: UpdateViewControllerDelegate?
    
    var updateitem: ProductEntity! = nil
    var updatepurchasedItems: ProductEntity! = nil
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var imgNames = ["FIGHTING","SPORT","PUZZLE","OPEN-WORLD","RPG","STRATEGY"]
    var itemType: String! = nil
    
    let alert = UIAlertController(title: "Oops!", message: "Please fill the form correctly.", preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
    }
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        if updateitem == nil {
            addItem()
        }
        else if updateitem != nil {
            updateitem.title = name.text
            updateitem.imageName = genreImages[myIndex]
            updateitem.price = Double(price.text!)!
            updateitem.quantity = Int32(quantity.text!)!
            do {
                try self.appDelegate.persistentContainer.viewContext.save()
            } catch {
                print("Error Updating")
            }
            
            updateItem()
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var name: UITextField!
    
  
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var quantity: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(genre[myIndex])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItem() {
        let itemTitle = name.text
        var itemImgName = genreImages[myIndex]
        let itemPrice = Double(price.text!)
        let itemQty = Int32(quantity.text!)
        
        if itemImgName == nil {
            itemImgName = "RPG"
        }
        
        if itemTitle == nil || itemPrice == nil || itemQty == nil {
            self.present(alert, animated: true, completion:nil)
        }else{
            print("This is happening")
            let productEntity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: appDelegate.persistentContainer.viewContext)
            let historyEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "HistoryEntity", in: self.appDelegate.persistentContainer.viewContext)
            
            let newProduct = NSManagedObject(entity: productEntity!, insertInto: appDelegate.persistentContainer.viewContext)
            
            newProduct.setValue(itemTitle, forKey: "title")
            newProduct.setValue(itemImgName, forKey: "imageName")
            newProduct.setValue(itemPrice, forKey: "price")
            newProduct.setValue(itemQty, forKey: "quantity")
            newProduct.setValue(false, forKey: "purchased")
            
            print(newProduct)
            do {
                print("This is here")
                try appDelegate.persistentContainer.viewContext.save()
            } catch {
                print("Error saving data")
            }
        }
    }
    
    func updateItem() {
        //delegate?.updateButtonPressed()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
