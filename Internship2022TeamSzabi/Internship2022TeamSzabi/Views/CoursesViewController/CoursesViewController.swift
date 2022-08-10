//
//  HomeViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 26.07.2022.
//  Modified by Andreea Laura Bogdan on 02.08.2022.

import UIKit

final class CoursesViewController: UIViewController,
                                   UICollectionViewDelegate,
                                   UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {
    @IBOutlet private var courseCollectionView: UICollectionView!
    
    var coursesData: [CoursesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Courses"
        
        let nibCell = UINib(nibName: CoursesCollectionViewCell.identifier, bundle: nil)
        courseCollectionView.register(nibCell, forCellWithReuseIdentifier: "CoursesCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getCourses()
    }
    
    func getCourses() {
        CoursesApiManager.sharedCoursesData.getCoursesData { [weak self] courses in
            guard let courses = courses else { return }
            guard let self = self else { return }
            self.coursesData = courses
            self.courseCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowlayout?.minimumInteritemSpacing ?? 0.0) +
        (flowlayout?.sectionInset.left ?? 0.0) +
        (flowlayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coursesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = courseCollectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell",
                                                               for: indexPath) as? CoursesCollectionViewCell {
            cell.setup(course: coursesData[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = TestsViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.course = coursesData[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        print("======================")
        coursesData[indexPath.row].chapters?.forEach({ chapter in
            print(chapter)
        })
        let questions = coursesData[indexPath.row].chapters?.last?.questions
        print(questions)
        print("======================")
    }
}
