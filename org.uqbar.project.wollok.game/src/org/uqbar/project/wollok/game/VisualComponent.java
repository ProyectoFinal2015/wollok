package org.uqbar.project.wollok.game;

import org.uqbar.project.wollok.game.Position;
import org.uqbar.project.wollok.interpreter.core.WollokObject;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.Texture.TextureFilter;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;

public class VisualComponent {

	private Position position;
	private String image;
	private WollokObject domainObject;
	private Texture texture;
	private String attribute;
	
	public VisualComponent(WollokObject object) {
		this.domainObject = object;
		this.image = String.class.cast(this.domainObject.call("getImagen"));
		this.position = new WPosition(object);
	}
	
	public VisualComponent(WollokObject object, String attr) {
		this(object);
		this.attribute = attr;
	}
	
	public Position getMyPosition() {
		return position;
	}
	public Object getMyDomainObject() {
		return domainObject;
	}
	public void setMyDomainObject(WollokObject myDomainObject) {
		this.domainObject = myDomainObject;
	}
	
	public Texture getTexture() {
		if(this.texture == null)
			this.texture = new Texture(Gdx.files.internal(image));
			this.texture.setFilter(TextureFilter.Linear, TextureFilter.Linear);
		return this.texture;
	}
	
	public Object sendMessage(String message) {
		return this.domainObject.call(message);
	}

	public void draw(SpriteBatch batch, BitmapFont font) {
		batch.draw(this.getTexture(), this.getMyPosition().getXinPixels(), this.getMyPosition().getYinPixels());

		if (this.attribute != null)
			font.draw(batch, this.getShowableAttribute(), this.getMyPosition().getXinPixels(), this.getMyPosition().getYinPixels());
	}

	private String getShowableAttribute() {
		String objectProperty = this.sendMessage(this.attribute).toString();
		return this.attribute + ":" + objectProperty;
	}
}
