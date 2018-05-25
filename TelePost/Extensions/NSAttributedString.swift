//
//  NSAttributedString.swift
//  TelePost
//
//  Created by Hitender kumar on 17/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

extension String {
    func attributedStringWith(boldPart : String, boldPartFontSize : CGFloat, normalPart : String, normalPartFontSize : CGFloat, boldPartTextColor : UIColor, normalPartTextColor : UIColor) -> NSMutableAttributedString {
        let resultAttribitedStr = NSMutableAttributedString.init(string: boldPart)
        resultAttribitedStr.addAttributes([NSAttributedStringKey.foregroundColor : boldPartTextColor, NSAttributedStringKey.font : UIFont.init(name: CustomFonts.Montserrat.bold, size: boldPartFontSize) as Any], range: NSRange.init(location: 0, length: resultAttribitedStr.length))
        
        let marksAttributedString = NSMutableAttributedString.init(string: normalPart)
        marksAttributedString.addAttributes([NSAttributedStringKey.foregroundColor : normalPartTextColor, NSAttributedStringKey.font : UIFont.init(name: CustomFonts.Montserrat.regular, size: normalPartFontSize) as Any], range: NSRange.init(location: 0, length: marksAttributedString.length))
        resultAttribitedStr.append(marksAttributedString)
        return resultAttribitedStr
    }
}
