import Artist from "./contract.cdc"

pub fun display(canvas: Artist.Canvas) {
  var rowId = 0
  log("Length: ".concat(canvas.height.toString()))
  while rowId < Int(canvas.height) {
    log(canvas.pixels.slice(from: Int(canvas.height)*rowId, upTo: Int(canvas.height)*rowId + Int(canvas.height)))
    rowId = rowId + 1
  }

}

pub fun printCollection(address: Address): [String]? {
      var pictures: [String] = []
      let account = getAccount(address)

      let capability = account.getCapability<&Artist.Collection>(/public/ArtistPictureCollection)

      if !capability.check() {
        log("Account: ".concat(address.toString()).concat(" has no collection!"))
	return nil
      } else {
        let receiverRef = capability.borrow()
                ?? panic("Could not borrow collection reference")
        let picsNum = receiverRef.pictures.length
        log(picsNum)
        var picId = 0
        while picId < picsNum {
          let pic = receiverRef.pictures[picId].canvas.pixels
          //log(pic)
	  pictures.append(pic)
          display(canvas: receiverRef.pictures[picId].canvas)
          picId = picId + 1    
        }
	return pictures
      }
      
}

pub fun main(address: Address): [String]? {
    let pictures = printCollection(address: address)
    return pictures
}
