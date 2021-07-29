import Artist from 0x01

transaction() {
  
  //let pixels: String
  //let picture: @Artist.Picture

  prepare(account: AuthAccount) {
    let printerRef = getAccount(0x01)
      .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
      .borrow()
      ?? panic("Couldn't borrow printer reference.")
    
    // Replace with your own drawings.
    let pixels = " *   * * *   *   * * *  *"
    log(pixels)
    let canvas = Artist.Canvas(
      width: printerRef.width,
      height: printerRef.height,
      pixels: pixels
    )
    
    let picture <- printerRef.print(canvas: canvas)!
    let collectionRef = getAccount(0x01)
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