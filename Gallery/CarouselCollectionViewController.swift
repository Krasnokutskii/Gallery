//
//  CarouselCollectionViewController.swift
//  CarouselCollectionViewController
//
//  Created by Ярослав on 11/10/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class CarouselCollectionViewController: UICollectionViewController {
    
    let flowLayout = ZoomAndSnapFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        addBackgroundGradient()
    }
  
    private func addBackgroundGradient() {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = view.frame.size
        // Start and end for left to right gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [#colorLiteral(red: 0.1997549087, green: 0.07058823854, blue: 0.3019607961, alpha: 1).cgColor, UIColor.black.cgColor]
        collectionView.backgroundView = collectionViewBackgroundView
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
      }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageStorage.shared.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DefaultCollectionViewCell
        cell.backgroundColor = .black
        cell.cellImage.image = ImageStorage.shared.images[indexPath.row]
        cell.cellImage.contentMode = .scaleAspectFill
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailPaggedViewController") as! DetailPaggedViewController
        vc.selectedIndexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
