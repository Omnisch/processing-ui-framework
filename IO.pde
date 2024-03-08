//
///////////////
// IO fields //
///////////////
String originalPath = "data/original";
PImage original;
PGraphics output;
int saveCount = 0;



/////////////////
// IO funtions //
/////////////////
boolean tryLoadImage()
{
  String[] extensions = { ".jpg", ".png", ".gif", };
  for (int i = 0; i < extensions.length; i++)
  {
    original = loadImage(originalPath + extensions[i]);
    if (original != null)
    {
      resizeImage(original);
      return true;
    }
  }
  return false;
}
// resize the image so that
// it won't be out of the screen
PImage resizeImage(PImage source)
{
  // deal with too-small original image
  bleedingX += max((600-original.width)/2, 0);
  bleedingY += max((720-original.height)/2, 0);
  // deal with too-large original image
  float xRatio = (displayWidth-2*bleedingX-guiColumnWidth) / (float)source.width;
  float yRatio = (displayHeight-2*bleedingY-40) / (float)source.height;
  float ratio = min(xRatio, yRatio);
  if (ratio < 1 && ratio > 0)
  {
    source.resize(floor(source.width*ratio), floor(source.height*ratio));
  }
  return source;
}
void savePaint(PGraphics artwork)
{
  output.clear();
  drawBackground(output);
  drawImage(output, original);
  // drawCanvas() has an unclear bug
  // it cannot update after first save
  // so use codes in brackets instead
  //drawCanvas(output, splashed);
  {
    output.beginDraw();
    output.image(artwork.copy(), 0, 0);
    output.endDraw();
  }
  if (drawGizmos)
  {
    gizmos.clear();
    drawAssistGrid(gizmos);
    drawCanvas(output, gizmos);
  }
  output.save("save-" + saveCount++ + ".tif");
}
