//
//  FLCarouselView.swift
//  FLCarouselView
//
//  Created by clarence on 16/11/26.
//  Copyright © 2016年 gitKong. All rights reserved.
//

import UIKit
import ImageIO

class FLCarouselView: UIView {
    
    fileprivate var DEFAULT_DES_Label_HEIGHT : CGFloat = 20
    
    fileprivate var DEFAULT_TIME : CGFloat = 5
    
    fileprivate var DEFAULT_MARGIN : CGFloat = 5
    
    fileprivate var currentIndex : Int = 0
    
    fileprivate var nextIndex : Int = 0
    
    // 原始传入数组，Any类型
    fileprivate var arrM = NSMutableArray.init()
    // 全是UIImage 数组
    fileprivate var tempArrM = NSMutableArray.init()
    
    fileprivate var tempTimeInterval : Double = 3.0
    
    fileprivate var tempPageControlPosition : FLPageControlPosition = FLPageControlPosition.BottomCenter
    
    fileprivate var timer : Timer? = nil
    
    fileprivate var tempDescribeLabels : NSMutableArray = NSMutableArray.init()
    
    fileprivate var pageControlSize : CGSize = CGSize.zero
    
    
//    fileprivate var cache =
    
    enum FLCarouselMode {
        case Default
        case Fade
    }
    
    enum FLPageControlPosition {
        case Default
        case Hide
        case TopCenter
        case BottomLeft
        case BottomCenter
        case BottomRight
    }
    
    public var carouselMode : FLCarouselMode?
    
    
    var pageControlPosition : FLPageControlPosition{
        set(newPageControlPosition){
            tempPageControlPosition = newPageControlPosition
            if newPageControlPosition == FLPageControlPosition.Hide{
                pageControl.isHidden = true
            }
            if pageControl.isHidden {
                return
            }
            var size : CGSize = CGSize.zero
            if pageControlSize.width != 0 {
                size = pageControl.size(forNumberOfPages: pageControl.numberOfPages)
                size.height = 8
            }
            else{
                size = CGSize.init(width: pageControlSize.width * CGFloat(pageControl.numberOfPages * 2 - 1), height: pageControlSize.height)
            }
            pageControl.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            let centerY = self.height() - size.height * 0.5 - DEFAULT_MARGIN - (describeLabel.isHidden ? 0 : DEFAULT_DES_Label_HEIGHT)
            let pointY = self.height() - size.height - DEFAULT_MARGIN - (describeLabel.isHidden ? 0 : DEFAULT_DES_Label_HEIGHT)
            if pageControlPosition == FLPageControlPosition.Default || pageControlPosition == FLPageControlPosition.BottomCenter  {
                pageControl.center = CGPoint.init(x: self.width() * 0.5, y: centerY)
            }
            else if pageControlPosition == FLPageControlPosition.TopCenter {
                pageControl.center = CGPoint.init(x: self.width() * 0.5, y: size.height * 0.5 + DEFAULT_MARGIN)
            }
            else if pageControlPosition == FLPageControlPosition.BottomLeft {
                pageControl.frame = CGRect.init(x: 2 * DEFAULT_MARGIN, y: pointY, width: size.width, height: size.height)
            }
            else {
                pageControl.frame = CGRect.init(x: self.width() - 2 * DEFAULT_MARGIN - size.width, y: pointY, width: size.width, height: size.height)
            }
        }
        
        get{
            return tempPageControlPosition
        }
    }
    
    public var placeholderImage = UIImage.init(named: "FLPlaceholder")
    
    var images : NSMutableArray {
        
        set(newImages){
            // 清空，重新保存一份
            arrM.removeAllObjects()
            tempArrM.removeAllObjects()
            arrM = newImages
            
            if newImages.count == 0 {
                pageControl.isHidden = true
                return
            }
            for i in 0 ..< newImages.count {
                let image = newImages[i]
                if image is UIImage {
                    tempArrM.add(image)
                }
                else if image is String{
                    tempArrM.add(placeholderImage!)
                    self.downLoadImage(index: i)
                }
            }
            
            if currentIndex > newImages.count {
                currentIndex = newImages.count - 1
            }
            currentImageView.image = tempArrM[currentIndex] as? UIImage
//            describeLabel.text = tempDescribeLabels[currentIndex] as? String
            pageControl.numberOfPages = newImages.count
            self.layoutSubviews()
            
        }
        get{
            return tempArrM
        }
    }
    
    public var describeLabels : NSMutableArray {
        
        set(newDescribeLabels){
            tempDescribeLabels = newDescribeLabels
            
            if tempDescribeLabels.count == 0 {
                self.describeLabel.isHidden = true
            }
            else{
                if tempDescribeLabels.count < tempArrM.count {
                    let describes = NSMutableArray.init(array: tempDescribeLabels)
                    for _ in tempDescribeLabels.count ..< tempArrM.count {
                        describes.add("")
                    }
                    tempDescribeLabels = describes
                }
                self.describeLabel.isHidden = false
                self.describeLabel.text = tempDescribeLabels[currentIndex] as? String
            }
            self.pageControlPosition = tempPageControlPosition
        }
        
        get{
            return tempDescribeLabels
        }
        
    }
    
    public var timeInterval : Double?{
        // 在此才完成setter方法
        didSet{
            if let value = timeInterval {
                
                tempTimeInterval = value
                
                if value <= 0.0 {
                    self.stopTimer()
                }
                else{
                    self.startTimer()
                }
            }
        }
    }
    
    public func fl_describeText(color : UIColor,font : UIFont,backgroundColor : UIColor) {
        self.describeLabel.textColor = color
        self.describeLabel.font = font
        self.describeLabel.backgroundColor = backgroundColor
    }
    
    public func fl_pageControlColor(normalColor : UIColor,currentColor : UIColor) {
        pageControl.pageIndicatorTintColor = normalColor
        pageControl.currentPageIndicatorTintColor = currentColor
    }
    
    public func fl_pageControlImage(normalImage : String,currentImage : String){
        // String 默认不能传nil
        if normalImage == "" || currentImage == "" {
            return
        }
        let normalImg = UIImage.init(named: normalImage)
        let currentImg = UIImage.init(named: currentImage)
        // 保存size
        pageControlSize = (normalImg?.size)!
        pageControl.setValue(currentImg, forKey: "_currentPageImage")
        pageControl.setValue(normalImg, forKey: "_pageImage")
        
    }
    
    fileprivate func startTimer() {
        if tempArrM.count <= 1 {
            return
        }
        
        self.stopTimer()
        
        // 创建定时器
        if let time = timeInterval {
            timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(self.nextPage), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    fileprivate func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc fileprivate func nextPage() {
        print("hello world")
        if carouselMode == FLCarouselMode.Fade {
            nextIndex = (currentIndex + 1) % tempArrM.count
            otherImageView.image = tempArrM[nextIndex] as? UIImage
            
            // 动画
    
            UIView.animate(withDuration: 1.2, animations: { 
                self.currentImageView.alpha = 0
                self.otherImageView.alpha = 1
                self.pageControl.currentPage = self.nextIndex
            }, completion: { (finish) in
                self.changeToNext()
            })
        }
        else{
            scrollView.setContentOffset(CGPoint.init(x: self.width() * 3, y: 0), animated: true)
        }
    }
    
    fileprivate func downLoadImage(index : Int){
        let urlString = self.arrM[index] as! String
        let imageName = urlString.replacingOccurrences(of: "/", with: "")
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/" + imageName
        
        let data = NSData.init(contentsOfFile: path)
        if data != nil {
            tempArrM[index] = getImageWithData(data: data! as Data)
            return
        }
        
        let download = BlockOperation.init {
            //编码出现error：Call can throw, but it is not marked with 'try' and the error is not handled，通过加一个try解决。原因就是没有处理错误
            do{
                let data =
                    try  Data.init(contentsOf: URL.init(string: urlString)!)
                let image = self.getImageWithData(data: data)
                
                // 改为替换
                self.tempArrM.replaceObject(at: index, with: image)
                
                do{
                    try data.write(to: URL.init(fileURLWithPath: path), options: Data.WritingOptions.atomic)
                }catch{
                    print("write error")
                }
                
            }catch{
                print("error")
            }
        }
        self.queue.addOperation(download)
    }
    
    fileprivate func getImageWithData(data : Data) -> UIImage{
        let imageSource = CGImageSourceCreateWithData(data as CFData, nil)
        let count = CGImageSourceGetCount(imageSource!)
        if count <= 1 {// 不是gif
//            imageSource.release
            return UIImage.init(data: data)!
        }
        else{// gif
            var imagesArrM  = Array<Any>()
            var duration : CGFloat = 0.0
            for i in 0 ..< count {
                let image = CGImageSourceCreateImageAtIndex(imageSource!, i, nil)
                if image == nil {
                    continue
                }
                duration += durationWithSourceAtIndex(source: imageSource!, index: i)
                imagesArrM.append(UIImage.init(cgImage: image!))
//                CGImageRe
            }
            if duration == 0 {
                duration = CGFloat(count) * 0.1
            }
            
            // imageSource.release
            return UIImage.animatedImage(with: imagesArrM as! [UIImage], duration: TimeInterval(duration))!
        }
    }
    
    fileprivate func durationWithSourceAtIndex(source : CGImageSource,index : Int) -> CGFloat{
        var duration : CGFloat = 0.1
        let propertiesRef = CGImageSourceCopyPropertiesAtIndex(source,index,nil)
        let properties = propertiesRef as! NSDictionary
        let gifProperties = properties[String(kCGImagePropertyGIFDictionary)] as! NSDictionary
        var delayTime = gifProperties[String(kCGImagePropertyGIFUnclampedDelayTime)] as! NSNumber
        if delayTime.boolValue {
            duration = CGFloat(delayTime.floatValue)
        }
        else{
            delayTime = gifProperties[String(kCGImagePropertyGIFDelayTime)] as! NSNumber
            if delayTime.boolValue {
                duration = CGFloat(delayTime.floatValue)
            }
        }
        return duration
    }
    
    override class func initialize() {
        var isDir : ObjCBool = false
        let cacheString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/" + "FLCarousel"
        
        let isExits = FileManager.default.fileExists(atPath: cacheString as String, isDirectory: &isDir)
        if isDir.boolValue == false || isExits == false {
            do {
                try FileManager.default.createDirectory(atPath: cacheString, withIntermediateDirectories: true, attributes: nil)
                
            
            } catch {
                print("error")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initSubviews() {
        self.addSubview(self.scrollView)
        self.addSubview(self.describeLabel)
        self.addSubview(self.pageControl)
        //   默认
        tempPageControlPosition = FLPageControlPosition.BottomCenter
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //有导航控制器时，会默认在scrollview上方添加64的内边距，这里强制设置为0
        self.scrollView.contentInset = UIEdgeInsets.zero
        
        self.scrollView.frame = self.bounds
        self.describeLabel.frame = CGRect.init(x: 0, y: self.height() - DEFAULT_DES_Label_HEIGHT, width: self.width(), height: DEFAULT_DES_Label_HEIGHT)
        
        self.pageControlPosition = tempPageControlPosition
        // 设置scrollView的位置
        self.setScrollViewContentSize()
    }
    
    @objc fileprivate func imageClick(){
        print("hello world \(self.currentIndex)")
    }
    
    fileprivate func setScrollViewContentSize() {
        if tempArrM.count > 1 {
            self.scrollView.contentSize = CGSize.init(width: self.width() * 5, height: 0)
            self.scrollView.contentOffset = CGPoint.init(x: self.width() * 2, y: 0)
            self.currentImageView.frame = CGRect.init(x: self.width() * 2, y: 0, width: self.width(), height: self.height())
            
            if carouselMode == FLCarouselMode.Fade {
                // 淡入淡出
                currentImageView.frame = CGRect.init(x: 0, y: 0, width: self.width(), height: self.height())
                otherImageView.frame = currentImageView.frame
                otherImageView.alpha = 0
                self.insertSubview(currentImageView, at: 0)
                self.insertSubview(otherImageView, at: 1)
            }
        }
        else{
            scrollView.contentSize = CGSize.zero
            scrollView.contentOffset = CGPoint.zero
            currentImageView.frame = CGRect.init(x: 0, y: 0, width: self.width(), height: self.height())
        }
    }
    
    
    lazy fileprivate var scrollView: UIScrollView = {
        let _scrollView = UIScrollView.init()
        _scrollView.scrollsToTop = false
        _scrollView.isPagingEnabled = true
        _scrollView.bounces = false
        _scrollView.showsVerticalScrollIndicator = false
        _scrollView.showsHorizontalScrollIndicator = false
        _scrollView.delegate = self
        _scrollView.backgroundColor = UIColor.clear
        // 添加手势监听图片点击
        _scrollView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(imageClick)))
        
        _scrollView.addSubview(self.currentImageView)
        _scrollView.addSubview(self.otherImageView)
        return _scrollView
    }()
    
    lazy fileprivate var currentImageView : UIImageView = {
        let _currentImageView = UIImageView.init()
        _currentImageView.clipsToBounds = true
        return _currentImageView
    }()
    
    lazy fileprivate var otherImageView : UIImageView = {
        let _otherImageView = UIImageView.init()
        _otherImageView.clipsToBounds = true
        return _otherImageView
    }()
    
    lazy fileprivate var describeLabel : UILabel = {
        let _label = UILabel.init()
        _label.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        _label.textAlignment = NSTextAlignment.center
        _label.font = UIFont.systemFont(ofSize: 13)
        return _label
    }()
    
    lazy fileprivate var pageControl : UIPageControl = {
        let _pageControl = UIPageControl.init()
        _pageControl.isUserInteractionEnabled = false
        return _pageControl
    }()
    
    lazy fileprivate var queue : OperationQueue = {
        let _queue = OperationQueue.init()
        return _queue
    }()
    
    fileprivate func height() -> CGFloat {
        return self.scrollView.frame.size.height
    }
    
    fileprivate func width() -> CGFloat {
        return self.scrollView.frame.size.width
    }
    
    fileprivate func changeCurrentPage(offsetX : CGFloat){
        if offsetX < self.width() * 1.5 {
            var index = currentIndex - 1
            if index < 0 {
                index = tempArrM.count - 1
            }
            pageControl.currentPage = index
        }
        else if offsetX > self.width() * 2.5 {
            pageControl.currentPage = (currentIndex + 1) % tempArrM.count
        }
        else{
            pageControl.currentPage = currentIndex
        }
    }
}




extension FLCarouselView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize == CGSize.zero {
            return
        }
        let offsetX = scrollView.contentOffset.x
        
        self.changeCurrentPage(offsetX: offsetX)
        
        if offsetX < self.width() * 2 {
            
            if carouselMode == FLCarouselMode.Fade {
                currentImageView.alpha = offsetX / self.width() - 1
                otherImageView.alpha = 2 - offsetX / self.width()
            }
            else{
                otherImageView.frame = CGRect.init(x: self.width(), y: 0, width: self.width(), height: self.height())
            }
            
            nextIndex = currentIndex - 1
            if nextIndex < 0 {
                nextIndex = tempArrM.count - 1
            }
            self.otherImageView.image = tempArrM[nextIndex] as? UIImage
            if offsetX < self.width() {
                self.changeToNext()
            }
        }
        else if offsetX > self.width() * 2 {
            if carouselMode == FLCarouselMode.Fade {
                currentImageView.alpha = offsetX / self.width() - 2
                otherImageView.alpha = 3 - offsetX / self.width()
            }
            else{
                otherImageView.frame = CGRect.init(x: currentImageView.frame.maxX, y: 0, width: self.width(), height: self.height())
            }
            
            
            nextIndex = (currentIndex + 1) % tempArrM.count
            self.otherImageView.image = tempArrM[nextIndex] as? UIImage
            if offsetX > self.width() * 3 {
                self.changeToNext()
            }
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if carouselMode == FLCarouselMode.Fade {
            return
        }
        let currentPointInSelf = self.scrollView.convert(self.currentImageView.frame.origin, to: self)
        if currentPointInSelf.x >= -self.width() / 2 && currentPointInSelf.x <= self.width() / 2 {
            self.scrollView .setContentOffset(CGPoint.init(x: self.width() * 2, y: 0), animated: true)
        }
        else{
            self.changeToNext()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let time = timeInterval {
            if time > 0.0 {
                self.startTimer()
            }
        }
    }
    
    fileprivate func changeToNext(){
        if carouselMode == FLCarouselMode.Fade {
            self.currentImageView.alpha = 1
            self.otherImageView.alpha = 0
        }
        self.currentImageView.image = self.otherImageView.image
        self.scrollView.contentOffset = CGPoint.init(x: self.width() * 2, y: 0)
        self.scrollView.layoutSubviews()
        currentIndex = nextIndex
        self.pageControl.currentPage = currentIndex
        self.describeLabel.text = tempDescribeLabels[currentIndex] as? String
    }
    
}
