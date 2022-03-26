//
//  MobileUPGalleryViewController.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

/// структурка для данных альбома
struct dataPhotoAlbum {
    let ownerID: String = "-128666765"
    let albumID: String = "266276915"
}

final class MobileUPGalleryViewController: UIViewController {
    
    let service = NetworkService()
    
    let dataAlbum = dataPhotoAlbum()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        getPhotoAlbum()
    }
    
    /// Метод загрузки фото альбома
    func getPhotoAlbum() -> Void {
        service.loadPhotoAlbumPromisURL(ownerID: dataAlbum.ownerID, albumID: dataAlbum.albumID)
            .then(on: DispatchQueue.global(), service.loadPhotoAlbumPromisData(_:))
            .then(service.loadPhotoAlbumPromiseParsed(_:))
            .done(on: DispatchQueue.main) { response in
                print(response)
            }.catch { error in
                print(error)
            }
    }
}
