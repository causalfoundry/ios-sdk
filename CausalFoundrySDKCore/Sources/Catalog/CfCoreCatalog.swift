//
//  CfCoreCatalog.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation

public class CfCoreCatalog {
    //////////////////////////////////////////////////////
    // User Catalog
    //////////////////////////////////////////////////////

    public static func updateUserCatalog(appUserId: String, userCatalogModelString: String) {
        if let data = userCatalogModelString.data(using: .utf8),
           let catalogItem = try? JSONDecoder.new.decode(UserCatalogModel.self, from: data)
        {
            CfCoreCatalog.updateUserCatalogData(appUserId: appUserId, userCatalogModel: catalogItem)
        }
        return
    }

    public static func updateUserCatalogData(appUserId: String, userCatalogModel: UserCatalogModel) {
        let catalogName = "\(CatalogSubject.user.rawValue) catalog"

        if appUserId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "User Id")
        }

        if (!userCatalogModel.country.isEmpty && !CoreConstants.shared.enumContains(CountryCode.self, name: userCatalogModel.country))
        {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: CfCoreCatalog.self))
        }

        if (!userCatalogModel.language.isEmpty && !CoreConstants.shared.enumContains(LanguageCode.self, name: userCatalogModel.language))
        {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: CfCoreCatalog.self))
        }

        if (!userCatalogModel.education_level.isEmpty && !CoreConstants.shared.enumContains(EducationalLevel.self, name: userCatalogModel.education_level))
        {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: CfCoreCatalog.self))
        }

        let userCatalogModelItem: UserCatalogModel? = MMKVHelper.shared.readUserCatalog()
        if userCatalogModel != userCatalogModelItem {
            let internalUserModel = InternalUserModel(
                id: appUserId,
                name: userCatalogModel.name,
                country: userCatalogModel.country,
                region_state: userCatalogModel.region_state,
                city: userCatalogModel.city,
                workplace: userCatalogModel.workplace,
                profession: userCatalogModel.profession,
                zipcode: userCatalogModel.zipcode,
                language: userCatalogModel.language,
                experience: userCatalogModel.experience,
                education_level: userCatalogModel.education_level,
                timezone: CoreConstants.shared.getUserTimeZone(),
                organization_id: userCatalogModel.organization_id,
                organization_name: userCatalogModel.organization_name
            )
            MMKVHelper.shared.writeUserCatalog(userCataLogData: userCatalogModel)
            CFSetup().updateCoreCatalogItem(subject: CatalogSubject.user, catalogObject: [internalUserModel].toData()!)
        }
    }
}
