package org.uqbar.project.wollok.game;

import org.uqbar.project.wollok.game.Position;
import org.uqbar.project.wollok.interpreter.core.WollokObject;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Texture;

public class VisualComponent {

	private Position position;
	private String image;
	// En realidad es un WollokObject pero lo debo tratar como object generalmente...WTF!
	private Object domainObject;
	private Texture texture;
	
	public VisualComponent() { }
	
	public VisualComponent(WollokObject object, String image, Position position) {
		this.domainObject = object;
		this.image = image;
		this.position = position;
	}
	
	public Position getMyPosition() {
		return position;
	}
	public void setMyPosition(Position myPosition) {
		this.position = myPosition;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public Object getMyDomainObject() {
		return domainObject;
	}
	public void setMyDomainObject(Object myDomainObject) {
		this.domainObject = myDomainObject;
	}
	
	public Texture getTexture(){
		if(this.texture == null)
			return this.texture = this.texture = new Texture(Gdx.files.internal(image));
		return this.texture;
	}
	
}
