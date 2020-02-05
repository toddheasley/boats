import UIKit
import BoatsKit

class IndexView: MainView, ListViewDelegate {
    var isLinkControlHidden: Bool = false {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    @objc func handleLink(control: LinkControl) {
        guard let url: URL = control.url else {
            return
        }
        delegate?.mainView(self, didOpen: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: TitleLabel = TitleLabel()
    private let linkControl: LinkControl = LinkControl()
    private let listView: ListView = ListView()
    
    // MARK: MainView
    override var index: Index {
        didSet {
            titleLabel.text = index.description
            linkControl.text = index.name
            linkControl.url = index.url
            listView.index = index
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        var contentRect: CGRect = self.contentRect
        
        titleLabel.frame.size.width = contentRect.size.width
        titleLabel.frame.origin.x = 0.0
        titleLabel.frame.origin.y = isLinkControlHidden ? 0.0 : 15.0
        
        linkControl.frame.size.width = linkControl.intrinsicContentSize.width
        linkControl.frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height
        linkControl.isHidden = isLinkControlHidden
        
        listView.frame.size.width = contentRect.size.width
        listView.frame.size.height = listView.intrinsicContentSize.height
        listView.frame.origin.x = 0.0
        listView.frame.origin.y = linkControl.frame.origin.y + (isLinkControlHidden ? 21.0 : linkControl.frame.size.height + 9.0)
        
        contentRect.size.height = listView.frame.origin.y + listView.frame.size.height
        contentView.frame = contentRect
        
        super.layoutSubviews()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        listView.contentOffset = scrollView.contentOffset
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = false
        
        titleLabel.frame.size.height = 25.0
        contentView.addSubview(titleLabel)
        
        linkControl.addTarget(self, action: #selector(handleLink(control:)), for: .touchUpInside)
        contentView.addSubview(linkControl)
        
        listView.delegate = self
        contentView.addSubview(listView)
    }
    
    // MARK: ListViewDelegate
    func listView(_ view: ListView, didSelect route: Route) {
        delegate?.mainView(self, didSelect: route)
    }
}
