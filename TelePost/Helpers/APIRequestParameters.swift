//
//  APIRequestParameters.swift
//  TelePost
//
//  Created by Hitender kumar on 17/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

//MARK: API KEY

struct NewsApi {
    static let key = "b1cd728d31c1455196b8eb491cd2c2e9"
}

//MARK: Request Parameters

struct parameters {
    static let country = "country"
    static let category = "category"
    static let sources = "sources"
    static let pageSize = "pageSize"
    static let page = "page"
    static let apiKey = "apiKey"
}

//MARK: Sub-Parameters

//protocol struct CountryProtocol<T1, T2> {
//    var code: T1
//    var name: T2
//}


protocol CountryProtocol {
    var code: String {get set}
    var name: String {get set}
 }

struct Country {

    struct UAE : CountryProtocol {
        var code: String = "ae"
        var name: String = "United Arab Emirates"
      }
    
    struct Argentina : CountryProtocol {
        var code: String = "ar"
        var name: String = "Argentina"
     }
    
    struct Austria : CountryProtocol  {
        var code: String = "at"
        var name: String = "Austria"
     }
    
    struct Belgium : CountryProtocol  {
        var code = "be"
        var name = "Belgium"
    }
    
    struct Bulgaria : CountryProtocol  {
        var code = "bg"
        var name = "Bulgaria"
    }
    

    struct Brazil : CountryProtocol  {
        var code = "br"
        var name = "Brazil"
    }
    
    struct Canada : CountryProtocol  {
        var code = "ca"
        var name = "Canada"
    }
    
    struct Switzerland : CountryProtocol  {
        var code = "ch"
        var name = "Switzerland"
    }
    
    struct China : CountryProtocol  {
        var code = "cn"
        var name = "China"
    }
    
    struct Colombia : CountryProtocol  {
        var   code = "co"
        var   name = "Colombia"
    }
    
    struct Cuba : CountryProtocol  {
          var code = "cu"
          var name = "Cuba"
    }
    
    struct Germany : CountryProtocol  {
          var code = "de"
          var name = "Germany"
    }
    
    struct Egypt : CountryProtocol  {
          var code = "eg"
          var name = "Egypt"
    }
    
    struct Greece : CountryProtocol  {
          var code = "gr"
          var name = "Greece"
    }
    
    struct HongKong : CountryProtocol  {
          var code = "hk"
          var name = "Hong Kong"
    }
    
    struct Hungary : CountryProtocol  {
          var code = "hu"
          var name = "Hungary"
    }
    
    struct Indonesia : CountryProtocol  {
          var code = "id"
          var name = "Indonesia"
    }
//
//
//    var countries = [UAE(), Argentina(), Austria(), Belgium(), Bulgaria(), Brazil(), Canada(), Switzerland(), China(), Colombia(), Cuba(), Germany(), Egypt(), Greece(), HongKong(),Hungary(), Indonesia(), Israel(), Ireland(), India(), Italy(),   ] as [Any]
    struct Israel : CountryProtocol  {
          var code = "il"
          var name = "Israel"
    }
    
    struct Ireland : CountryProtocol  {
          var code = "ie"
          var name = "Ireland"
    }
    
    struct India : CountryProtocol  {
          var code = "in"
          var name = "India"
    }
    
    struct Italy : CountryProtocol  {
        var   code = "it"
        var   name = "Italy"
    }
    
    
    struct Japan : CountryProtocol  {
        var   code = "jp"
        var   name = "Japan"
    }
    
    struct SouthKorea : CountryProtocol  {
        var   code = "kr"
        var   name = "SouthKorea"
    }
    
    struct Lithuania : CountryProtocol  {
        var   code = "lt"
        var   name = "Lithuania"
    }
    
    struct Latvia : CountryProtocol  {
        var   code = "lv"
        var   name = "Latvia"
    }
    
    struct Morocco : CountryProtocol  {
        var   code = "ma"
        var   name = "Morocco"
    }
    
    struct Mexico : CountryProtocol  {
        var   code = "mx"
        var   name = "Mexico"
    }
    
    struct Malaysia : CountryProtocol  {
        var   code = "my"
        var   name = "Malaysia"
    }
    
    struct Nigeria : CountryProtocol  {
        var   code = "ng"
        var   name = "Nigeria"
    }
    
    struct Netherlands : CountryProtocol  {
        var   code = "no"
        var   name = "Netherlands"
    }
    
    struct Norway : CountryProtocol  {
        var   code = "no"
        var    name = "Norway"
    }
    
    struct NewZealand : CountryProtocol  {
          var code = "nz"
          var name = "New Zealand"
    }
    
    struct Philippines : CountryProtocol  {
          var code = "ph"
          var name = "Philippines"
    }
    
    struct Poland : CountryProtocol  {
          var code = "pl"
          var name = "Poland"
    }
    
    struct Portugal : CountryProtocol  {
          var code = "pt"
          var name = "Portugal"
    }
    
    struct Romania : CountryProtocol  {
          var code = "ro"
          var name = "Romania"
    }
    struct Serbia : CountryProtocol  {
          var code = "rs"
          var name = "Serbia"
    }
    
    struct RussianFederationv {
        var   code = "ru"
        var   name = "Russian Federation"
    }
    
    struct SaudiArabia : CountryProtocol  {
        var   code = "sa"
        var   name = "Saudi Arabia"
    }
    
    struct Sweden : CountryProtocol  {
        var   code = "se"
        var   name = "Sweden"
    }
    
    struct Singapore : CountryProtocol  {
        var   code = "sg"
        var   name = "Singapore"
    }
    
    struct Slovenia : CountryProtocol  {
        var   code = "si"
        var   name = "Slovenia"
    }
    
    struct Slovakia : CountryProtocol  {
        var   code = "sa"
         var   name = "Slovakia"
    }
    
    struct Thailand : CountryProtocol  {
        var   code = "th"
        var   name = "Thailand"
    }
    
    struct turkey : CountryProtocol  {
        var   code = "tr"
        var   name = "Turkey"
    }
    
    struct Taiwan : CountryProtocol  {
        var   code = "tw"
        var   name = "Taiwan"
    }
    
    struct Ukraine : CountryProtocol  {
        var   code = "ua"
        var   name = "Ukraine"
    }
    
    struct USA : CountryProtocol  {
        var   code = "us"
        var   name = "USA"
    }
    
    struct Venezuela : CountryProtocol  {
        var   code = "ve"
        var name = "Venezuela"
    }
    
    struct SouthAfrica : CountryProtocol  {
        var   code = "za"
        var   name = "South Africa"
    }
}

struct category {
    static let business = "business"
    static let entertainment = "entertainment"
    static let general = "general"
    static let health = "health"
    static let science = "science"
    static let sports = "sports"
    static let technology = "technology"
}

