//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import UIKit

class CountryTableViewCell: BaseTableViewCell<Country> {

    private let countryNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        return lbl
    }()


    private let countryCapitalLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    var countryRegionLbl : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(countryNameLbl)
        addSubview(countryRegionLbl)
        addSubview(countryCapitalLbl)


        countryNameLbl.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 150, width: 0, height: 0, enableInsets: false)
        countryCapitalLbl.anchor(top: topAnchor, left: countryNameLbl.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        countryRegionLbl.anchor(top: countryCapitalLbl.bottomAnchor, left: countryNameLbl.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)



    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func render() {
        self.countryNameLbl.text = NSLocalizedString("\(self.item?.name ?? "no name specified.")", comment: "")
        self.countryRegionLbl.text = self.item?.region == "" ? NSLocalizedString("no region specified.", comment: "") : NSLocalizedString("region: \(self.item?.region ?? "no region found.")", comment: "")
        self.countryCapitalLbl.text = self.item?.capital == "" ? NSLocalizedString("no capital specified.", comment: "") : NSLocalizedString("capital: \(self.item?.capital ?? "no capital found.")", comment: "")
    }


}
