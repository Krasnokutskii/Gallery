//
//  DetailPaggedViewController.swift
//  DetailPaggedViewController
//
//  Created by Ярослав on 11/14/21.
//

import UIKit
private let reuseIdentifier = "Cell"
class DetailPaggedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var images: [UIImage] = ImageStorage.shared.images
    
    lazy var selectedIndexPath: IndexPath = IndexPath(index: 0 )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            //appearance.configureWithOpaqueBackground()
            appearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        addBackgroundGradient()
        
        
        
        // helo 
        // some new line to check new fiches in xcode 15 source control
        
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
        //view.layer.addSublayer(gradientLayer)
      }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(
            at: selectedIndexPath,
            at: .centeredHorizontally,
            animated: false
        )
        collectionView.isPagingEnabled = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DefaultCollectionViewCell
        cell.cellImage.image = images[indexPath.row]
        return cell
    }

}
extension DetailPaggedViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
}
