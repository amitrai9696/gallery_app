//
//  ImageService.swift
//  GalleryApp
//
//  Created by Amit rai on 30/07/24.
//
import Foundation

class ImageService {
    func fetchImages(completion: @escaping (Result<[ImageModel], Error>) -> Void) {
        let url = URL(string: "https://picsum.photos/v2/list?page=1&limit=10")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "dataNilError", code: -100001, userInfo: nil)))
                return
            }
            
            do {
                let images = try JSONDecoder().decode([ImageModel].self, from: data)
                completion(.success(images))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

