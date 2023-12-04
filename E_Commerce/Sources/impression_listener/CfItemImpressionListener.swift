//
//  CfItemImpressionListener.swift
//
//
//  Created by khushbu on 02/11/23.
//
import Foundation
import UIKit
import CasualFoundryCore

public class CfItemImpressionListener {
    private static var usdRateValue: Float = 1.0
    private static var recyclerViewValue: UICollectionView!
    private static var currentDataProviderValue: [ItemImpressionModel] = []
    private static var searchIdValue: String = ""
    private static var collectionViewId: String = ""
    
    class func trackRecyclerView(_ recyclerView: UICollectionView, currentDataProvider: @escaping () -> [ItemImpressionModel], searchId: String) {
        recyclerViewValue = recyclerView
        currentDataProviderValue = currentDataProvider()
        searchIdValue = searchId
        
        if currentDataProviderValue[0].item_properties.currency != InternalCurrencyCode.USD.rawValue {
            CFSetup().getUSDRate(fromCurrency: currentDataProviderValue[0].item_properties.currency, callback: { usdRate in
                self.getUSDRateAndLogEvent(usdRate)
                return usdRate
            })
        } else {
            callCoreImpressionListenerTrackRecyclerView()
        }
    }
    
    class private func callCoreImpressionListenerTrackRecyclerView() {

//        let recyclerImpressionArray:[RecyclerImpressionModel]? = currentDataProviderValue.map { itemImpression in
//            return RecyclerImpressionModel(
//                element_id: itemImpression.item_properties.id!,
//                content_block: ECommerceConstants.contentBlockName,
//                event_name: EComEventType.item.rawValue,
//                catalog_subject: itemImpression.item_properties.type!,
//                item_properties: ViewItemObject(
//                    action: ItemAction.impression.rawValue,
//                    item: itemImpression.item_properties,
//                    search_id: searchIdValue,
//                    usd_rate: usdRateValue,
//                    meta: nil
//                ),
//                catalog_properties: prepareCatalogObject(
//                    itemImpression.item_properties.id!,
//                    itemImpression.item_properties.type!,
//                    itemImpression.catalog_properties
//                )
//            )
//        }
        
//                CfCoreImpressionListener.trackRecyclerView(
//                                    recyclerView: recyclerViewValue,
//                                    currentDataProvider: {
//                                        return recyclerImpressionModels
//                                    },
//                                    searchId: searchIdValue,
//                                    userData: nil
//                                )
    }
    
    
    class private func getUSDRateAndLogEvent(_ usdRate: Float) {
        usdRateValue = usdRate
        callCoreImpressionListenerTrackRecyclerView()
    }
    
    class private func prepareCatalogObject(_ itemId: String, _ itemType: String, _ catalogModel: Any?) -> Any? {
        
        if let drugCatalog = catalogModel as? DrugCatalogModel {
            return ECommerceConstants.verifyCatalogForDrug(drugId: itemId, drugCatalogModel:drugCatalog)
        }else if let grocerryCatalog = catalogModel as? GroceryCatalogModel {
            return ECommerceConstants.verifyCatalogForGrocery(itemId: itemId, groceryCatalogModel: grocerryCatalog)
        }else if let facilityCatalog =  catalogModel as? FacilityCatalogModel {
            return ECommerceConstants.verifyCatalogForFacility(facilityId: itemId, facilityCatalogModel: facilityCatalog)
        }else if let bloodCatalog = catalogModel as? BloodCatalogModel {
            return ECommerceConstants.verifyCatalogForBlood(itemId:itemId , bloodCatalogModel: bloodCatalog)
        }else if let oxygenCatalog = catalogModel as? OxygenCatalogModel {
            return ECommerceConstants.verifyCatalogForOxygen(itemId: itemId, oxygenCatalogModel: oxygenCatalog)
        }else if let medicalEquipmentCatalog =  catalogModel as? MedicalEquipmentCatalogModel {
            return ECommerceConstants.verifyCatalogForMedicalEquipment(itemId: itemId,medicalEquipmentCatalogModel: medicalEquipmentCatalog)
        }else {
            return nil
        }
        
        
    }
    
    
    class func startTrackingForJavaClass(_ recyclerView: UICollectionView, currentDataProvider: @escaping () -> [ItemImpressionModel], searchId: String) {
        trackRecyclerView(recyclerView, currentDataProvider: currentDataProvider, searchId: searchId)
    }
    
    class func onCollectionUpdated(collectionViewKey: String, searchId: String, currentDataProvider: [ItemImpressionModel]) {
        currentDataProviderValue = currentDataProvider
        searchIdValue = searchId
        collectionViewId = collectionViewKey
        
        if currentDataProvider[0].item_properties.currency != InternalCurrencyCode.USD.rawValue {
            CFSetup().getUSDRate(fromCurrency: currentDataProvider[0].item_properties.currency, callback: { usdRate in
                getUSDRateAndLogRNEvent(usdRate)
                return usdRate
            })
        } else {
            callCoreCollectionUpdated()
        }
    }
    
    class func onCollectionUpdatedRN(collectionViewKey: String, searchId: String, currentDataProvider: String) {
        let data = currentDataProvider.data(using: .utf8)!
        let itemModels = try! JSONDecoder().decode([ItemImpressionModel].self, from: data)
        var itemList = itemModels.map { item in
            var mutableItem = item
            do {
                switch item.item_properties.type {
                case ItemType.drug.rawValue:
                    mutableItem.catalog_properties =  item.catalog_properties as? DrugCatalogModel
                case ItemType.grocery.rawValue:
                    mutableItem.catalog_properties =  item.catalog_properties as? GroceryCatalogModel
                case ItemType.facility.rawValue:
                    mutableItem.catalog_properties =  item.catalog_properties as? FacilityCatalogModel
                case ItemType.blood.rawValue:
                    mutableItem.catalog_properties =  item.catalog_properties as? BloodCatalogModel
                case ItemType.oxygen.rawValue:
                    mutableItem.catalog_properties =  item.catalog_properties as? OxygenCatalogModel
                case ItemType.medicalEquipment.rawValue:
                    mutableItem.catalog_properties =  item.catalog_properties as? MedicalEquipmentCatalogModel
                default:
                    throw NSError(domain: "impression_listener", code: 1, userInfo: ["reason": "Invalid catalog object provided"])
                }
                ECommerceConstants.isItemValueObjectValid(itemValue: item.item_properties, eventType: EComEventType.item)
            } catch {
                print(error)
            }
            return mutableItem
        }
        currentDataProviderValue = itemList
        searchIdValue = searchId
        collectionViewId = collectionViewKey
        
        if !itemList.isEmpty {
            if itemList[0].item_properties.currency != InternalCurrencyCode.USD.rawValue {
                CFSetup().getUSDRate(fromCurrency: itemList[0].item_properties.currency, callback: { usdRate in
                    getUSDRateAndLogRNEvent(usdRate)
                    return usdRate
                })
            } else {
                callCoreCollectionUpdated()
            }
        }
    }
    
    class private func getUSDRateAndLogRNEvent(_ usdRate: Float) {
        usdRateValue = usdRate
        callCoreCollectionUpdated()
    }
    
    class private func callCoreCollectionUpdated() {
//        let recyclerImpressionArray:[RecyclerImpressionModel]? = currentDataProviderValue.map { itemImpression in
//            return RecyclerImpressionModel(
//                element_id: itemImpression.item_properties.id!,
//                content_block: ECommerceConstants.contentBlockName,
//                event_name: EComEventType.item.rawValue,
//                catalog_subject: itemImpression.item_properties.type!,
//                item_properties: ViewItemObject(
//                    action: ItemAction.impression.rawValue,
//                    item: itemImpression.item_properties,
//                    search_id: searchIdValue,
//                    usd_rate: usdRateValue,
//                    meta: nil
//                ),
//                catalog_properties: prepareCatalogObject(
//                    itemImpression.item_properties.id!,
//                    itemImpression.item_properties.type!,
//                    itemImpression.catalog_properties
//                )
//            )
//        }
//        CfCoreImpressionListener.onCollectionUpdated(collectionView: nil, collectionViewKey: collectionViewId, searchId: searchIdValue, currentDataProvider: recyclerImpressionModels, userData: nil)
    }
}
