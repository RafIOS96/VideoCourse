//
//  CourseViewController.swift
//  Video Course
//
//  Created by Rafayel Aghayan on 19.04.21.
//

import UIKit

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var courseTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable(_:)),
                                               name: Notification.Name(rawValue: "reloadTableView"),
                                               object: nil)
        
        if (UserDefaults.standard.array(forKey: "arrayCheckedNews") != nil) {
            arrayCheckedCourse = UserDefaults.standard.array(forKey: "arrayCheckedNews") as? [Int] ?? []
        }
       
        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
        
        CourseModel.getCourseList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndexPath = self.courseTableView.indexPathForSelectedRow {
            self.courseTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
        self.courseTableView.reloadData()
    }
    
    @objc func reloadTable(_ notification: Notification) {
        self.courseTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userListFullInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseTableViewCell
                
        if storedImages.count != 0 {
            cell.title.text = savedArray[indexPath.row]
            cell.courseImage.image = UIImage(data: storedImages[indexPath.row].img!)
        } else {
            CourseModel.setUserData(fromMutableArray: userListFullInfo, indexPath: indexPath.row)

            cell.courseImage.downloaded(from: thumb ?? "")
            cell.title.text = courseTitle
        }
        
        if indexArray[indexPath.row] == false {
            cell.favoriteButton.isSelected = false
        } else if indexArray[indexPath.row] == true {
            cell.favoriteButton.isSelected = true
        } else {
            cell.favoriteButton.isSelected = false
        }
        
        if arrayCheckedCourse.count != 0 {
            if arrayCheckedCourse.contains(indexPath.row) {
                cell.backgroundColor = .systemGray5
            } else {
                cell.backgroundColor = .systemBackground
            }
        }
        
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(self.favoriteButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        CourseModel.setUserData(fromMutableArray: userListFullInfo, indexPath: indexPath.row)
        
        if arrayCheckedCourse.contains(indexPath.row) == false {
            arrayCheckedCourse.append(indexPath.row)
            UserDefaults.standard.set(arrayCheckedCourse, forKey: "arrayCheckedNews")
        }
        
        let toCourseDetailScreen = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailViewControllerID") as! CourseDetailViewController
        self.navigationController?.pushViewController(toCourseDetailScreen, animated: true)
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        if sender.isSelected
        {
            sender.isSelected = false
            indexArray[sender.tag] = false
        } else {
            sender.isSelected = true
            indexArray[sender.tag] = true
        }
    }
}
