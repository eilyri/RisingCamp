//
//  ReviewTableViewCell.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/25.
//

import UIKit

class ReviewTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var evaluationImage: UIImageView!
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var imageString: String = ""
    
    @IBOutlet weak var pictureCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var pageLabel: UILabel!
    var imageList = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pictureCollectionView.delegate = self
        pictureCollectionView.dataSource = self
        pictureCollectionView.register(UINib(nibName: "PictureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PictureCollectionViewCell")
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: pictureCollectionView.frame.width - 24, height: pictureCollectionView.frame.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        pictureCollectionView.collectionViewLayout = flowLayout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList = imageString.components(separatedBy: ",")
        pageLabel.text = "1/" + String(imageList.count)
        pageView.alpha = 1
        if imageList.count == 1 {
            pageView.alpha = 0
        }
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath) as! PictureCollectionViewCell
        //let reviewHeight = reviewLabel.sizeThatFits(CGSize(width: reviewLabel.frame.width, height: CGFloat.greatestFiniteMagnitude))
        //self.reviewLabelHeight.constant = reviewHeight.height
        let url = URL(string: imageList[indexPath.row])
        if url != nil {
            let data = try? Data(contentsOf: url!)
            cell.foodPictureImage.image = UIImage(data: data!)
        }
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == pictureCollectionView {
            let page = Int(targetContentOffset.pointee.x / self.pictureCollectionView.bounds.width)
            
            pageLabel.text = String(page+1) + "/" + String(imageList.count)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
    }
}
