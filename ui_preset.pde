void settings()
{
  canvasSettings();
}

void setup()
{
  canvasSetup();
  guiSetup();
}

void draw()
{
  drawAllTo(g);
}

void drawAllTo(PGraphics canvas)
{
  drawBackground(canvas);
  drawImage(canvas, original);
  drawCanvas(canvas, sketch);
  if (drawGizmos)
  {
    redrawGizmos(gizmos);
    drawCanvas(canvas, gizmos);
  }
}
