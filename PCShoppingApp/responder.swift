//
//  responder.swift
//  PCShoppingApp
//
//  Created by user139368 on 4/26/18.
//  Copyright © 2018 user139368. All rights reserved.
//

import UIKit

extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}
