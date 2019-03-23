import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;
import java.util.Random;
//AudioContext ac; is declared in helper_functions

ControlP5 cp5;
CheckBox checkbox;
RadioButton pitchRadioButton;

SamplePlayer soundEffect;
//************************************************************************
//************************************************************************
//************************************************************************

//DECLARE ALL SOUND EFFECTS HERE
SamplePlayer metal;
SamplePlayer wood;
SamplePlayer rock;
SamplePlayer woodHollow;
SamplePlayer slash;
SamplePlayer bludgeon;
SamplePlayer shwing;
SamplePlayer whiff;
SamplePlayer plants;
SamplePlayer water;
SamplePlayer plop;
SamplePlayer bell;
SamplePlayer acid;
SamplePlayer cold;
SamplePlayer freeze;
SamplePlayer firebolt;
SamplePlayer fireball;
SamplePlayer force;
SamplePlayer magicMissile;
SamplePlayer electricity;
SamplePlayer necrotic;
SamplePlayer poison;
SamplePlayer psychic;
SamplePlayer radiant;
SamplePlayer holy;
SamplePlayer thunder;
SamplePlayer healing;
SamplePlayer cast;
SamplePlayer conjure;
SamplePlayer abjure;

//************************************************************************
//******************************************************************************************************************************** Declare Sound Effects
//************************************************************************


//Declare Master Gain
Gain masterGain;

//Declare Glides
Glide masterGainValue;

Glide a_gainValue;

Glide s_pitchValue;
Glide s_reverbValue;
Glide s_gainValue;
Glide s_filterFreq;

//Declare Ambient Effect UGens
BiquadFilter a_filter;
Reverb a_reverb;
Gain a_gain;

//Declare Sound Effect UGens
BiquadFilter s_filter;
Reverb s_reverb;
Gain s_gain;

//Declare other globals variables
float gainSlideValue = 1.0;
float magicPosX = 150;
float magicPosY = 350;

float colPosX = 150;
float colPosY = 10;

float itemPosX = 400;
float itemPosY = 10;

float monPosX = 400;
float monPosY = 350;

float doorsPosX = 650;
float doorsPosY = 10;

float destPosX = 650;
float destPosY = 350;

//end global variables

//runs once when the Play button above is pressed

void setup() {
  size(1000, 800); //size(width, height) must be the first line in setup()
  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions 
  noStroke();
  cp5 = new ControlP5(this);

  
  //Master Gain
  masterGain = new Gain(ac, 1, masterGainValue);
  
  //Set up Glides
  masterGainValue = new Glide(ac, 1, 0);
  
  s_pitchValue = new Glide(ac, 1, 0);
  s_gainValue = new Glide(ac, 0, 0);
  s_filterFreq = new Glide(ac, 100000f, 0);
  
  a_gainValue = new Glide(ac, 0, 0);
  
  
  //Set up Ambience Sample Players
  a_reverb = new Reverb(ac, 1);

  //Set up effect UGens
  s_reverb = new Reverb(ac, 1);
  s_reverb.setSize(0);
  s_reverb.setDamping(0.6);
  ac.start();
  s_filter = new BiquadFilter(ac, BiquadFilter.LP, s_filterFreq, 0.5f);
  s_gain = new Gain (ac, 1, s_gainValue);
  
  a_gain = new Gain(ac, 1, a_gainValue);
  //*************************************************************
  //************************************************************************************************************* Set Up Sound Effects
  //*************************************************************
  //SET UP SOUND EFFECT PLAYERS HERE
  //*************************************************************
  //*************************************************************
  //*************************************************************
  
  metal = getSamplePlayer("sword.aiff");
  wood = getSamplePlayer("wood_hit.wav");
  woodHollow = getSamplePlayer("wood.wav");
  rock = getSamplePlayer("rock.wav");
  slash = getSamplePlayer("slash.wav");
  bludgeon = getSamplePlayer("bludgeon.wav");
  shwing = getSamplePlayer("shwing.wav");
  whiff = getSamplePlayer("whoosh.wav");
  plants = getSamplePlayer("plants.wav");
  water = getSamplePlayer("splash.wav");
  plop = getSamplePlayer("plop.wav");
  bell = getSamplePlayer("bell.wav");
  acid = getSamplePlayer("acid.aiff");
  cold = getSamplePlayer("howling_wind.wav");
  freeze = getSamplePlayer("freeze.wav");
  firebolt = getSamplePlayer("firebolt.wav");
  fireball = getSamplePlayer("fireball.wav");
  force = getSamplePlayer("force.wav");
  magicMissile = getSamplePlayer("magic_missiles.wav");
  electricity = getSamplePlayer("electricity.wav");
  necrotic = getSamplePlayer("necrotic.wav");
  poison = getSamplePlayer("poison.wav");
  psychic = getSamplePlayer("psychic.wav");
  radiant = getSamplePlayer("radiant.wav");
  holy = getSamplePlayer("holy.wav");
  thunder = getSamplePlayer("thunder.wav");
  healing = getSamplePlayer("healing.wav");
  cast = getSamplePlayer("cast.wav");
  conjure = getSamplePlayer("conjure.mp3");
  abjure = getSamplePlayer("abjure.wav");
  
  //**************************************************************
  
  //Set up UGen input flow
  
  //Set up Sound input
  s_gain.addInput(s_reverb);
  s_filter.addInput(s_gain);
  
  masterGain.addInput(s_filter);
  ac.out.addInput(masterGain);
  
  
  //*******************************************************************************************************************  AMBIENCE UI
  cp5.addTextlabel("AmbienceLabel")
      .setText("Ambience")
      .setPosition(10,300)
      .setColorValue(0xffffff00)
      .setFont(createFont("Georgia",20))
      ;
  checkbox = cp5.addCheckBox("ambientCheckbox")
      .setPosition(10, 340)
      .setColorForeground(color(120))
      .setColorActive(color(255))
      .setColorLabel(color(255))
      .setSize(40, 40)
      .setItemsPerRow(1)
      .setSpacingColumn(30)
      .setSpacingRow(20)
      .addItem("Echo", 0)
      .addItem("Muffle", 1);
      ;
      
//************ COLLISIONS UI ******************************************************************************************* COLLISIONS UI
  cp5.addTextlabel("CollisionLabel")
      .setText("Collisions")
      .setPosition(colPosX,colPosY)
      .setColorValue(0xffffff00)
      .setFont(createFont("Georgia",20))
      ;
  cp5.addSlider("Volume")
     .setPosition(10,10)
     .setSize(20,100)
     .setRange(0,100)
     .setValue(100)
     ;
  
  cp5.addButton("Metal")
     .setValue(0)
     .setPosition(colPosX, colPosY + 40)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Slide")
     .setValue(0)
     .setPosition(colPosX + 60, colPosY + 40)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Bell")
     .setValue(0)
     .setPosition(colPosX + 120, colPosY + 40)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;   
  cp5.addButton("Wood")
     .setValue(0)
     .setPosition(colPosX, colPosY + 70)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Hollow")
     .setValue(0)
     .setPosition(colPosX + 60, colPosY + 70)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;   
  cp5.addButton("Rock")
     .setValue(0)
     .setPosition(colPosX, colPosY + 100)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Slash")
     .setValue(0)
     .setPosition(colPosX, colPosY + 130)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Bludgeon")
     .setValue(0)
     .setPosition(colPosX, colPosY + 160)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
   cp5.addButton("Whiff")
     .setValue(0)
     .setPosition(colPosX, colPosY + 190)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Plants")
     .setValue(0)
     .setPosition(colPosX, colPosY + 220)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Water")
     .setValue(0)
     .setPosition(colPosX, colPosY + 250)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Plop")
     .setValue(0)
     .setPosition(colPosX + 60, colPosY + 250)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;     
     
//******************* MAGIC UI *******************************************************************************   MAGIC UI
  cp5.addTextlabel("MagicLabel")
      .setText("Magic")
      .setPosition(magicPosX,magicPosY)
      .setColorValue(0xffffff00)
      .setFont(createFont("Georgia",20))
      ;
  cp5.addButton("Cast")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 40)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
    cp5.addButton("Conjure")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 70)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Healing")
     .setValue(0)
     .setPosition(magicPosX + 60, magicPosY + 40)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Abjure")
     .setValue(0)
     .setPosition(magicPosX + 60, magicPosY + 70)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Acid")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 110)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Cold")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 140)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;     
  cp5.addButton("Freeze")
     .setValue(0)
     .setPosition(magicPosX + 60, magicPosY + 140)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Firebolt")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 170)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Fireball")
     .setValue(0)
     .setPosition(magicPosX + 60, magicPosY + 170)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;     
  cp5.addButton("Force")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 200)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("MagicMissiles")
     .setValue(0)
     .setPosition(magicPosX + 60, magicPosY + 200)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Lightning")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 230)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Necrotic")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 260)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Poison")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 290)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Psychic")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 320)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Radiant")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 350)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Holy")
     .setValue(0)
     .setPosition(magicPosX + 60, magicPosY + 350)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
  cp5.addButton("Thunder")
     .setValue(0)
     .setPosition(magicPosX, magicPosY + 380)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
//********************Items UI******************************************************************************** ITEMS UI

  cp5.addTextlabel("ItemsLabel")
      .setText("Items")
      .setPosition(itemPosX, itemPosY)
      .setColorValue(0xffffff00)
      .setFont(createFont("Georgia",20))
      ;
//********************Monsters UI***************************************************************************** MONSTERS UI
  cp5.addTextlabel("MonstersLabel")
      .setText("Monsters")
      .setPosition(monPosX, monPosY)
      .setColorValue(0xffffff00)
      .setFont(createFont("Georgia",20))
      ;
//********************Doors UI******************************************************************************** DOORS UI
  cp5.addTextlabel("DoorsLabel")
      .setText("Doors")
      .setPosition(doorsPosX, doorsPosY)
      .setColorValue(0xffffff00)
      .setFont(createFont("Georgia",20))
      ;
//********************Destruction UI************************************************************************** DESTRUCTION UI
  cp5.addTextlabel("DestructionLabel")
      .setText("Destruction")
      .setPosition(destPosX, destPosY)
      .setColorValue(0xffffff00)
      .setFont(createFont("Georgia",20))
      ;
//******************* Effects UI ***************************************************************************** EFFECTS UI
  cp5.addButton("Stop")
     .setValue(0)
     .setPosition(10,150)
     .setSize(40,20)
     .activateBy(ControlP5.PRESS)
     ;
   pitchRadioButton = cp5.addRadioButton("Pitch")
     .setPosition(50,50)
     .setSize(40,20)
     .setColorForeground(color(120))
     .setColorActive(color(255))
     .setColorLabel(color(255))
     .setItemsPerRow(1)
     .setSpacingColumn(50)
     .addItem("High (3)",1)
     .addItem("Normal (2)",2)
     .addItem("Low (1)",3)
     .activate(1)
     ;
     
}

void draw() {
  background(0);  //fills the canvas with black (0) each frame
  
  if (checkbox.getState(0)) {
    s_reverb.setSize(0.5f);
  } else {
    s_reverb.setSize(0.0f);
  }
  
  //If "Muffle" is checked"
  if (checkbox.getState(1)) {
    s_filterFreq.setValue(500f);
  } else {
    s_filterFreq.setValue(100000f);
  }
  
  if (pitchRadioButton.getState(0)) {basePitch = 1.9f;}
  if (pitchRadioButton.getState(1)) {basePitch = 1f;}
  if (pitchRadioButton.getState(2)) {basePitch = 0.4f;}
  
}


void keyPressed() {
  if (key == '1') {
    pitchRadioButton.activate(2);
  }
  
  if (key == '2') {
    pitchRadioButton.activate(1);
  }
  
  if (key == '3') {
    pitchRadioButton.activate(0);
  }
  
  if (key == 'e') {
    if (!checkbox.getState(0)) {
      checkbox.activate(0);
    } else {
      checkbox.deactivate(0);
    }
  }
  
  if (key == 'm') {
    if (!checkbox.getState(1)) {
      checkbox.activate(1);
    } else {
      checkbox.deactivate(1);
    }
  }
  
}

//*************************************************************************************************************************** BUTTON HANDLERS

public void Volume(int theValue) {
  s_gainValue.setValue(theValue/100f);
}

public void controlEvent(ControlEvent theEvent) {
}

public void Metal(int theValue) {
  Play(metal);
}

public void Slide(int theValue) {
  
  Play(shwing);
}

public void Bell(int theValue) {
  BellPlay(bell);
}

public void Wood(int theValue) {
  Play(wood);

}

public void Hollow(int theValue) {
  
  Play(woodHollow);
}

public void Rock(int theValue) {
  
  Play(rock);

}

public void Slash(int theValue) {
  
  Play(slash);
}

public void Bludgeon(int theValue) {
  
  Play(bludgeon);
}

public void Whiff(int theValue) {
  
  Play(whiff);
}

public void Plants(int theValue) {
  
  Play(plants);
}

public void Water(int theValue) {
  Play(water);
}

public void Plop(int theValue) {
  Play(plop);
}

public void Acid(int theValue) {
  Play(acid);
}

public void Cold(int theValue) {
  Play(cold);
}

public void Freeze(int theValue) {
  Play(freeze);
}

public void Firebolt(int theValue) {
  Play(firebolt);
}

public void Fireball(int theValue) {
  Play(fireball);
}

public void Force(int theValue) {
  Play(force);
}

public void MagicMissiles(int theValue) {
  Play(magicMissile);
}

public void Lightning(int theValue) {
  Play(electricity);
}

public void Necrotic(int theValue) {
  Play(necrotic);
}

public void Poison(int theValue) {
  Play(poison);
}

public void Psychic(int theValue) {
  Play(psychic);
}

public void Radiant(int theValue) {
  Play(radiant);
}

public void Holy(int theValue) {
  BellPlay(holy);
}

public void Thunder(int theValue) {
  Play(thunder);
}

public void Healing(int theValue) {
  Play(healing);
}

public void Cast(int theValue) {
  Play(cast);
}

public void Conjure(int theValue) {
  Play(conjure);  
}

public void Abjure(int theValue) {
  Play(abjure);
}

//Declare this method last. Stops all ambience/sound effects
public void Stop(int theValue) {
  //s_gainValue.setValue(0);
}
