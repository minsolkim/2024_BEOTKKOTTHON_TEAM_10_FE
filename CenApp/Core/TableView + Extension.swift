//
//  TableView + Extension.swift
//  BEOTKKOTTHON_CEN
//
//  Created by 정성윤 on 2024/03/18.
//

import Foundation
import UIKit
//MARK: - 서류 디테일
//MARK: - 서류
class DocumentTableViewDataSource: NSObject, UITableViewDataSource, DocumentTableViewCellDelegate {
    weak var viewController: DocumentViewController?
    
    func didShow(in cell: DocumentTableViewCell) {
        viewController?.showSheet()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return DocumentViewController.documentCategories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as! DocumentTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}
class DocumentTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
//MARK: - 장학금 공고 테이블
class AnnoucementTableViewDataSource: NSObject, UITableViewDataSource {
    var scholarships: [ScholarshipModel] = [] // 장학금 데이터 배열
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scholarships.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as! AnnoucementTableViewCell
        cell.selectionStyle = .none
        let scholarship = scholarships[indexPath.row]
        cell.titleText.text = scholarship.title //타이틀
        cell.companyLabel.text = scholarship.provider //제공자
        
        return cell
    }
}
class AnnoucementTableViewDelegate: NSObject, UITableViewDelegate {
    var scholarships: [ScholarshipModel] = []
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scholarship = scholarships[indexPath.row]
        let destinationViewController = AnnoucementDetailViewController(post: scholarship)
        if let navigationController = tableView.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(destinationViewController, animated: true)
        }
    }
}
//MARK: - 마감임박 테이블
class mainSupportTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as! MiddleTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}

class mainSupportTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
//MARK: - 새로운 공고 테이블
class newAnnoucementTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BottomTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        return cell
    }
}

class newAnnoucementTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
