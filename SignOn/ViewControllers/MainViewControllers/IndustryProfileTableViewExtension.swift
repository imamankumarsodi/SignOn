//
//  IndustryProfileTableViewExtension.swift
//  SignOn
//
//  Created by Callsoft on 27/03/19.
//  Copyright © 2019 Callsoft. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UITableViewDatasource

extension IndustrialProfileViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentorProfileTableViewCellAndXib", for: indexPath) as! MentorProfileTableViewCellAndXib
        //message_Btn
       //    cell.message_Btn.addTarget(self, action: #selector(goToMessage), for: .touchUpInside)
        return cell
    }
    
    //MARK:- UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
          return UITableView.automaticDimension
    }
    @objc func goToMessage(_ sender: UIButton) {
        
        let message = self.storyboard?.instantiateViewController(withIdentifier: "MentorChatVC") as! MentorChatVC
        self.navigationController?.pushViewController(message, animated: true)
    }
}
