//
//  CoreConstants.swift
//
//
//  Created by khushbu on 11/09/23.
//

import Foundation
import UIKit



public class CoreConstants {
    public static let shared = CoreConstants()
    
    let devUrl = "https://api-dev.causalfoundry.ai/v1/"
    let prodUrl = "https://api.causalfoundry.ai/v1/"
    
    
    public var userId: String = ""
    var sdkKey: String = ""
    var isDebugMode: Bool = true
    var allowAutoPageTrack:Bool = true
    var isAnonymousUserAllowed:Bool = false
    var contentBlockName:String = ""
    
    
    //private var SDKString: String = "/0.2.2"
    var SDKVersion: String = "ios\(0.2)"
    
    public var updateImmediately: Bool = false
    
    public var pauseSDK: Bool = false
    public var autoShowInAppNudge: Bool = true
    var sessionStartTime: Int64 = 0
    var sessionEndTime: Int64 = 0
    
    var deviceObject: DInfo?
    var appInfoObject:AppInfo?
    public var previousSearchId:String? = ""
    
    public  var userIdKey: String = "userIdKey"
    
    public var isAppDebuggable: Bool = true
    
    public var logoutEvent: Bool = false
    
    public var isAppOpen:Bool = false
    public var isAppPaused:Bool = false
    
    
    public var impressionItemsList = [String]()
    
    public var isAgainRate: Bool = false
    
    public func enumContains<T: EnumComposable>(_ type: T.Type, name: String) -> Bool where T.RawValue == String {
//        
//        if type == LanguageCode.self {
////            return (T.allCases.contains{ ($0.languageISO3Code == name) || ($0.languageISO2Code == name) || ($0.languageFullName == name) })
//            
//            return (T.allCases.contains{ ($0.languageISO3Code == name)} ||  T.allCases.contains{ ($0.T.allCases.contains{ ($0.languageISO3Code == name)} == name)} || T.allCases.contains{ ($0.languageFullName == name)})
//        }else{
            return T.allCases.contains{ $0.rawValue == name }
       // }
     
    }
}

public protocol EnumComposable :RawRepresentable,CaseIterable{
    
}



extension CoreConstants {
    
    func isSearchItemModelObjectValid(itemValue: SearchItemModel, eventType: CoreEventType) {
        let eventName = eventType.rawValue
        
        guard !itemValue.id!.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_id")
            return
        }
        
        guard !itemValue.type!.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_type")
            return
        }
        
        guard let _ = SearchItemType(rawValue: itemValue.type!) else {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
            return
        }
    }
    
    
    public func getCurrencyFromLocalStorage(fromCurrency: String) -> Float {
        guard let rate = CoreConstants.usdRates[fromCurrency] else {
            return 1.0 // Default rate if not found
        }
        return rate
    }
    
    func getUserTimeZone() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Z"
        return dateFormatter.string(from: Date())
    }
    
    public func checkIfNull(_ inputValue: String?) -> String {
        if let value = inputValue, !value.isEmpty {
            return value
        }
        return ""
    }
    
    
}

// MARK: - USD rates dictionary
extension CoreConstants {
    
    private static var usdRates: [String: Float] = {
        let json = """
        {
          "1inch": 1.882093,
          "aave": 0.012782,
          "ada": 2.671452,
          "aed": 3.672984,
          "afn": 87.021095,
          "algo": 4.50971,
          "all": 105.946792,
          "amd": 389.646698,
          "amp": 248.797589,
          "ang": 1.802209,
          "aoa": 504.801188,
          "ar": 0.115117,
          "ars": 205.004692,
          "atom": 0.084365,
          "aud": 1.497421,
          "avax": 0.057307,
          "awg": 1.800001,
          "axs": 0.114617,
          "azn": 1.699916,
          "bake": 5.263262,
          "bam": 1.814455,
          "bat": 4.005962,
          "bbd": 2.003526,
          "bch": 0.007532,
          "bdt": 107.004405,
          "bgn": 1.815897,
          "bhd": 0.377066,
          "bif": 2079.654274,
          "bmd": 1,
          "bnb": 0.003003,
          "bnd": 1.335641,
          "bob": 6.905096,
          "brl": 5.242803,
          "bsd": 1,
          "bsv": 0.02712,
          "bsw": 5.180577,
          "btc": 0.000036,
          "btcb": 0.000036,
          "btg": 0.06124,
          "btn": 82.602478,
          "busd": 0.999973,
          "bwp": 13.315465,
          "byn": 2.523994,
          "byr": 19600.008175,
          "bzd": 2.004881,
          "cad": 1.370971,
          "cake": 0.26276,
          "cdf": 2052.001034,
          "celo": 1.599621,
          "chf": 0.922298,
          "chz": 8.176447,
          "clp": 822.750288,
          "cny": 6.884603,
          "comp": 0.022315,
          "cop": 4813.432008,
          "crc": 540.021748,
          "cro": 14.080925,
          "crv": 1.019646,
          "cuc": 1,
          "cup": 26.500011,
          "cve": 102.299864,
          "cvx": 0.180368,
          "czk": 22.095012,
          "dai": 1.00153,
          "dash": 0.017386,
          "dcr": 0.049846,
          "dfi": 417.819611,
          "djf": 177.720342,
          "dkk": 6.914572,
          "doge": 13.247504,
          "dop": 54.790731,
          "dot": 0.158528,
          "dzd": 135.59004,
          "egld": 0.022962,
          "egp": 30.901714,
          "enj": 2.467666,
          "eos": 0.85457,
          "ern": 15.000007,
          "etb": 53.846761,
          "etc": 0.048719,
          "eth": 0.000558,
          "eur": 0.92858,
          "fei": 1.019609,
          "fil": 0.171502,
          "fjd": 2.2169,
          "fkp": 0.815928,
          "flow": 0.955696,
          "frax": 1.002026,
          "ftm": 2.096042,
          "ftt": 0.694978,
          "gala": 23.53797,
          "gbp": 0.818396,
          "gel": 2.575027,
          "ggp": 0.815928,
          "ghs": 12.299848,
          "gip": 0.815928,
          "gmd": 61.498879,
          "gnf": 8603.690353,
          "gno": 0.008918,
          "grt": 6.673636,
          "gt": 0.186051,
          "gtq": 7.7985,
          "gyd": 210.993687,
          "hbar": 15.748966,
          "hkd": 7.847453,
          "hnl": 24.663009,
          "hnt": 0.779121,
          "hot": 197.275745,
          "hrk": 7.018277,
          "ht": 0.248791,
          "htg": 154.810344,
          "huf": 361.169839,
          "icp": 0.1917,
          "idr": 15307.056385,
          "ils": 3.658332,
          "imp": 0.815928,
          "inj": 0.240695,
          "inr": 82.677684,
          "iqd": 1459.505201,
          "irr": 42250.017832,
          "isk": 139.390277,
          "jep": 0.815928,
          "jmd": 151.022402,
          "jod": 0.709402,
          "jpy": 132.43508,
          "kava": 1.044776,
          "kcs": 0.10789,
          "kda": 0.9707,
          "kes": 130.497799,
          "kgs": 87.420025,
          "khr": 4057.816744,
          "klay": 4.292089,
          "kmf": 461.740142,
          "knc": 1.38408,
          "kpw": 899.983549,
          "krw": 1306.630295,
          "ksm": 0.028633,
          "kwd": 0.3066,
          "kyd": 0.833272,
          "kzt": 464.635789,
          "lak": 16893.810796,
          "lbp": 15009.654651,
          "leo": 0.284598,
          "link": 0.135491,
          "lkr": 323.017112,
          "lrc": 2.836491,
          "lrd": 161.050113,
          "lsl": 18.419896,
          "ltc": 0.012264,
          "ltl": 2.952742,
          "luna": 0.695014,
          "lvl": 0.60489,
          "lyd": 4.80657,
          "mad": 10.286206,
          "mana": 1.645865,
          "matic": 0.875324,
          "mdl": 18.621401,
          "mga": 4299.989734,
          "mina": 1.217215,
          "miota": 4.611753,
          "mkd": 57.2096,
          "mkr": 0.001471,
          "mmk": 2099.878418,
          "mnt": 3531.215545,
          "mop": 8.081736,
          "mro": 356.999977,
          "mur": 46.497928,
          "mvr": 15.399212,
          "mwk": 1026.347956,
          "mxn": 18.612034,
          "myr": 4.469838,
          "mzn": 63.101438,
          "nad": 18.420463,
          "near": 0.489408,
          "neo": 0.082581,
          "nexo": 1.47624,
          "ngn": 460.420205,
          "nio": 36.571126,
          "nok": 10.550774,
          "npr": 132.165376,
          "nzd": 1.615936,
          "okb": 0.022304,
          "omr": 0.385065,
          "one": 1515.31317,
          "pab": 0.999981,
          "paxg": 0.000513,
          "pen": 3.777903,
          "pgk": 3.569872,
          "php": 54.392526,
          "pkr": 281.616022,
          "pln": 4.351323,
          "pyg": 7198.125312,
          "qar": 3.641021,
          "qnt": 0.007676,
          "qtum": 0.313293,
          "ron": 4.571201,
          "rsd": 108.934453,
          "rub": 77.250136,
          "rune": 0.821157,
          "rwf": 1095.824783,
          "sand": 1.511865,
          "sar": 3.75685,
          "sbd": 8.200168,
          "scr": 13.903029,
          "sdg": 593.502593,
          "sek": 10.340844,
          "sgd": 1.336891,
          "shib": 92141.358215,
          "shp": 1.216751,
          "sle": 21.189012,
          "sll": 19750.008605,
          "sol": 0.045007,
          "sos": 569.507304,
          "srd": 34.878519,
          "std": 20697.989642,
          "stx": 269.454944,
          "svc": 8.749343,
          "syp": 2512.539193,
          "szl": 18.60317,
          "thb": 34.511516,
          "theta": 0.964354,
          "tjs": 10.939795,
          "tmt": 3.500001,
          "tnd": 3.129042,
          "top": 2.350599,
          "trx": 14.943495,
          "try": 19.040237,
          "ttd": 6.789994,
          "ttt": 8.917249,
          "tusd": 0.999244,
          "twd": 30.492517,
          "tzs": 2340.001106,
          "uah": 36.930278,
          "ugx": 3761.018361,
          "uni": 1502.384937,
          "usd": 1,
          "usdc": 1.000765,
          "usdp": 1.001729,
          "usdt": 0.997715,
          "uyu": 39.51203,
          "uzs": 11378.611296,
          "vef": 2414814.870255,
          "ves": 24.095681,
          "vet": 42.487888,
          "vnd": 23585.009838,
          "vuv": 119.079079,
          "waves": 0.444188,
          "wbtc": 0.000036,
          "wemix": 0.661258,
          "wst": 2.713077,
          "xaf": 608.57974,
          "xag": 0.04458,
          "xau": 0.000514,
          "xcd": 2.702552,
          "xch": 0.025907,
          "xdc": 25.261242,
          "xdr": 0.749228,
          "xec": 31891.305848,
          "xem": 24.871263,
          "xlm": 10.493209,
          "xmr": 0.006649,
          "xof": 608.585386,
          "xpf": 112.250202,
          "xrp": 2.170949,
          "xtz": 0.850237,
          "yer": 250.301728,
          "zar": 18.557058,
          "zec": 0.027685,
          "zil": 35.129873,
          "zmk": 9001.203399,
          "zmw": 20.774663,
          "zwl": 321.999726
        }

        """
        do {
            guard let data = json.data(using: .utf8) else {
                throw NSError(domain: "usd_rates", code: 0, userInfo: ["reason": "JSON data corrupt"])
            }
            let decoder = JSONDecoder()
            return try decoder.decode([String: Float].self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
}
