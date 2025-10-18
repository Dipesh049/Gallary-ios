//
//  PhotoDetail.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//


// MARK: - PhotoDetail
struct PhotoDetail: Decodable {
    let success: Bool?
    let message: String?
    let count, totalPages: Int?
    let photos: [Photo]?

    enum CodingKeys: String, CodingKey {
        case success, message, count
        case totalPages = "total_pages"
        case photos
    }
}

// MARK: - Photo
struct Photo: Decodable {
    let title, description: String?
    let fileSize, height: Int?
    let updatedAt: String?
    let id, width: Int?
    let createdAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case title, description
        case fileSize = "file_size"
        case height
        case updatedAt = "updated_at"
        case id, width
        case createdAt = "created_at"
        case url
    }
}
