//
//  OnBoardingViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 22.10.2024.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    var arraySlides = [["firstSlide", "ÖZINŞE-ге қош келдің!", "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары"], ["secondSlide", "ÖZINŞE-ге қош келдің!", "Кез келген құрылғыдан қара. Сүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"], ["thirdSlide", "ÖZINŞE-ге қош келдің!", "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"]]
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let pageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.tintColor = .black
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)
        pc.contentVerticalAlignment = .center
        pc.contentHorizontalAlignment = .center
        
        return pc
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func nextButtonTouched() {
        let signInViewController = SignInViewController()
        navigationController?.show(signInViewController, sender: self)
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(654)
            make.centerX.equalToSuperview()
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        
        cell.imageO.image = UIImage(named: arraySlides[indexPath.row][0])
        
        cell.welcomeLabel.text = arraySlides[indexPath.row][1]
        
        cell.fullInfoLabel.text = arraySlides[indexPath.row][2]
        
        cell.skipButton.layer.cornerRadius = 8
        if indexPath.row == 2 {
            cell.skipButton.isHidden = true
        }
        cell.skipButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        cell.nextButton.layer.cornerRadius = 12
        if indexPath.row != 2 {
            cell.nextButton.isHidden = true
        }
        
        cell.nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
