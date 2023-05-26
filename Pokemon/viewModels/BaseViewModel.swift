//
//  BaseViewModel.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

@objc
protocol DataFetcher {
    var isLoading: Bool { get set }
    @objc func fetchData(url: String?)
    @objc optional func loadMore()
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
    @objc internal var isLoading: Bool = false
    
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
