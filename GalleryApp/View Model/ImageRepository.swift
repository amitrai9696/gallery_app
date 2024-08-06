//
//  ImageRepository.swift
//  GalleryApp
//
//  Created by Amit rai on 31/07/24.
//
import CoreData
import Foundation

class ImageRepository {
    private let context = CoreDataStack.shared.context
    
    func saveImages(_ images: [ImageModel]) {
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        
        do {
            let existingImages = try context.fetch(fetchRequest)
            for image in existingImages {
                context.delete(image)
            }
            
            for imageModel in images {
                let image = Image(context: context)
                image.id = imageModel.id
                image.author = imageModel.author
                image.width = Int64(imageModel.width)
                image.height = Int64(imageModel.height)
                image.url = imageModel.url
                image.download_url = imageModel.download_url
            }
            
            CoreDataStack.shared.saveContext()
        } catch {
            print("Failed to save images: \(error)")
        }
    }
    
    func fetchImages() -> [ImageModel] {
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        var imageModels: [ImageModel] = []
        
        do {
            let images = try context.fetch(fetchRequest)
            imageModels = images.map { image in
                ImageModel(id: image.id ?? "",
                           author: image.author ?? "",
                           width: Int(image.width),
                           height: Int(image.height),
                           url: image.url ?? "",
                           download_url: image.download_url ?? "")
            }
        } catch {
            print("Failed to fetch images: \(error)")
        }
        
        return imageModels
    }
}
