//
//  StartPageViewController.swift
//  Messenger
//
//  Created by Misha Samoylov on 13.02.2022.
//

import UIKit

class StartPageViewController: UIPageViewController {
    
    private var pages: [UIViewController] = []
    
    // Переназначаем метод чтобы указать стиль создания UIPageViewController
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemBackground

        // Создаем изображения
        let images = ["start-a", "start-b", "start-c"]
        var imageViews: [UIImageView] = []
        
        for index in 0..<3 {
            let img = UIImage(named: images[index])
            
            let imageView = UIImageView(image: img)
            imageView.frame.size = self.view.frame.size
            imageView.contentMode = .scaleAspectFit
            
            imageViews.append(imageView)
        }
        
        // Создаем экраны и добавляем туда изображения
        for index in 0..<3 {
            let vc = UIViewController()
            pages.append(vc)
            pages[index].view.addSubview(imageViews[index])
        }
        
        // Добавляем кнопку на последний экран
        let lastVC = pages[pages.count - 1]
        let button = UIButton(type: .system)
        lastVC.view.addSubview(button)
        
        // Настройка кнопки
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(buttonNext), for: .touchDown)
        button.bottomAnchor.constraint(equalTo: lastVC.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        button.widthAnchor.constraint(equalTo: lastVC.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка UIPageViewController
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        
        // Настройка цвета индикатора страниц
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.3)
        proxy.currentPageIndicatorTintColor = UIColor.black
    }
    
    @objc private func buttonNext() {
        // Устанавливаем что просмотрели вводный тур
        UserDefaults.standard.set(true, forKey: USERDEFAULT_SHOWED_START)
        
        // Показ главного экрана
        let mainVC = TabViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
}

extension StartPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else {
            return nil
        }
        guard pages.count > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
}

extension StartPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = self.viewControllers?.first else {
            return 0
        }
        guard let firstVCIndex = pages.firstIndex(of: firstVC) else {
            return 0
        }

        return firstVCIndex
    }
}
