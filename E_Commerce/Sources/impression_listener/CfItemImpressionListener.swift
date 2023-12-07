//
//  CfItemImpressionListener.swift
//
//
//  Created by khushbu on 02/11/23.
//
import CasualFoundryCore
import Foundation
import UIKit

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
//        callCoreImpressionListenerTrackRecyclerView()

    }

    private class func callCoreImpressionListenerTrackRecyclerView() {
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


    private class func prepareCatalogObject(_ itemId: String, _: String, _ catalogModel: Any?) -> Any? {
        if let drugCatalog = catalogModel as? DrugCatalogModel {
            return ECommerceConstants.verifyCatalogForDrug(drugId: itemId, drugCatalogModel: drugCatalog)
        } else if let grocerryCatalog = catalogModel as? GroceryCatalogModel {
            return ECommerceConstants.verifyCatalogForGrocery(itemId: itemId, groceryCatalogModel: grocerryCatalog)
        } else if let facilityCatalog = catalogModel as? FacilityCatalogModel {
            return ECommerceConstants.verifyCatalogForFacility(facilityId: itemId, facilityCatalogModel: facilityCatalog)
        } else if let bloodCatalog = catalogModel as? BloodCatalogModel {
            return ECommerceConstants.verifyCatalogForBlood(itemId: itemId, bloodCatalogModel: bloodCatalog)
        } else if let oxygenCatalog = catalogModel as? OxygenCatalogModel {
            return ECommerceConstants.verifyCatalogForOxygen(itemId: itemId, oxygenCatalogModel: oxygenCatalog)
        } else if let medicalEquipmentCatalog = catalogModel as? MedicalEquipmentCatalogModel {
            return ECommerceConstants.verifyCatalogForMedicalEquipment(itemId: itemId, medicalEquipmentCatalogModel: medicalEquipmentCatalog)
        } else {
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
    }

    class func onCollectionUpdatedRN(collectionViewKey: String, searchId: String, currentDataProvider: String) {
        let data = currentDataProvider.data(using: .utf8)!
        let itemModels = try! JSONDecoder.new.decode([ItemImpressionModel].self, from: data)
        var itemList = itemModels.map { item in
            var mutableItem = item
            do {
                switch item.itemProperties.type {
                case ItemType.drug.rawValue:
                    mutableItem.catalogProperties = item.catalogProperties as? DrugCatalogModel
                case ItemType.grocery.rawValue:
                    mutableItem.catalogProperties = item.catalogProperties as? GroceryCatalogModel
                case ItemType.facility.rawValue:
                    mutableItem.catalogProperties = item.catalogProperties as? FacilityCatalogModel
                case ItemType.blood.rawValue:
                    mutableItem.catalogProperties = item.catalogProperties as? BloodCatalogModel
                case ItemType.oxygen.rawValue:
                    mutableItem.catalogProperties = item.catalogProperties as? OxygenCatalogModel
                case ItemType.medicalEquipment.rawValue:
                    mutableItem.catalogProperties = item.catalogProperties as? MedicalEquipmentCatalogModel
                default:
                    throw NSError(domain: "impression_listener", code: 1, userInfo: ["reason": "Invalid catalog object provided"])
                }
                ECommerceConstants.isItemValueObjectValid(itemValue: item.itemProperties, eventType: EComEventType.item)
            } catch {
                print(error)
            }
            return mutableItem
        }
        currentDataProviderValue = itemList
        searchIdValue = searchId
        collectionViewId = collectionViewKey
    }

}
