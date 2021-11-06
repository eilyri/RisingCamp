//
//  SearchViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/15.
//

import UIKit

class SearchViewController: BaseViewController {
    
    var ads = ["ad1", "ad2", "ad3", "ad4"]
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var nowPage: Int = 0
    
    @IBOutlet weak var filterView: UIView!
    
    private let myLocationButton: MyCustomButton = {
        let button = MyCustomButton(frame: CGRect(x: 245, y: 7, width: 80, height: 32))
        button.backgroundColor = .mainLightGray
        button.tintColor = .mainOrange
        return button
    }()
    private let myFilterButton: MyCustomButton = {
        let button = MyCustomButton(frame: CGRect(x: 338, y: 7, width: 65, height: 32))
        button.backgroundColor = .white
        button.tintColor = .darkGray
        return button
    }()
    
    var restaurantList: [SearchResult] = []
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        foodCollectionView.register(UINib(nibName: "FoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FoodCollectionViewCell")
        
        if let layout = foodCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = foodCollectionView.frame.width / 2 - 15
            layout.itemSize = CGSize(width: width, height: width / 19 * 25)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        self.view.layoutIfNeeded()
        
        pageControl.currentPage = 0
        bannerTimer()
        customNavBarLeft(title: "성남시")
        customNavBarRight()
        
        filterView.addSubview(myFilterButton)
        let viewModel = MyCustomButtonViewModel(imageName: "settings", title: "필터", borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        myFilterButton.configure(with: viewModel)
        
        filterView.addSubview(myLocationButton)
        let viewModel1 = MyCustomButtonViewModel(imageName: "add", title: "내 주변", borderWidth: 0, borderColor: UIColor.mainOrange.cgColor)
        myLocationButton.configure(with: viewModel1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showIndicator()
        SearchViewDataManager().getRestaurant(area: "성남시", viewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        self.changeCollectionHeight()
    }
    
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in self.bannerMove() }
    }
    
    func bannerMove() {
        if nowPage == 3 {
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            self.pageControl.currentPage = nowPage
            return
        }
        nowPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
        self.pageControl.currentPage = nowPage    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func changeCollectionHeight() {
        //self.collectionViewHeight.constant = self.foodCollectionView.contentSize.height
        self.collectionViewHeight.constant = self.foodCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bannerCollectionView {
            return 4
        }
        else {
            return restaurantList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
            cell.adImage.image = UIImage(named: ads[indexPath.row])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCollectionViewCell", for: indexPath) as! FoodCollectionViewCell
            cell.placeNameLabel.text = String(indexPath.row + 1) + ". " + restaurantList[indexPath.row].name
            
            let url = URL(string: restaurantList[indexPath.row].imageUrl)
            let data = try? Data(contentsOf: url!)
            cell.foodImg.image = UIImage(data: data!)
            
            cell.placeAreaLabel.text = restaurantList[indexPath.row].area
            cell.ratingLabel.text = restaurantList[indexPath.row].rating
            cell.viewsLabel.text = String(restaurantList[indexPath.row].views)
            cell.reviewsLabel.text = String(restaurantList[indexPath.row].reviews)
            cell.distanceLabel.text = String(restaurantList[indexPath.row].distance)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == foodCollectionView {
            let vc = RestaurantViewController()
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            vc.restaurantId = restaurantList[indexPath.row].id
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == bannerCollectionView {
            let page = Int(targetContentOffset.pointee.x / self.view.bounds.width)
            print(page)
            self.pageControl.currentPage = page
            nowPage = page
        }
    }
    
}

extension SearchViewController {
    func didRetrieveRestaurants(_ result: [SearchResult]){
        self.dismissIndicator()
        self.restaurantList = result
        self.foodCollectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        dismissIndicator()
        presentAlert(message: message)
    }
}
