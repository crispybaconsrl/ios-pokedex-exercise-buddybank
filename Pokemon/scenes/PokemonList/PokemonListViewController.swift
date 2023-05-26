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
    private var isFiltering: Bool = false
    
    // MARK: - View controller lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemon Dek"
        if let viewModel = self.viewModel as? PokemonListViewModel {
            viewModel.fetchData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
        self.viewModel?.delegate = self
    }
    
    // MARK: - Private methods -
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.setupCollectionView()
        self.setupSearchBar()
        self.setupFooter()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = AppTheme.shared.margin
        layout.minimumLineSpacing = AppTheme.shared.margin
        let margin: CGFloat = AppTheme.shared.margin
        self.collectionView = PokemonCollectionView(frame: .zero, collectionViewLayout: layout)
        let itemSize = (self.view.bounds.width - (self.itemsPerRow + 1) * margin) / self.itemsPerRow
        
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
    
    private func setupFooter() {
        self.collectionView.register(PokemonCollectionFooterView.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                     withReuseIdentifier: PokemonCollectionFooterView.identifier)
    }
    
}

extension PokemonListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if let vm = self.viewModel as? PokemonListViewModel {
            vm.filterBy(text: searchText)
            self.isFiltering = true
        } else {
            self.isFiltering = false
        }
        self.isFiltering = !searchText.isEmpty
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltering = false
        searchBar.resignFirstResponder()
    }
    
}

extension PokemonListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let vm = self.viewModel as? PokemonListViewModel {
            return vm.getPokemonList().count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.getCell(at: indexPath)
        if let vm = self.viewModel as? PokemonListViewModel {
            let pokemons = vm.getPokemonList()
            cell.setup(with: pokemons[indexPath.item])
        }
        return cell
    }
}


extension PokemonListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = self.viewModel as? PokemonListViewModel,
           let pokemon = viewModel.getPokemon(at: indexPath.item) {
            DispatchQueue.main.async {
                self.coordinator?.showDetails(of: pokemon)
            }
        } else {
            // TODO show error
        }
    }
    
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.collectionView.bounds.width
        let margin: CGFloat = AppTheme.shared.margin
        let cellSize = (collectionViewWidth - (self.itemsPerRow + 1) * margin) / self.itemsPerRow
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: PokemonCollectionHeaderView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if self.isFiltering {
            return .zero
        }
        
        if let viewModel = self.viewModel as? PokemonListViewModel,
           viewModel.getData()?.next == nil {
            return .zero
        }
        return CGSize(width: collectionView.bounds.width, height: PokemonCollectionFooterView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: PokemonCollectionFooterView.identifier,
                                                                             for: indexPath) as! PokemonCollectionFooterView
            return footerView
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: PokemonCollectionHeaderView.identifier,
                                                                         for: indexPath) as! PokemonCollectionHeaderView
        headerView.searchBarDelegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter,
           let _ = view as? PokemonCollectionFooterView,
           !self.isFiltering {
            if let viewModel = self.viewModel as? PokemonListViewModel, !viewModel.isLoading {
                viewModel.loadMore()
            }
        }
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
    
    func didReceiveError(error: Error) {
        DispatchQueue.main.async {
            self.displayNoDataView(true)
        }
    }
    
}
