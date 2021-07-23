//Copyright (c) 2021 Alexander Vankov (Александр Ваньков)

class Field {
  // FD - это двумерный массив, хрянящий все данные поля
  var FD = Array(repeating: Array(repeating: " ", count: 10), count: 10)
  var name: String
  var mode: Int

  init(name: String, mode: Int) {
    self.name = name
    self.mode = mode
    // четырехпалубный корабль:
    var head4y = Int.random(in: 0...9)
    var head4x = Int.random(in: 0...9)
    var direction = Int.random(in: 0...1)
    if direction == CONST.VERTICAL {
      if head4y > 6 { head4y = 6 }
      FD[head4y][head4x] = "#"
      FD[head4y+1][head4x] = "#"
      FD[head4y+2][head4x] = "#"
      FD[head4y+3][head4x] = "#"
    } else if direction == CONST.HORISONTAL {
      if head4x > 6 { head4x = 6 }
      FD[head4y][head4x] = "#"
      FD[head4y][head4x+1] = "#"
      FD[head4y][head4x+2] = "#"
      FD[head4y][head4x+3] = "#"
    }
    ships.append(Ship(field: mode, decks: 4, coordy: head4y, coordx: head4x, direction: direction))
    // трехпалубные корабли:
    for _ in 1...2 {
      var genagain = true
      while genagain == true {
        var head3y = Int.random(in: 0...9)
        var head3x = Int.random(in: 0...9)
        var direction = Int.random(in: 0...1)
        if direction == CONST.VERTICAL {
          if head3y > 7 { head3y = 7 }
          if avoidShipConnection(head3y, head3x, 2, direction) == false {genagain = true} else {
            FD[head3y][head3x] = "#"
            FD[head3y+1][head3x] = "#"
            FD[head3y+2][head3x] = "#"
            ships.append(Ship(field: mode, decks: 3, coordy: head3y, coordx: head3x, direction: direction))
            genagain = false
          }
        } else if direction == CONST.HORISONTAL {
          if head3x > 7 { head3x = 7 }
          if avoidShipConnection(head3y, head3x, 2, direction) == false {genagain = true} else {
            FD[head3y][head3x] = "#"
            FD[head3y][head3x+1] = "#"
            FD[head3y][head3x+2] = "#"
            ships.append(Ship(field: mode, decks: 3, coordy: head3y, coordx: head3x, direction: direction))
            genagain = false
          }
        }
      }
    }
    // двухпалубные корабли:
    for _ in 1...3 {
      var genagain = true
      while genagain == true {
        var head2y = Int.random(in: 0...9)
        var head2x = Int.random(in: 0...9)
        var direction = Int.random(in: 0...1)
        if direction == CONST.VERTICAL {
          if head2y > 8 { head2y = 8 }
          if avoidShipConnection(head2y, head2x, 1, direction) == false {genagain = true} else {
            FD[head2y][head2x] = "#"
            FD[head2y+1][head2x] = "#"
            ships.append(Ship(field: mode, decks: 2, coordy: head2y, coordx: head2x, direction: direction))
            genagain = false
          }
        } else if direction == CONST.HORISONTAL {
          if head2x > 8 { head2x = 8 }
          if avoidShipConnection(head2y, head2x, 1, direction) == false {genagain = true} else {
            FD[head2y][head2x] = "#"
            FD[head2y][head2x+1] = "#"
            ships.append(Ship(field: mode, decks: 2, coordy: head2y, coordx: head2x, direction: direction))
            genagain = false
          }
        }
      }
    }
    // однопалубные корабли:
    for _ in 1...4 {
      var genagain = true
      while genagain == true {
        var head1y = Int.random(in: 0...9)
        var head1x = Int.random(in: 0...9)
        if avoidShipConnection(head1y, head1x, 0, CONST.VERTICAL) == false {genagain = true} else {
          FD[head1y][head1x] = "#"
          ships.append(Ship(field: mode, decks: 1, coordy: head1y, coordx: head1x, direction: direction))
          genagain = false
        }
      }

    }
  }

  // Этот метод проверяет наличие кораблей по соедству при создании кораблей:
  func avoidShipConnection (_ posy: Int, _ posx: Int, _ count: Int, _ direct: Int) -> Bool  {
    if direct == CONST.VERTICAL {for n in 0...count {
      if FD[posy+n][posx] == "#" || checkAround(posy+n,posx) == "#" {return false}}}
    if direct == CONST.HORISONTAL {for n in 0...count {
      if FD[posy][posx+n] == "#" || checkAround(posy,posx+n) == "#" {return false}}}
    return true
  }

  // Этот метод проверяет наличие заполненных клеток по соседству при создании кораблей:
  func checkAround (_ posy: Int, _ posx: Int) -> String  {
    var curposy: Int
    var curposx: Int
    for curaddy in -1...1{
      curposy = posy + curaddy
      for curaddx in -1...1{
        curposx = posx + curaddx
        if curposy > 9 {curposy = 9}
        if curposx > 9 {curposx = 9}
        if curposy < 0 {curposy = 0}
        if curposx < 0 {curposx = 0}
        if FD[curposy][curposx] == "#" {return "#"}
      }
    }
    return " "
  }

  // Выстрел:
  func hit(_ y: Int, _ x: Int) -> Bool {
    if FD[y][x] == "#"{
      FD[y][x] = "@"
      return true
    } else {
      FD[y][x] = "*"
      return false
    }
  }

  // Печатать поле:
  func writeField(_ posy:Int, _ posx:Int){
    var FRtoWrite = ""
    var counter = 0
    if self.mode == CONST.PLAYER {writeAt(posy-1, posx, " "+self.name.green+":")}
    if self.mode == CONST.COMPUTER {writeAt(posy-1, posx, " "+self.name.red+":")}
    writeAt(posy, posx, "   a b c d e f g h i j")
    for _ in FD {
      for var eachFD in FD[counter] {
        if self.mode == CONST.COMPUTER && eachFD == "#" {eachFD = " "} // закомментируйте это чтобы посмотреть поле компьютера
        FRtoWrite += eachFD+" "
      }
      counter += 1
      if counter == 10 {
        writeAt(posy+counter, posx, "\(counter) "+FRtoWrite)
      } else {
        writeAt(posy+counter, posx, " \(counter) "+FRtoWrite)
      }
      FRtoWrite = ""
    }
  }

}
