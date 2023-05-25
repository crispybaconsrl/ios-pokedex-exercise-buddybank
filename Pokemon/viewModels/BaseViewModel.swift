//
//  BaseViewModel.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

@objc
protocol DataFetcher {
    @objc func fetchData()
}

@objc
protocol BaseViewModelDelegate {
    @objc optional func reloadNeeded()
}

protocol BaseViewModelDataSource {
    associatedtype DataType: Decodable
    func getData() -> DataType?
}


class BaseViewModel: NSObject {
    
    var delegate: BaseViewModelDelegate?
    var dataSource: (any BaseViewModelDataSource)?
    
    required override init() {
    }
    
    static func instantiate() -> BaseViewModel {
        let className = "\(Bundle.main.appName ?? "").\(String(describing: self))"
        if let viewModelClass = NSClassFromString(className) as? BaseViewModel.Type {
            return viewModelClass.init()
        }
        return BaseViewModel()
    }
    
}
