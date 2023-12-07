//
//  CfLogSearchEvent.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

public class CfLogSearchEvent {
    var searchId: String = UUID().uuidString
    var queryText: String?
    var resultsList: [SearchItemModel] = []
    var filterValue: Any?
    var searchModule: String = SearchModuleType.core.rawValue
    var contentBlock: String = CoreConstants.shared.contentBlockName
    var pageValue: Int = 1
    var isNewSearch: Bool = true
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately
}

/**
 * CfLogSearchEvent is used to log search related events. It supports all the module
 * available by CF i.e. core, e-learning, e-commerce etc. You also need to log the
 * Ids in the form of string list to log what results are returned by the search and
 * in case of no result found, you can log with an empty list.
 * Search also supports filters if any applied to the search by the user which are
 * supported in the app. You can provide these filters in the form of hashMap.
 */

// MARK: - Builder

public class CfLogSearchEventBuilder {
    var searchId: String = UUID().uuidString
    var queryText: String?
    var resultsList: [SearchItemModel] = []
    var filterValue: Any?
    var searchModule: String = SearchModuleType.core.rawValue
    var contentBlock: String = CoreConstants.shared.contentBlockName
    var pageValue: Int = 1
    var isNewSearch: Bool = true
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setQuery is required to log the actual search query by the user for which the
     * results are obtained.
     */

    public func setQuery(query: String) -> CfLogSearchEventBuilder {
        queryText = query
        return self
    }

    /**
     * setContentBlock is used to specify the type of module the search is applied to.
     * Search can be used for multiple modules i.e. core, e-commerce, e-learning, ...
     * SDK provides enum ContentBlockType to log the module, you can also use string function as
     * well in order to log the content block type. Below is the function for the usage of enum
     * type function.
     */
    public func setContentBlock(contentBlock: ContentBlock) -> CfLogSearchEventBuilder {
        self.contentBlock = contentBlock.rawValue
        return self
    }

    /**
     * setContentBlock is used to specify the type of module the search is applied to.
     * Search can be used for multiple modules i.e. core, e-commerce, e-learning, ...
     * SDK provides enum ContentBlockType to log the module, you can also use string function as
     * well in order to log the content block type. Below is the function for the usage of
     * content block type function. Remember to note that you need to use the same enum types
     * as provided by the enums or else the events will be discarded.
     */

    public func setContentBlock(content_block: String) -> CfLogSearchEventBuilder {
        if ContentBlock.allCases.filter({ $0.rawValue == content_block }).first != nil {
            contentBlock = content_block
        } else {
            ExceptionManager.throwEnumException(eventType: CoreEventType.search.rawValue, className: "ContentBlock")
        }

        return self
    }

    /**
     * setChwModuleEvent is for the providing the current module selected by the
     * user in the chw mgmt section on the main screen. You can use the default enum
     * provided in the SDK and can also use the string. Below is the function with
     * an enum as param.
     */

    public func setSearchModule(searchModule: SearchModuleType) -> CfLogSearchEventBuilder {
        self.searchModule = searchModule.rawValue
        return self
    }

    /**
     * setChwModuleEvent is for the providing the current module selected by the
     * user in the chw mgmt section on the main screen. You can use the default enum
     * provided in the SDK and can also use the string. Below is the function with
     * an string as param.
     */

    public func setSearchModule(searchModule: String) -> CfLogSearchEventBuilder {
        if ContentBlock.allCases.filter({ $0.rawValue == searchModule }).first != nil {
            self.searchModule = searchModule
        } else {
            ExceptionManager.throwEnumException(eventType: CoreEventType.search.rawValue, className: "SearchModuleType")
        }
        return self
    }

    /**
     * addResultItem is used to log the result ids returned by the search. Below is the
     * function for the Search Item Object type values with SearchItemModel(itemId, itemType).
     */

    public func addResultItem(resultsObject: SearchItemModel) -> CfLogSearchEventBuilder {
        resultsList.append(resultsObject)
        return self
    }

    /**
     * setResultItemsList is used to log the result ids returned by the search. It can be empty
     * in case of no results returned but should not be null in any case. This function
     * can be used with multiple formats based on the development format, You can either use
     * List or Array List or to pass in React Native specified format as well. Below is the
     * function for the ArrayList type values with SearchItemModel(itemId, itemType).
     */

    public func setResultItemsList(resultsList: [SearchItemModel]) -> CfLogSearchEventBuilder {
        self.resultsList = resultsList
        return self
    }

    /**
     * setResultItemsList is used to log the result ids returned by the search. It can be empty
     * in case of no results returned but should not be null in any case. This function
     * can be used with multiple formats based on the development format, You can either use
     * List or Array List or to pass in React Native specified format as well. Below is the
     * function for the Any type values which represents Object type in Java specifically
     * available for ReactNative Bridge.
     */

    public func setResultItemsList(resultsList: String) -> CfLogSearchEventBuilder {
        self.resultsList.removeAll()
        if !resultsList.isEmpty {
            if let itemModels = try? JSONDecoder.new.decode([SearchItemModel].self, from: resultsList.data(using: .utf8)!) {
                for item in itemModels {
                    CoreConstants.shared.isSearchItemModelObjectValid(itemValue: item, eventType: CoreEventType.search)
                }
                self.resultsList += itemModels
            }
        }
        return self
    }

    public func setResultItemsList(resultListItemType: String, resultsIdsList: String, resultsFacilityId: String = "") -> CfLogSearchEventBuilder {
        resultsList.removeAll()
        if !resultsIdsList.isEmpty {
            if let itemIds = try? JSONDecoder.new.decode([String].self, from: resultsIdsList.data(using: .utf8)!) {
                for item in itemIds {
                    let searchItemObject = SearchItemModel(item_id: item, item_type: resultListItemType, facility_id: resultsFacilityId)
                    CoreConstants.shared.isSearchItemModelObjectValid(itemValue: searchItemObject, eventType: CoreEventType.search)
                    resultsList.append(searchItemObject)
                }
            }
        }
        return self
    }

    public func setResultItemsList(resultListItemType: String, resultsIdsList: [String]) -> CfLogSearchEventBuilder {
        resultsList.removeAll()
        if !resultsIdsList.isEmpty {
            for item in resultsIdsList {
                let searchItemObject = SearchItemModel(item_id: item, item_type: resultListItemType)
                CoreConstants.shared.isSearchItemModelObjectValid(itemValue: searchItemObject, eventType: CoreEventType.search)
                resultsList.append(searchItemObject)
            }
        }
        return self
    }

    /**
     * setFilter is required to log the filters applied by the user when the search is
     * performed. It needs to be a HashMap format of <String, String> to log. if no filters
     * are applied can be set to null.
     */

    public func setFilter(filter: Any?) -> CfLogSearchEventBuilder {
        filterValue = filter
        return self
    }

    /**
     * isNewSearch can be used to distinguish if the search is happening as a new search or
     * just to update the page number and result ids. If `true` then a new search id will be
     * generated and returned in the [getSearchId]
     */

    public func setIsNewSearch(isNewSearch: Bool) -> CfLogSearchEventBuilder {
        self.isNewSearch = isNewSearch
        return self
    }

    /**
     * setPage is required to log the the current page of the search result. Pages can start
     * from page 1 and move to the number of results that search is returning. Default page
     * number is 1.
     */

    public func setPage(page: Int) -> CfLogSearchEventBuilder {
        if page < 1 {
            ExceptionManager.throwPageNumberException(eventType: CoreEventType.search.rawValue)
        } else {
            pageValue = page
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    public func setMeta(meta: Any?) -> CfLogSearchEventBuilder {
        self.meta = meta
        return self
    }

    /**
     * updateImmediately is responsible for updating the values ot the backend immediately.
     * By default this is set to false or whatever the developer has set in the SDK
     * initialisation block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly and if false it will wait till the end of user
     * session which is whenever the app goes into background.
     */

    public func setUpdateImmediately(updateImmediately: Bool) -> CfLogSearchEventBuilder {
        self.updateImmediately = updateImmediately
        return self
    }

    public func getSearchId() -> String {
        if isNewSearch {
            CoreConstants.shared.previousSearchId = searchId
        }
        return CoreConstants.shared.previousSearchId!
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        if queryText == nil{
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.search.rawValue, elementName: "queryText")
            return
        }else if searchModule.isEmpty{
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.search.rawValue, elementName: "SearchModuleType")
            return
        }

        let searchObject = SearchObject(search_id: searchId, query: queryText!, search_module: searchModule, results_list: resultsList, filter: filterValue, page: pageValue, meta: meta)
        CFSetup().track(contentBlockName: contentBlock, eventType: CoreEventType.search.rawValue, logObject: searchObject, updateImmediately: updateImmediately)
        
    }
}
