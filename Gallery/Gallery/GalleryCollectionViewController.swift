//
//  GalleryCollectionViewController.swift
//  GalleryCollectionViewController
//
//  Created by Ярослав on 11/10/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController {
    
    private let sectionInsects: UIEdgeInsets = UIEdgeInsets(top: 50, left: 10, bottom: 50, right: 10)
    private let itemsPerRow: CGFloat = 2
    private var images = ImageStorage.shared.images
    private var indexPath = ImageStorage.shared.indexPath
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .purple
         self.clearsSelectionOnViewWillAppear = false
        addBackgroundGradient()
    }

    
    private func addBackgroundGradient() {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = view.frame.size
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [#colorLiteral(red: 0.1997549087, green: 0.07058823854, blue: 0.3019607961, alpha: 1).cgColor, UIColor.black.cgColor]
        collectionView.backgroundView = collectionViewBackgroundView
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
      }
    
   


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DefaultCollectionViewCell
    
        // Configure the cell
        cell.backgroundColor = .black
        cell.cellImage.image = images[indexPath.row]
        cell.cellImage.contentMode = .scaleAspectFill
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailPaggedViewController") as! DetailPaggedViewController
        vc.selectedIndexPath = indexPath
        ImageStorage.shared.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = sectionInsects.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - padding
        let widthPerItem = availableWidth/itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsects
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsects.left
    }
}
