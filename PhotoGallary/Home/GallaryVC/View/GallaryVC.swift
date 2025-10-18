//
//  GallaryVC.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//

import UIKit

class GallaryVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    lazy var viewModel = GallaryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil), forCellWithReuseIdentifier:  String(describing: ImageCell.self))
        
        loadFromDB()
        loadFromAPI()
    }
    
    func loadFromDB() {
        viewModel.fetchFromDb { [weak self] photos, error in
            if photos != nil {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    func loadFromAPI() {
        viewModel.getPhotos { [weak self] photos, error in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

}

//MARK: - UICollectionViewDataSource
extension GallaryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  String(describing: ImageCell.self), for: indexPath) as! ImageCell
        let imgUrl = viewModel.photos[indexPath.row].url
        cell.setupCell(image: imgUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.photos.count - 1 {
            // Last item
            searchOnScroll()
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GallaryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 2)
    }
}

extension GallaryVC {
    func searchOnScroll() {
        viewModel.getPhotos(useDebounce: true) { [weak self] photos, error in
            DispatchQueue.main.async {
                /// only insert newly added content
                let startIndex = self?.collectionView.numberOfItems(inSection: 0) ?? 1
                let endIndex = self?.viewModel.photos.count ?? 1
                let indexPaths = (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
                self?.collectionView.insertItems(at: indexPaths)
            }
        }
    }
}
