//
//  AccountSummaryHeaderView.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryHeaderView: UIView {
	@IBOutlet var contentView: UIView!
	
	@IBOutlet weak var welcomeLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	lazy var shakeyBell: ShakeyBellView = {
		let bell = ShakeyBellView()
		bell.translatesAutoresizingMaskIntoConstraints = false
		return bell
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIView.noIntrinsicMetric, height: 170)
	}
	
	private func commonInit() {
		let bundle = Bundle(for: AccountSummaryHeaderView.self)
		bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
		addSubview(contentView)
		addSubview(shakeyBell)
		contentView.backgroundColor = .appColor
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		shakeyBell.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		shakeyBell.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
}
