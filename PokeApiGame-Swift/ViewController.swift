//
//  ViewController.swift
//  PokeApiGame-Swift
//
//  Created by Matheus Torres on 22/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var player: UIImageView!
  @IBOutlet weak var adventure: UIImageView!
  
  var playerX: CGFloat = 0
  var playerY: CGFloat = 0
  var adventureTile: Float = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    adventureTile = Float(adventure.frame.width)/8.2
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
  }

  @IBAction func goUp(_ sender: Any) {
    player.image = UIImage(named: "up")
    player.frame.origin = CGPoint(
      x: playerX,
      y: playerY - CGFloat(adventureTile)
    )
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
  }
  
  @IBAction func goDown(_ sender: Any) {
    player.image = UIImage(named: "down")
    player.frame.origin = CGPoint(
      x: playerX,
      y: playerY + CGFloat(adventureTile)
    )
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
  }
  
  @IBAction func goLeft(_ sender: Any) {
    player.image = UIImage(named: "left")
    player.frame.origin = CGPoint(
      x: playerX - CGFloat(adventureTile),
      y: playerY
    )
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
  }
  
  @IBAction func goRight(_ sender: Any) {
    player.image = UIImage(named: "right")
    player.frame.origin = CGPoint(
      x: playerX + CGFloat(adventureTile),
      y: playerY
    )
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
  }
  
  @IBAction func capture(_ sender: Any) {
  }
}

