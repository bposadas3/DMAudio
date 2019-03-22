//helper functions
AudioContext ac; //needed here because getSamplePlayer() uses it below
float basePitch = 1;

Sample getSample(String fileName) {
 return SampleManager.sample(dataPath(fileName)); 
}

SamplePlayer getSamplePlayer(String fileName, Boolean killOnEnd) {
  SamplePlayer player = null;
  try {
    player = new SamplePlayer(ac, getSample(fileName));
    player.setKillOnEnd(killOnEnd);
    player.setName(fileName);
    player.setPitch(s_pitchValue);
    s_reverb.addInput(player);
    s_gain.addInput(player);
  }
  catch(Exception e) {
    println("Exception while attempting to load sample: " + fileName);
    e.printStackTrace();
    exit();
  }
  
  return player;
}

SamplePlayer getSamplePlayer(String fileName) {
  return getSamplePlayer(fileName, false);
}

void Play(SamplePlayer sp) {
  Random rand = new Random();
  //Plays a random pitched value from 1 +- 0.1
  s_pitchValue.setValue(basePitch + (rand.nextFloat() - 0.5f)*2*0.1);
  sp.setToLoopStart();
  sp.start();
}
