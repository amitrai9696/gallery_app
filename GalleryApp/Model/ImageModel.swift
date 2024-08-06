//
//  ImageModel.swift
//  GalleryApp
//
//  Created by Amit rai on 31/07/24.
//

import Foundation

struct ImageModel: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
