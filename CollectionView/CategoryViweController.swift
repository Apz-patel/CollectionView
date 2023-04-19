//
//  ViewController.swift
//  CollectionView
//
//  Created by R&W on 01/01/35.
//

import UIKit


struct PC{
    var brandName: String
    var proccesor: String
    var softWare: String
    var price: Double
}
struct Car{
    var brandName: String
    var price: Double
}

class CategoryViweController: UIViewController {

    @IBOutlet weak var deskTopComponentsCollectionView: UICollectionView!
    
    var  arrOfDeskTop: [PC] = []
    var arrOfCar: [Car] = []
    var numberOfItemInRow: Int = 3
    var interItemSpac: CGFloat = 20
    var selectedIndex: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
    }
    private func setup(){
        loadDesktopItems()
        loadCarItems()
        categoryConfigure()
    }
    private func loadDesktopItems(){
        let assusDesktop: PC = PC(brandName: "Mac", proccesor: "m2 chip", softWare: "macOs", price: 20000)
        let hpDesktop: PC = PC(brandName: "lenovo", proccesor: "i7", softWare: "Window 11", price: 7000)
        let lenovo: PC = PC(brandName: "asus", proccesor: "R 5", softWare: "Window 11", price: 62000)
        arrOfDeskTop = [assusDesktop,hpDesktop,lenovo]
    }
    private func loadCarItems(){
        let car1: Car = Car(brandName: "mercy", price: 8000000)
        let car2: Car = Car(brandName: "rolse royal", price: 5000000)
        let car3: Car = Car(brandName: "kk", price: 6000000)
        arrOfCar = [car1,car2,car3]
    }
    private func categoryConfigure(){
        let nibFile: UINib = UINib(nibName: "DesktopCollectionViewCell", bundle: nil)
        deskTopComponentsCollectionView.register(nibFile, forCellWithReuseIdentifier: "DesktopCollectionViewCell")
        
        deskTopComponentsCollectionView.register(UINib(nibName: "CarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCollectionViewCell")
    }
}

extension CategoryViweController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return   section == 0 ? arrOfDeskTop.count : arrOfCar.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell: DesktopCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesktopCollectionViewCell", for: indexPath) as! DesktopCollectionViewCell
            let desktopItem = arrOfDeskTop[indexPath.row]
            cell.nameLable.text = "\(desktopItem.price)"
            
            if indexPath.row == selectedIndex{
                cell.layer.borderColor = UIColor.red.cgColor
            } else {
                cell.layer.borderColor = UIColor.black.cgColor
            }
            cell.layer.borderWidth = 1
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            return cell
        }else{
            let cell: CarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell", for: indexPath) as! CarCollectionViewCell
            let carItem = arrOfCar[indexPath.row]
            cell.carCellLabel.text = "\(carItem.price)"
            cell.layer.borderWidth = 1
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            selectedIndex = indexPath.row
            let cell: DesktopCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesktopCollectionViewCell", for: indexPath) as! DesktopCollectionViewCell
            let desktopItem = arrOfDeskTop[indexPath.row]
            collectionView.reloadData()
        }
    }
}
extension CategoryViweController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let spacing = CGFloat(numberOfItemInRow+1)*interItemSpac
            let avilableWidth = collectionView.frame.width - spacing
            let cellWidth = avilableWidth / CGFloat(numberOfItemInRow)
            return CGSize(width: cellWidth, height: 100)
        }else{
            let spacing = CGFloat(numberOfItemInRow+1)*interItemSpac
            let avilableWidth = collectionView.frame.width - spacing
            let cellWidth = avilableWidth / CGFloat(numberOfItemInRow)
            return CGSize(width: cellWidth, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
