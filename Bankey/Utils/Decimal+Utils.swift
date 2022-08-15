//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Reese on 2022/08/12.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
