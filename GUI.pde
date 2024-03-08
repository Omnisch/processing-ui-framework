//
////////////////
// GUI fields //
////////////////
import controlP5.*;

GUI gui;
int guiColumnWidth = 240;


///////////////////
// GUI variables //
///////////////////
int originalAlpha;
int gridScale;
boolean drawStroke;
boolean drawGizmos;
boolean darkMode;



////////////////////////
// packaged GUI class //
////////////////////////
class GUI
{
  ControlP5 cp;
  
  GUI(processing.core.PApplet theParent)
  {
    this.cp = new ControlP5(theParent);
  }
  
  GUI init()
  {
    // clear canvas
    arrangeControllers(
      cp.addButton("clearSketch")
        .setSize(180, 20)
      ,false).getCaptionLabel().setText("clear  canvas").setColor(0xff);
    
    // blur canvas once
    arrangeControllers(
      cp.addButton("doBlur")
        .setSize(180, 20)
      ,false).getCaptionLabel().setText("blur").setColor(0xff);
    
    // save frame
    arrangeControllers(
      cp.addButton("saveSketch")
        .setSize(180, 20)
      ,false).getCaptionLabel().setText("save  paint").setColor(0xff);
    
    // alpha value of original image
    arrangeControllers(
      cp.addSlider("originalAlpha")
        .setSize(180, 20)
        .setRange(0, 255)
        .setValue(63)
      ,true).getCaptionLabel().setText("image  alpha");
    
    // grid scale
    arrangeControllers(
      cp.addSlider("gridScale")
        .setSize(180, 20)
        .setRange(0, 20)
        .setValue(0)
      ,true).getCaptionLabel().setText("grid  scale");
    
    // draw gizmos
    arrangeControllers(
      cp.addToggle("drawGizmos")
        .setSize(60, 20)
        .setValue(false)
      ,true).getCaptionLabel().setText("draw  gizmos");
    
    // draw strokes
    arrangeControllers(
      cp.addToggle("drawStroke")
        .setSize(60, 20)
        .setValue(false)
      ,true).getCaptionLabel().setText("draw  stroke");
    
    // dark mode
    arrangeControllers(
      cp.addToggle("darkMode")
        .setSize(60, 20)
        .setValue(false)
        .setMode(ControlP5.SWITCH)
      ,true).getCaptionLabel().setText("dark  mode");
    
    return this;
  }
  
  
  
  // arrangement functions
  Controller arrangeControllers(Controller ctrl, boolean align)
  {
    ctrl.setPosition(cx(), cy());
    ctrl.getCaptionLabel().setColor(0xff2255bb).getFont().setSize(20);
    ctrl.getValueLabel().getFont().setSize(16);
    if (align) ctrl.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
    return ctrl;
  }
  int controllerCount = 0;
  int cx() { return original.width + 2*bleedingX + 10; }
  int cy() { return ++controllerCount * 50 + 30; }
}


///////////////////
// GUI functions //
///////////////////
// only called in setup()
void guiSetup()
{
  gui = new GUI(this).init();
}



//////////////////
// GUI messages //
//////////////////
void controlEvent(ControlEvent event)
{
  if (gui == null) return;
  
  if (event.isFrom("clearSketch"))
    sketch = newCanvas(sketch);
  if (event.isFrom("doBlur"))
    blurCanvas(sketch);
  if (event.isFrom("saveSketch"))
    savePaint(sketch);
}
