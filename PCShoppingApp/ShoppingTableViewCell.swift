//
//  ShoppingTableViewCell.swift
//  PCShoppingApp
//
//  Created by user139368 on 4/25/18.
//  Copyright © 2018 user139368. All rights reserved.
//

import UIKit
import CoreData
extension UITableViewCell {
    
    var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}


class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var genreImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var priceValue: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
     var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func buy(_ sender: UIButton) {
        let title = items[(indexPath?.row)!].title
        let price = items[(indexPath?.row)!].price
        let quantity = items[(indexPath?.row)!].quantity
        let imageName = items[(indexPath?.row)!].imageName
        
        let historyEntity = NSEntityDescription.entity(forEntityName: "HistoryEntity", in: appDelegate.persistentContainer.viewContext)
        
        let newProduct = NSManagedObject(entity: historyEntity!, insertInto: appDelegate.persistentContainer.viewContext)
        
        newProduct.setValue(title, forKey: "title")
        newProduct.setValue(imageName, forKey: "imageName")
        newProduct.setValue(price, forKey: "price")
        newProduct.setValue(quantity, forKey: "quantity")
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
        } catch {
            print("Error in Saving")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
