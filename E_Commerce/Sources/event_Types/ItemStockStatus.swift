//
//  ItemStockStatus.swift
//
//
//  Created by khushbu on 27/10/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum ItemStockStatus: String, EnumComposable {
    case inStock = "in_stock"
    case lowStock = "low_stock"
    case outOfStock = "out_of_stock"
}
