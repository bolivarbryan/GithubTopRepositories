//
//  RepositoryDetailsViewController.swift
//  GithubTopRepositories
//
//  Created by Bryan A Bolivar M on 12/7/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryDetailsViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    var item: Item?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePictureImageView.kf.setImage(with: item?.ownerAvatarUrl)
        detailsLabel.text = item?.details
        title = item?.repositoryName
    }
    
    //MARK: Functions


}
