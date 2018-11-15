//
//  ViewAnimeInfoViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import WebKit
class ViewAnimeInfoViewController: UIViewController {
    weak var animeInfo:AnimeInfo?;
    weak var userInfo:Users?;
    var episodes:[Episodes]?=[];
    var selectedEpisode:Episodes?;
    @IBOutlet weak var UIScrollView: UIScrollView!
    @IBOutlet weak var UIBackgroundImage: UIImageView!
    @IBOutlet weak var UIProfileImage: UIImageView!
    @IBOutlet weak var UIEpisodeTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIEpisodeTV.delegate=self;
        self.UIEpisodeTV.dataSource=self;
        self.LoadAll();
        DispatchQueue.main.async {
            self.UIBackgroundImage.image=URLGetter.fetchImage(url: self.animeInfo!.backgroundImg);
            self.UIProfileImage.image=URLGetter.fetchImage(url: self.animeInfo!.profileImg);
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewInfoToVideoPlayer"{
            let destVC=segue.destination as! URLVideoViewController;
            destVC.url=URLGetter.toURL(url: selectedEpisode!.source);
        }
    }
}
//MARK: UITableView func
extension ViewAnimeInfoViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes?.count ?? 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text = self.episodes![indexPath.row].title;
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true);
        self.selectedEpisode=self.episodes![indexPath.row];
        performSegue(withIdentifier: "viewInfoToVideoPlayer", sender: nil);
    }
}
//MARK: Firebase Func
extension ViewAnimeInfoViewController{
    func LoadAll(){
        if self.episodes!.count <= 0 {
            Episodes.all(animeTitle: self.animeInfo!.id, completionHandler: {
                (episode, err) in
                print(episode?.title);
                self.episodes?.append(episode!);
                self.UIEpisodeTV.reloadData()
            })
        }
    }
}


