//
//  HistoryViewController.swift
//  PCShoppingApp
//
//  Created by user139368 on 4/25/18.
//  Copyright © 2018 user139368. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var expensiveItem: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    var historyItems = [HistoryEntity]()

    
    @IBOutlet weak var tableView: UITableView!
    
     var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("History Log")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.fetchItems()
        print(historyItems.count)
        self.getCurrentlyPrice()
        self.getExpensiveItem()
        self.getItemCount()
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchItems()
        self.getCurrentlyPrice()
        self.getExpensiveItem()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchItems() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryEntity")
        //fetchRequest.predicate = NSPredicate(format: "isPurchased.purchased == false")
        do {
            if let results = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
                let fetchedItems: [HistoryEntity]? = results as? [HistoryEntity]
                if fetchedItems != nil {
                    historyItems = fetchedItems!
                }
            }
        }
        catch {
            fatalError("There was an error fetching the items")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryViewCell
        
        cell.productTitle.text = historyItems[indexPath.row].title
        cell.genreImage.image = UIImage(named: historyItems[indexPath.row].imageName!)
        cell.price.text = String(historyItems[indexPath.row].price)
        cell.quantity.text = String(historyItems[indexPath.row].quantity)
        
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item: HistoryEntity = historyItems[indexPath.row]
            let deleteObjectIndex: Int = indexPath.row
            historyItems.remove(at: deleteObjectIndex)
            self.tableView.deleteRows(at: [IndexPath(row: deleteObjectIndex, section: 0)], with: .automatic)
            self.appDelegate.persistentContainer.viewContext.delete(item)
            do {
                try self.appDelegate.persistentContainer.viewContext.save()
            } catch {
                print("Error Removing Item")
            }
            
        }
        getCurrentlyPrice()
        getExpensiveItem()
        getItemCount()
    }
    
    func getCurrentlyPrice() {
        let count = historyItems.count
        var current = 0.0
        for i in 0..<count{
            let a = Double(historyItems[i].price)
            let b = Double(historyItems[i].quantity)
            let itemsPrice = a * b
            current += itemsPrice
            currentPrice.text = String(current)
        }
    }
    
    func getExpensiveItem() {
        let count = historyItems.count
        var ePrice = 0.0
        var eTitle = ""
        if historyItems.count > 0{
            for i in 0..<count{
                if historyItems[i].price >= ePrice {
                    eTitle = historyItems[i].title!
                    ePrice = historyItems[i].price
                }
            }
        }
        
        expensiveItem.text = eTitle
    }
    
    func getItemCount() {
        let count = historyItems.count
        itemCount.text = String(count)
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
