//
//  BlueFlowerModel.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/28.
//

import Foundation

struct BlueFlower: Codable {
    let total, totalHits: Int
    let hits: [blueData]
}

struct blueData: Codable {
    let id: Int
    let pageURL: String
    let type: BlueDataTypeEnum
    let tags: String
    let previewURL: String
    let previewWidth, previewHeight: Int
    let webformatURL: String
    let webformatWidth, webformatHeight: Int
    let largeImageURL: String
    let imageWidth, imageHeight, imageSize, views: Int
    let downloads, collections, likes, comments: Int
    let userID: Int
    let user: String
    let userImageURL: String

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, collections, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}

enum BlueDataTypeEnum: String, Codable {
    case photo = "photo"
}
