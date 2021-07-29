// https://play.onflow.org/b4730b92-2fe3-42ea-ad7f-019f2cd9b65c?type=script&id=43f291b3-4558-48ed-8c8a-f92b9ca90374

import Artist from 0x01

pub fun display(canvas: Artist.Canvas) {
  var rowId = 0
  log("Length: ".concat(canvas.height.toString()))
  while rowId < Int(canvas.height) {
    log(canvas.pixels.slice(from: Int(canvas.height)*rowId, upTo: Int(canvas.height)*rowId + Int(canvas.height)))
    rowId = rowId + 1
  }

}

pub fun printCollection(address: Address) {

      let account = getAccount(address)

      let capability = account.getCapability<&Artist.Collection>(/public/ArtistPictureCollection)

      if !capability.check() {
        log("Account: ".concat(address.toString()).concat(" has no collection!"))
      } else {
        let receiverRef = capability.borrow()
                ?? panic("Could not borrow collection reference")
        let picsNum = receiverRef.pictures.length
        log(picsNum)
        var picId = 0
        while picId < picsNum {
          let pic = receiverRef.pictures[picId].canvas.pixels
          //log(pic)
          display(canvas: receiverRef.pictures[picId].canvas)
          picId = picId + 1    
        }
      }
      
}

pub fun main() {
    printCollection(address: 0x01)
    printCollection(address: 0x02)
    printCollection(address: 0x03)
    printCollection(address: 0x04)
    printCollection(address: 0x05)
}