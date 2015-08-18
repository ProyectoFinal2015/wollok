package org.uqbar.project.wollok.game;

import com.badlogic.gdx.utils.Json;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.uqbar.project.wollok.game.GameConfiguration;
import org.uqbar.project.wollok.game.gameboard.Gameboard;

@SuppressWarnings("all")
public class GameFactory {
  private Gameboard gameboard;
  
  public void makeJson() {
    GameConfiguration config = new GameConfiguration();
    config.setGameboardHeight(5);
    config.setGameboardTitle("sokoban");
    config.setGameboardWidth(5);
    config.setImageCharacter("jugador.png");
    config.setImageGround("flying_bird.png");
    config.setArrowListener(true);
    Json json = new Json();
    String _json = json.toJson(config);
    System.out.println(_json);
  }
  
  public void loadJson() {
    try {
      Json json = new Json();
      String text = this.readFile("config.json", StandardCharsets.UTF_8);
      GameConfiguration config = json.<GameConfiguration>fromJson(GameConfiguration.class, text);
      this.gameboard.setConfiguration(config);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public void setGame(final Gameboard aGameboard) {
    this.gameboard = aGameboard;
    this.loadJson();
    GameConfiguration _configuration = aGameboard.getConfiguration();
    _configuration.build(aGameboard);
  }
  
  public String readFile(final String path, final Charset encoding) throws IOException {
    Path _get = Paths.get(path);
    byte[] encoded = Files.readAllBytes(_get);
    return new String(encoded, encoding);
  }
}
