package org.uqbar.project.wollok.game.listeners;

import com.badlogic.gdx.Input;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import org.uqbar.project.wollok.game.Position;
import org.uqbar.project.wollok.game.VisualComponent;
import org.uqbar.project.wollok.game.gameboard.Gameboard;
import org.uqbar.project.wollok.game.listeners.GameboardListener;

@SuppressWarnings("all")
public class ArrowListener implements GameboardListener {
  private HashMap<Integer, Runnable> diccionario = new HashMap<Integer, Runnable>();
  
  public ArrowListener(final Gameboard aGameboard) {
    final Runnable _function = new Runnable() {
      public void run() {
        VisualComponent _characterVisualcomponent = aGameboard.getCharacterVisualcomponent();
        Position _myPosition = _characterVisualcomponent.getMyPosition();
        _myPosition.incY(1);
      }
    };
    this.diccionario.put(Integer.valueOf(Input.Keys.UP), _function);
    final Runnable _function_1 = new Runnable() {
      public void run() {
        VisualComponent _characterVisualcomponent = aGameboard.getCharacterVisualcomponent();
        Position _myPosition = _characterVisualcomponent.getMyPosition();
        _myPosition.incY((-1));
      }
    };
    this.diccionario.put(Integer.valueOf(Input.Keys.DOWN), _function_1);
    final Runnable _function_2 = new Runnable() {
      public void run() {
        VisualComponent _characterVisualcomponent = aGameboard.getCharacterVisualcomponent();
        Position _myPosition = _characterVisualcomponent.getMyPosition();
        _myPosition.incX((-1));
      }
    };
    this.diccionario.put(Integer.valueOf(Input.Keys.LEFT), _function_2);
    final Runnable _function_3 = new Runnable() {
      public void run() {
        VisualComponent _characterVisualcomponent = aGameboard.getCharacterVisualcomponent();
        Position _myPosition = _characterVisualcomponent.getMyPosition();
        _myPosition.incX(1);
      }
    };
    this.diccionario.put(Integer.valueOf(Input.Keys.RIGHT), _function_3);
  }
  
  public void notify(final Gameboard gameboard) {
    Set<Map.Entry<Integer, Runnable>> _entrySet = this.diccionario.entrySet();
    Iterator<Map.Entry<Integer, Runnable>> it = _entrySet.iterator();
    while (it.hasNext()) {
      {
        Map.Entry<Integer, Runnable> _next = it.next();
        Map.Entry<Integer, Runnable> pair = ((Map.Entry<Integer, Runnable>) _next);
        Integer _key = pair.getKey();
        int _intValue = _key.intValue();
        boolean _isKeyPressed = gameboard.isKeyPressed(_intValue);
        if (_isKeyPressed) {
          Runnable _value = pair.getValue();
          _value.run();
        }
      }
    }
  }
}
