//
//  StartViewController.swift
//  Messenger
//
//  Created by Misha Samoylov on 12.02.2022.
//

import UIKit

class StartViewController: UIViewController {

    let scrollView = UIScrollView()
    var imageViews: [UIImageView] = []
    var lastView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let images = ["start-a", "start-b", "start-c"]

        for name in images {
            let img = UIImage(named: name)
            let imageView = UIImageView(image: img)
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }

        lastView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height))
        lastView.backgroundColor = UIColor.systemBackground
        
        let button = UIButton(type: .system)
        lastView.addSubview(button)
        
        scrollView.addSubview(lastView)
        self.view.addSubview(scrollView)
        
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(touchNextButton), for: .touchDown)
        
        button.widthAnchor.constraint(equalTo: lastView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.centerYAnchor.constraint(equalTo: lastView.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: lastView.centerXAnchor).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.isPagingEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for (index, imageView) in (imageViews.enumerated()) {
            imageView.frame.size = scrollView.frame.size
            imageView.frame.origin.x = scrollView.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }
        
        // Расположение последней UIView
        lastView.frame.size = scrollView.frame.size
        lastView.frame.origin.x = scrollView.frame.width * 3
        lastView.frame.origin.y = 0
        
        // Установка ширины UIScrollView
        let contentWidth = scrollView.frame.width * CGFloat(imageViews.count) + scrollView.frame.width
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
    }
    
    @objc func touchNextButton() {
        let mainVC = TabViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
}
