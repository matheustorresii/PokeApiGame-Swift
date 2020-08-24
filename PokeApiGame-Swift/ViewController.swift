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
  @IBOutlet weak var pokemonImage: UIImageView!
  @IBOutlet weak var lastPokemonLabel: UILabel!
  
  let pokemonsInRoute: [Int] = [1, 4, 7]
  
  var playerX: CGFloat = 0
  var playerY: CGFloat = 0
  var adventureTile: Float = 0
  
  var currentPokemon: String = ""
  
  var onBattle: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    adventureTile = Float(adventure.frame.width)/8
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
  }

  @IBAction func goUp(_ sender: Any) {
    if onBattle { return }
    player.image = UIImage(named: "up")
    if playerY < CGFloat(adventureTile * 2) {
      return
    }
    player.frame.origin = CGPoint(
      x: playerX,
      y: playerY - CGFloat(adventureTile)
    )
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
    checkGrass()
  }
  
  @IBAction func goDown(_ sender: Any) {
    if onBattle { return }
    player.image = UIImage(named: "down")
    if playerY > CGFloat(adventureTile * 6) {
      return
    }
    player.frame.origin = CGPoint(
      x: playerX,
      y: playerY + CGFloat(adventureTile)
    )
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
    checkGrass()
  }
  
  @IBAction func goLeft(_ sender: Any) {
    if onBattle { return }
    player.image = UIImage(named: "left")
    if playerX < CGFloat(adventureTile) {
      return
    }
    player.frame.origin = CGPoint(
      x: playerX - CGFloat(adventureTile),
      y: playerY
    )
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
    checkGrass()
  }
  
  @IBAction func goRight(_ sender: Any) {
    if onBattle { return }
    player.image = UIImage(named: "right")
    if playerX > CGFloat(adventureTile * 6) {
      return
    }
    player.frame.origin = CGPoint(
      x: playerX + CGFloat(adventureTile),
      y: playerY
    )
    playerX = player.frame.origin.x
    playerY = player.frame.origin.y
    checkGrass()
  }
  
  @IBAction func capture(_ sender: Any) {
    if !onBattle { return }
    onBattle = false
    adventure.image = UIImage(named: "route")
    DispatchQueue.main.async {
      self.player.image = UIImage(named: "down")
      self.pokemonImage.image = nil
    }
    lastPokemonLabel.text = "Last Pokemon: \(currentPokemon)"
  }
  
  func checkGrass(){
    if playerX < CGFloat(adventureTile * 5), playerY > CGFloat(adventureTile * 6){
      genPokemon()
    }else if playerX < CGFloat(adventureTile * 2), playerY > CGFloat(adventureTile * 5){
      genPokemon()
    }else if playerX < CGFloat(adventureTile), playerY > CGFloat(adventureTile * 4){
      genPokemon()
    }
  }
  
  func genPokemon(){
    let random = Int.random(in: 0...2)
    if(random == 0){
      let randomPokemonId: Int = pokemonsInRoute[Int.random(in: 0..<pokemonsInRoute.count)]
      fetchPokemon(randomPokemonId)
    }
  }
  
  func fetchPokemon(_ pokemonId: Int){
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)")
    
    let task = URLSession.shared.dataTask(with: url!){
      (data, response, error) in
      if let data = data {
        if let json = try? JSONDecoder().decode(Pokemon.self, from: data){
          self.changeForBattle(json)
        }
      }
    }
    task.resume()
  }
  
  func changeForBattle(_ encounteredPokemon: Pokemon){
    onBattle = true
    downloadImage(urlstr: "https://i.imgur.com/B6uhcTZ.png", imageView: adventure)
    downloadImage(
      urlstr: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/00\(encounteredPokemon.id).png",
      imageView: pokemonImage)
    currentPokemon = encounteredPokemon.name
    DispatchQueue.main.async {
      self.player.image = nil
    }
  }
  
  func downloadImage(urlstr: String, imageView: UIImageView) {
      let url = URL(string: urlstr)!
      let task = URLSession.shared.dataTask(with: url) { data, _, _ in
          guard let data = data else { return }
          DispatchQueue.main.async { // Make sure you're on the main thread here
              imageView.image = UIImage(data: data)
          }
      }
      task.resume()
  }
}

struct Pokemon: Decodable {
  var id: Int
  var name: String
}
