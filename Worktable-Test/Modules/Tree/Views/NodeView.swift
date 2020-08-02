//
//  NodeView.swift
//  Worktable-Test
//
//  Created by Zubair on 31/07/20.
//  Copyright © 2020 Zubair. All rights reserved.
//

import UIKit

class NodeView: UIView {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPackage: UILabel!
    @IBOutlet weak var lblRelationType: UILabel!
    @IBOutlet weak var viewCircle: UIView!
    let nibName = "NodeView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        viewCircle.round()
        lblPackage.isHidden = true
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
