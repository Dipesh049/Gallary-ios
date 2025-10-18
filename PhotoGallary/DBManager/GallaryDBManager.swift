//
//  GallaryDBManager.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 17/10/25.
//

import CoreData

protocol GallaryDBManager {
    func savePhotos(photos: [Photo])
    func fetchPhotos() -> [Photo]
    func deletePhotos()
}

extension CoreDataManager: GallaryDBManager {
    
    func savePhotos(photos: [Photo]) {
        let fetchPhotos: NSFetchRequest<PhotoInfo> = PhotoInfo.fetchRequest()
        
        let existingItems = try? context.fetch(fetchPhotos)
        
        var existingItemDict: [Int16: PhotoInfo] = [:]
        if let existingItems {
            for item in existingItems {
                existingItemDict[item.id] = item
            }
        }
        
        for photo in photos {
            guard let id = photo.id else { continue }
            let entity = existingItemDict[Int16(id)] ?? PhotoInfo(context: context)
            if entity.id == -1 {
                entity.id = Int16(photo.id ?? 0)
            }
            entity.createdAt = photo.createdAt
            entity.photoUrl = photo.url
        }
        
        do {
            try context.save()
            debugPrint("Photos saved successfully.")
        } catch {
            debugPrint("Error saving Photos: \(error)")
        }
        
    }
    
    func fetchPhotos() -> [Photo] {
        let fetchPhoto: NSFetchRequest<PhotoInfo> = PhotoInfo.fetchRequest()
        if let photoinfo = try? context.fetch(fetchPhoto) {
            var photos: [Photo] = []
            for photo in photoinfo {
                photos.append(Photo(title: nil, description: nil,
                    fileSize: nil,
                    height: nil,
                    updatedAt: nil,
                    id: Int(photo.id),
                    width: nil,
                    createdAt: photo.createdAt,
                    url: photo.photoUrl))
            }
            return photos
        }
        
        return []
    }
    
    func deletePhotos() {
        let fetchPhotos: NSFetchRequest<NSFetchRequestResult> = PhotoInfo.fetchRequest()
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchPhotos)
        do {
            try context.execute(batchDeleteRequest)
            self.saveContext()
            debugPrint("photos deleted")
        } catch {
            debugPrint("Batch delete failed: \(error.localizedDescription)")
        }
    }
    
}
