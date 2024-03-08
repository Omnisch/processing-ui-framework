//
///////////////////
// canvas fields //
///////////////////
int bleedingX = 50;
int bleedingY = 50;
PGraphics sketch;
PGraphics gizmos;



//////////////////////
// canvas functions //
//////////////////////
// only called in settings()
void canvasSettings()
{
  if (!tryLoadImage()) { exit(); return; }
  size(original.width+2*bleedingX+guiColumnWidth, original.height+2*bleedingY);
}
// only called in setup()
void canvasSetup()
{
  ellipseMode(RADIUS);
  stroke(0xff363532);
  strokeWeight(2);
  int canvasWidth = original.width+2*bleedingX;
  int canvasHeight = original.height+2*bleedingY;
  sketch = newCanvas(canvasWidth, canvasHeight);
  gizmos = newCanvas(canvasWidth, canvasHeight);
  output = newCanvas(canvasWidth, canvasHeight);
}



PGraphics newCanvas(int canvasWidth, int canvasHeight)
{
  PGraphics canvas;
  canvas = createGraphics(canvasWidth, canvasHeight);
  canvas.beginDraw();
  canvas.ellipseMode(RADIUS);
  canvas.stroke(0xff363532);
  canvas.strokeWeight(2);
  canvas.endDraw();
  return canvas;
}
PGraphics newCanvas(PGraphics canvas)
{
  return newCanvas(canvas.width, canvas.height);
}
void blurCanvas(PGraphics canvas)
{
  PImage blurred = createImage(canvas.width, canvas.height, ARGB);
  blurred.loadPixels();
  for (int y = 1; y < canvas.height-1; y++)
    for (int x = 1; x < canvas.width-1; x++)
      for (int i = 0; i < 32; i += 8)
      {
        blurred.pixels[y*blurred.width + x] |= (int)(
          1/16.0 * (canvas.get(x-1, y-1) >> i & 0xff) +
          2/16.0 * (canvas.get(x-1, y+0) >> i & 0xff) +
          1/16.0 * (canvas.get(x-1, y+1) >> i & 0xff) +
          2/16.0 * (canvas.get(x+0, y-1) >> i & 0xff) +
          4/16.0 * (canvas.get(x+0, y+0) >> i & 0xff) +
          2/16.0 * (canvas.get(x+0, y+1) >> i & 0xff) +
          1/16.0 * (canvas.get(x+1, y-1) >> i & 0xff) +
          2/16.0 * (canvas.get(x+1, y+0) >> i & 0xff) +
          1/16.0 * (canvas.get(x+1, y+1) >> i & 0xff)) << i;
      }
  blurred.updatePixels();
  canvas.beginDraw();
  canvas.clear();
  canvas.image(blurred, 0, 0);
  canvas.endDraw();
}



void drawCanvas(PGraphics canvas, PGraphics toDraw)
{
  if (canvas != g) canvas.beginDraw();
  canvas.image(toDraw, 0, 0);
  if (canvas != g) canvas.endDraw();
}
void drawImage(PGraphics canvas, PImage img)
{
  if (canvas != g) canvas.beginDraw();
  canvas.tint(0xff, originalAlpha);
  canvas.image(img, bleedingX, bleedingY);
  canvas.tint(0xff);
  if (canvas != g) canvas.endDraw();
}
void drawBackground(PGraphics canvas)
{
  if (canvas != g) canvas.beginDraw();
  canvas.background(darkMode ? 0xff1d1d1f : 0xfff5f5f7);
  if (canvas != g) canvas.endDraw();
}
// gizmos
void redrawGizmos(PGraphics canvas)
{
  canvas.clear();
  if (gridScale > 0) drawAssistGrid(canvas);
  drawCursor(canvas);
}
void drawCursor(PGraphics canvas)
{
  if (canvas != g) canvas.beginDraw();
  canvas.noFill();
  canvas.stroke(0xffa0a0a0);
  canvas.strokeWeight(2);
  canvas.ellipse(mouseX, mouseY, 20, 20);
  if (canvas != g) canvas.endDraw();
}
void drawAssistGrid(PGraphics canvas)
{
  if (canvas != g) canvas.beginDraw();
  canvas.stroke(0xffa0a0a0);
  canvas.strokeWeight(1);
  int maxX = bleedingX+original.width;
  int maxY = bleedingY+original.height;
  for (int x = bleedingX; x <= maxX; x += 8*gridScale)
  {
    canvas.line(x, bleedingY, x, maxY);
    for (int y = bleedingY; y <= maxY; y += 8*gridScale)
      canvas.line(bleedingX, y, maxX, y);
  }
  if (canvas != g) canvas.endDraw();
}
