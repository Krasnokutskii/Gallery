//
//  ImageStorage.swift
//  ImageStorage
//
//  Created by Ярослав on 11/10/21.
//

import Foundation
import UIKit

class ImageStorage{
    var images = [UIImage]()
    
    static var shared: ImageStorage = {
        let instance = ImageStorage()
        return instance
    }()
    private func fetchDirectoryContents() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)

        for imageURL in directoryContents  {
            if let image = UIImage(contentsOfFile: imageURL.path) {
                images.append(image)
            } else {
                fatalError("Can't create image from file \(imageURL)")
            }
        }
    }
    private init(){
        fetchDirectoryContents()
    }
}
