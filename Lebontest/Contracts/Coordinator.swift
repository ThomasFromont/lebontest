//
//  Coordinator.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

protocol Coordinator: AnyObject {
    func start()
    func close(animated: Bool, completion: (() -> Void)?)
}
