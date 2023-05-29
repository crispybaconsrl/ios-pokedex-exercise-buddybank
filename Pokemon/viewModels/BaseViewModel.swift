//
//  BaseViewModel.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

protocol DataFetcher {
    var isLoading: Bool { get set }
    func fetchData(url: String?)
    func loadMore()
}

extension DataFetcher {
    func loadMore() {}
}

protocol BaseViewModelDelegate: AnyObject {
    func reloadNeeded()
    func didReceiveError(error: Error)
}

extension BaseViewModelDelegate {
    func reloadNeeded() {}
    func didReceiveError(error: NetworkError) {}
}

protocol BaseViewModelDataSource: AnyObject {
    associatedtype DataType: Decodable
    func getData() -> DataType?
}

class BaseViewModel: NSObject {
    
    weak var delegate: BaseViewModelDelegate?
    weak var dataSource: (any BaseViewModelDataSource)?
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
