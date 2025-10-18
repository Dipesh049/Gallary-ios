//
//  GallaryViewModel.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//

import Foundation

class GallaryViewModel {
    var photos: [Photo] = []
    
    /// pagination
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    /// for debouncing
    private var debounce_timer: Timer?
    
    let dbManager: GallaryDBManager
    
    init(dbManager: GallaryDBManager = CoreDataManager.shared) {
        self.dbManager = dbManager
    }
    
    
    func getPhotos(useDebounce: Bool = true, completion: @escaping ([Photo]?, Error?) -> Void) {
        // Cancel existing timer if any
        debounce_timer?.invalidate()
        
        // Pagination guard
        guard !self.isLoading, self.currentPage <= self.totalPages else { return }

        let executeRequest = {
            self.isLoading = true
            let request =  APIService.shared.prepareRequest(endPoint: APIEndpoint.photos(page: self.currentPage, limit: 20, sortBy: "file_size", sortOrder: "desc"))
            APIService.shared.request(PhotoDetail.self, request: request) { result in
                switch result {
                case .success(let data):
                    if let photos = data.photos {
                        self.photos.append(contentsOf: photos)
                        self.dbManager.savePhotos(photos: photos)
                        self.totalPages = data.totalPages ?? 1
                        self.currentPage += 1
                        completion(photos, nil)
                    }
                case .failure(let failure):
                    debugPrint("error")
                    completion(nil, failure)
                }
                self.isLoading = false
                
            }
        }
        
        if useDebounce {
            debounce_timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                executeRequest()
            }
        } else {
            executeRequest()
            debugPrint("from scroll")
        }
       
    }
    
    func fetchFromDb(completion: @escaping ([Photo]?, Error?) -> Void) {
        let photos = dbManager.fetchPhotos()
        self.photos = photos
        completion(dbManager.fetchPhotos(), nil)
    }
}
