//
//  CollectionViewController.swift
//  CodingUIProgrammatically
//
//  Created by Timur Kaldybek on 02.02.2022.
//

import UIKit

public let reuseIdentifier = "cellId"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "bear_first", headerText: "Join use today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.isPagingEnabled = true
        setupBottomView()
    }
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(goToPrevCell), for: .touchUpInside)

        return button
    }()
    
     lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(goToNextCell), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func goToNextCell(){
        print("Go to next cell")
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func goToPrevCell(){
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func setupBottomView(){
        
        let bottomControlsView = UIStackView(arrangedSubviews: [backButton, pageControl, nextButton])
        bottomControlsView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsView.distribution = .fillEqually
        
        view.addSubview(bottomControlsView)
        
        NSLayoutConstraint.activate([
            bottomControlsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
