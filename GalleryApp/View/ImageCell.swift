//
//  ImageCell.swift
//  GalleryApp
//
//  Created by Amit rai on 30/07/24.
//
import UIKit
class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    func configure(with imageModel: ImageModel) {
          if let url = URL(string: imageModel.download_url) {
              URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {
                      DispatchQueue.main.async {
                          self.imageView.image = UIImage(data: data)
                      }
                  }
              }.resume()
          }
      }
  }
