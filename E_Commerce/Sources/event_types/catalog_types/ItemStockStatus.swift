//
//  ItemStockStatus.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation
import CasualFoundryCore


public enum ItemStockStatus: String,EnumComposable {
    case inStock = "in_stock"
    case lowStock = "low_stock"
    case outOfStock = "out_of_stock"
}
