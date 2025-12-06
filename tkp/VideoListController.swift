
import UIKit
import AVKit
import MobileCoreServices

class VideoListController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var videos: [URL] = []
    private let table = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TKP Player"
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加视频", style: .plain, target: self, action: #selector(addVideo))

        table.frame = view.bounds
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(table)
    }

    @objc func addVideo() {
        let picker = UIImagePickerController()
        picker.mediaTypes = ["public.movie"]
        picker.delegate = self
        picker.videoQuality = .typeHigh
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let url = info[.mediaURL] as? URL {
            videos.append(url)
            table.reloadData()
        }
    }
}

extension VideoListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { videos.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        c.textLabel?.text = "视频 \(indexPath.row+1)"
        return c
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = AVPlayerViewController()
        player.player = AVPlayer(url: videos[indexPath.row])
        present(player, animated: true) {
            player.player?.play()
        }
    }
}
