//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import UIKit

import PinLayout

class PokemonListViewController: BaseViewController {
    
    // MARK: - Private properties -
    
    private var collectionView: PokemonCollectionView!
    private let itemsPerRow: CGFloat = 4
    
    // MARK: - View controller lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemon Dek"
        print("PokemonListViewController")
        if let viewModel = self.viewModel as? PokemonListViewModel {
            viewModel.fetchData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupUI()
        self.viewModel?.delegate = self
    }
    
    // MARK: - Private methods -
    
    private func setupUI() {
        self.setupCollectionView()
        self.setupSearchBar()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let margin: CGFloat = 10
        self.collectionView = PokemonCollectionView(frame: .zero, collectionViewLayout: layout)
        let itemSize = (collectionView.bounds.width - (self.itemsPerRow + 1) * margin) / self.itemsPerRow
        
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = margin
        layout.minimumLineSpacing = margin
        layout.sectionHeadersPinToVisibleBounds = true
        
        self.collectionView.attach(on: self.view)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.prefetchDataSource = self
    }
    
    private func setupSearchBar() {
        self.collectionView.register(PokemonCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: PokemonCollectionHeaderView.identifier)
    }
    
}

extension PokemonListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked")
    }
}

extension PokemonListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let vm = self.viewModel as? PokemonListViewModel,
            let data: PokemonList = vm.getData() {
            return data.results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.getCell(at: indexPath)
        if let vm = self.viewModel as? PokemonListViewModel,
            let data: PokemonList = vm.getData() {
            cell.setup(with: data.results[indexPath.item])
        }
        return cell
    }
    
}


extension PokemonListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == 29 ) {
             print("load more")
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.collectionView.bounds.width
        let margin: CGFloat = 10
        let cellSize = (collectionViewWidth - (self.itemsPerRow + 1) * margin) / self.itemsPerRow
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: PokemonCollectionHeaderView.height) 
     }
     
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                          withReuseIdentifier: PokemonCollectionHeaderView.identifier,
                                                                          for: indexPath) as! PokemonCollectionHeaderView
         headerView.searchBarDelegate = self

         return headerView
     }
}

extension PokemonListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension PokemonListViewController: BaseViewModelDelegate {
    
    func reloadNeeded() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}
