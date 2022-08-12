//
//  HasData.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

protocol HasData: AnyObject {
    associatedtype Data
    var data: Data? { get set }
}
