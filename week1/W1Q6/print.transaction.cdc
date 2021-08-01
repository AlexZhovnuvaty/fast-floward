import Artist from "./contract.cdc"// 0xf8d6e0586b0a20c7

transaction(width: UInt8, height: UInt8, pixels: String) {

  prepare(account: AuthAccount) {
    let printerRef = getAccount(0xf8d6e0586b0a20c7)
      .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
      .borrow()
      ?? panic("Couldn't borrow printer reference.")
    
    //     let pixels = " *   * * *   *   * * *  *"
    log("width: ".concat(width.toString()))
    log("height: ".concat(height.toString()))
    log("pixels: ".concat(pixels))
    let canvas = Artist.Canvas(
      width: width,
      height: height,
      pixels: pixels
    )
    
    let picture <- printerRef.print(canvas: canvas)!
    let collectionRef = account
      .getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
      .borrow()
      ?? panic("Couldn't borrow collection reference.")

    collectionRef.deposit(picture: <- picture)
  }
/*
  execute {
    if (self.picture == nil) {
      log("Picture with ".concat(self.pixels).concat(" already exists!"))
    } else {
      log("Picture printed!")
    }

    destroy self.picture
  }
  */
}