//
//  GalleryViewModel.swift
//  GalleryApp
//
//  Created by Amit rai on 30/07/24.
//
import Foundation

class GalleryViewModel {
    private let imageService = ImageService()
    private let imageRepository = ImageRepository()
    var images: [ImageModel] = []
    
    var reloadCollectionView: (() -> Void)?
    
    func fetchImages() {
        imageService.fetchImages { [weak self] result in
            switch result {
            case .success(let images):
                self?.images = images
                self?.imageRepository.saveImages(images)
                self?.reloadCollectionView?()
            case .failure(let error):
                print("Failed to fetch images: \(error)")
                self?.images = self?.imageRepository.fetchImages() ?? []  
                self?.reloadCollectionView?()
            }
        }
    }
 
}
