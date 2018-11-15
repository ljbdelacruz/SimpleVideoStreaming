//
//  DashboardViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    var userLoginInfo:Users?
    var animeList:[AnimeInfo]?=[];
    var selectedAnime:AnimeInfo?;
    var origList:[AnimeInfo]?=[];
    @IBOutlet weak var UIAnimeListTV: UITableView!
    @IBOutlet weak var UIAnimeSB: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.UIAnimeListTV.delegate=self;
        self.UIAnimeListTV.dataSource=self;
        self.UIAnimeSB.delegate=self;
        self.LoadAll()
        self.UIAnimeListTV.register(UINib(nibName: "ImageTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTitleCell");
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("Disappear");
        self.userLoginInfo=nil;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animeToviewInfo" {
            let destVC=segue.destination as! ViewAnimeInfoViewController;
            destVC.animeInfo=self.selectedAnime;
            destVC.userInfo=self.userLoginInfo;
        }
    }
    @IBAction func OnQRScan(_ sender: Any){
        performSegue(withIdentifier: "dashboardToQRScanner", sender: nil);
    }
}
//MARK: firebase func
extension DashboardViewController{
    func LoadAll(){
        if self.origList!.count <= 0{
            AnimeInfo.all(completionHandler: {
                (data, err) in
                if err == nil{
                    self.animeList?.append(data!);
                    self.origList?.append(data!);
                    self.UIAnimeListTV.reloadData()
                }
            })
        }else if self.UIAnimeSB.text!.count > 0{
            self.animeList=self.origList?.filter({$0.name.lowercased().contains(self.UIAnimeSB.text!.lowercased())})
            self.UIAnimeListTV.reloadData();
        }else if self.UIAnimeSB.text!.count <= 0{
            self.animeList=self.origList
            self.UIAnimeListTV.reloadData();
        }
    }
}
//MARK: TableView Functionalities
extension DashboardViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animeList?.count ?? 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTitleCell", for: indexPath) as! ImageTitleTableViewCell
        cell.UICellLabel.text=self.animeList![indexPath.row].name;
        print(self.animeList![indexPath.row].name)
        DispatchQueue.global(qos:.background).async {
            cell.UICellImage.image=URLGetter.fetchImage(url: self.animeList![indexPath.row].profileImg);
        }
        return cell;
    }
}
//MARK: UISearchBar Func
extension DashboardViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.UIAnimeSB.text!.count <= 0{
            self.LoadAll();
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.LoadAll()
    }
}
