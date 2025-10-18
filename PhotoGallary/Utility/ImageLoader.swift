//
//  ImageLoader.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 17/10/25.
//


import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let folderName = "downloaded_images"
    private let fileManager = FileManager.default
    private let session: URLSession
    
    private init() {
        // avoid url cache
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        self.session = URLSession(configuration: config)
        memoryCache.countLimit = 20
        createFolderIfNeeded()
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Network
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let cacheKey = imgfileName(for: url)

        ///Memory cache
        if let image = memoryCache.object(forKey: cacheKey as NSString) {
            completion(image)
            return
        }

        /// Disk cache
        if let image = getFromDisk(key: cacheKey) {
            memoryCache.setObject(image, forKey: cacheKey as NSString)
            completion(image)
            return
        }

        session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil,
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            /// Cache in memory and disk
            self?.memoryCache.setObject(image, forKey: cacheKey as NSString)
            self?.saveToDisk(key: cacheKey, image: image)

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }

    // MARK: - Disk Caching Helpers

    private func createFolderIfNeeded() {
        guard let folderURL = getCacheFolderURL() else { return }
        if !fileManager.fileExists(atPath: folderURL.path) {
            try? fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
        }
    }

    private func getCacheFolderURL() -> URL? {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }

    private func getImagePath(for key: String) -> URL? {
        getCacheFolderURL()?.appendingPathComponent(key)
    }

    private func saveToDisk(key: String, image: UIImage) {
        guard let data = image.pngData(),
              let url = getImagePath(for: key) else {
            return
        }
        try? data.write(to: url)
    }

    private func getFromDisk(key: String) -> UIImage? {
        guard let url = getImagePath(for: key),
              fileManager.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }

    private func imgfileName(for url: URL) -> String {
        url.lastPathComponent
    }
}
