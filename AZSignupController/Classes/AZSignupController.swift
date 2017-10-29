import UIKit
import AVFoundation
import TinyConstraints

class AZSignupController: UIViewController {
    var playerView: AZPlayerView
    var loginButton: UIButton
    var signupButton: UIButton
    var scrollView: UIScrollView
    var textArray: Array<String>
    var imageArray: Array<UIImage>

    
    // MARK: - Initialization
    
    init() {
        self.playerView = AZPlayerView.init(frame: CGRect.zero)
        self.loginButton = UIButton.init(type: .system)
        self.signupButton = UIButton.init(type: .system)
        self.scrollView = UIScrollView.init()
        self.textArray = Array()
        self.imageArray = Array()

        super.init(nibName: nil, bundle: nil)
        restorationIdentifier = String(describing: type(of: self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    func viewSetup() {
        view.addSubview(playerView)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        loginButton.height(80)
        loginButton.widthToSuperview(nil, multiplier: 0.5, offset: 0, relation: .equal, priority: .required, isActive: true)
        loginButton.left(to: view)
        
        signupButton.height(80)
        signupButton.widthToSuperview(nil, multiplier: 0.5, offset: 0, relation: .equal, priority: .required, isActive: true)
        signupButton.rightToLeft(of: loginButton)
        
        //playerView.heightToSuperview(nil, multiplier: 1, offset: -loginButton.heightAnchor, relation: .equal, priority: .required, isActive: true)
        playerView.width(to: view)
        playerView.edgesToSuperview(excluding: .bottom)
        playerView.bottomToTop(of: signupButton)
        
        scrollView.edgesToSuperview()
        scrollView.width(to: playerView)
        scrollView.height(to: playerView)
    }
}

@IBDesignable public class AZPlayerView: UIView {
    var player: AVPlayer?
    var avPlayerLayer: AVPlayerLayer!
    var videoURL: NSURL = NSURL()
    var cView: UIView = UIView()
    let screenSize = UIScreen.main.bounds
    
    @IBInspectable
    public var name: String = "test" {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    @IBInspectable
    public var mime: String = "mp4" {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    @IBInspectable
    public var repeats: Bool = true {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    @IBInspectable
    public var muted: Bool = true {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    @IBInspectable
    public var layerAlpha: CGFloat = 0.5 {
        didSet {
            inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        inits(resource: name, extensionFormat: mime, repeats: repeats, muted: muted, alpha: layerAlpha)
    }
    
    func inits(resource: String, extensionFormat: String, repeats: Bool, muted: Bool, alpha: CGFloat) {
        
        setLayer()
        
        guard let video = Bundle.main.url(forResource: resource, withExtension: extensionFormat) else {
            return
        }
        videoURL = video as NSURL
        
        if (player == nil) {
            player = AVPlayer(url: videoURL as URL)
            player?.actionAtItemEnd = .none
            player?.isMuted = muted
            
            avPlayerLayer = AVPlayerLayer(player: player)
            avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            avPlayerLayer.zPosition = -1
            avPlayerLayer.frame = screenSize
            
            player?.play()
            
            layer.addSublayer(avPlayerLayer)
        }
        
        if repeats {
            NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        }
        
    }
    
    @objc func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
    func setLayer() {
        if cView.isDescendant(of: self) {
            cView.removeFromSuperview()
        } else {
            cView = UIView.init(frame: screenSize)
            cView.backgroundColor = UIColor.black
            cView.alpha = layerAlpha;
            cView.layer.zPosition = 0;
            self.addSubview(cView)
        }
    }
}
