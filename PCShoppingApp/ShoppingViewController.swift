//
//  ShoppingViewController.swift
//  PCShoppingApp
//
//  Created by user139368 on 4/25/18.
//  Copyright © 2018 user139368. All rights reserved.
//

import UIKit
import CoreData

var items: [ProductEntity] = []
class ShoppingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var currentPrice: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ShoppingTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? ShoppingTableViewCell
        
        if cell == nil {
            cell = ShoppingTableViewCell(style: .default, reuseIdentifier: "itemCell")
        }
        
        let item: ProductEntity = items[indexPath.row]
        cell!.productName.text = item.title
        cell!.genreImage.image = UIImage(named: item.imageName!)
        cell!.priceValue.text = String(item.price)
        cell!.quantity.text = String(item.quantity)
        
        return cell!
    }
    
    
    var purchasedItems: [ProductEntity] = []
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currentlyPrice: Double = 0.0
    var totallyPrice: Double = 0.0
    var totallyQty: Int = 0
    var ePrice: Double = 0.0
    var eTitle: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.fetchItems()
        //self.fetchPurchasedItems()
        self.getCurrentlyPrice()
        self.getTotallyPrice()
        self.getTotallyQty()
        self.getExpensiveItem()
        self.tableView.estimatedRowHeight = 100
        print("Jaaaak")
        print(items)
        
        //let refreshControl = UIRefreshControl()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Hello")
        print(items)
        self.fetchItems()
        self.getTotallyQty()
        self.getTotallyPrice()
        self.getCurrentlyPrice()
        tableView.reloadData()
    }
    
    func fetchItems() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        //fetchRequest.predicate = NSPredicate(format: "isPurchased.purchased == false")
        do {
            if let results = try self.appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
                let fetchedItems: [ProductEntity]? = results as? [ProductEntity]
                if fetchedItems != nil {
                    items = fetchedItems!
                }
            }
        }
        catch {
            fatalError("There was an error fetching the items")
        }
    }
    
//    func fetchPurchasedItems() {
//        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
//        //fetchRequest.predicate = NSPredicate(format: "isPurchased.purchased == true")
//        do {
//            if let results = try self.appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
//                let fetchedItems: [ProductEntity]? = results as? [ProductEntity]
//                if fetchedItems != nil {
//                    self.purchasedItems = fetchedItems!
//                }
//            }
//        }
//        catch {
//            fatalError("There was an error fetching the items")
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello ",items[indexPath.row].title)
    }
    func getCurrentlyPrice() {
        let count = items.count
        currentlyPrice = 0.0
        for i in 0..<count{
            let a = Double(items[i].price)
            let b = Double(items[i].quantity)
            let itemsPrice = a * b
            currentlyPrice += itemsPrice
            currentPrice.text = String(currentlyPrice)
        }
    }
    
    func getTotallyPrice() {
        let count = purchasedItems.count
        totallyPrice = 0.0
        for i in 0..<count{
            let a = Double(purchasedItems[i].price)
            let b = Double(purchasedItems[i].quantity)
            let purchaseditemsPrice = a * b
            totallyPrice += purchaseditemsPrice
        }
    }
    
    func getTotallyQty() {
        let count = purchasedItems.count
        totallyQty = 0
        for i in 0..<count{
            let qty = Int(purchasedItems[i].quantity)
            totallyQty += qty
        }
    }
    
    func getExpensiveItem() {
        let count = purchasedItems.count
        ePrice = 0.0
        eTitle = ""
        if purchasedItems.count > 0{
            for i in 0..<count{
                if purchasedItems[i].price >= ePrice {
                    eTitle = purchasedItems[i].title!
                    ePrice = purchasedItems[i].price
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item: ProductEntity = items[indexPath.row]
            let deleteObjectIndex: Int = indexPath.row
            items.remove(at: deleteObjectIndex)
            self.tableView.deleteRows(at: [IndexPath(row: deleteObjectIndex, section: 0)], with: .automatic)
            self.appDelegate.persistentContainer.viewContext.delete(item)
            do {
                try self.appDelegate.persistentContainer.viewContext.save()
            } catch {
                print("Error Removing Item")
            }
            
        }
        getCurrentlyPrice()
        getTotallyPrice()
        getTotallyQty()
        getExpensiveItem()
        
        if(items.count == 0) {
           currentPrice.text = "0"
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
