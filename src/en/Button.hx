package en;

class Button extends Entity {
	var ca : dn.heaps.Controller.ControllerAccess;
	var keyToWatch: Int;
	var buttonType: ButtonType;

	public function new(x,y,buttonType: ButtonType) {
		super(x,y);

		ca = Main.ME.controller.createAccess("button");
		this.buttonType = buttonType;

		switch (buttonType) {
			case Q: this.keyToWatch = hxd.Key.Q;
			case W: this.keyToWatch = hxd.Key.W;
			case E: this.keyToWatch = hxd.Key.E;
			case A: this.keyToWatch = hxd.Key.A;
			case S: this.keyToWatch = hxd.Key.S;
			case D: this.keyToWatch = hxd.Key.D;
		}

		sprScaleX = 4;
		sprScaleY = 4;
    }
    
    override function update() {
		super.update();

		if(ca.isKeyboardDown(this.keyToWatch)) {
			setButtonDown();
		}
		if(ca.isKeyboardUp(this.keyToWatch)) {
			setButtonUp();
		}
	}

	public function setButtonUp() {
		spr.set("Button" + buttonType + "Up");
		spr.uncolorize();
	}
	
	public function setButtonDown() {
		spr.set("Button" + buttonType + "Down");
		spr.colorize(0xcccccc);
	}
}