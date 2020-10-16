package en;

class Note extends Entity {
	public static var ALL : Array<Note> = [];
	public var isUp : Bool;
	public var isDown(get,never) : Bool; inline function get_isDown() return !isUp && (game.framesToMs(game.ftime) - timePressed) > Const.BUTTON_DELAY_MS;
	public var keyToBind: KeyToBind;

	var ca : dn.heaps.Controller.ControllerAccess;
	var keyIndex: Int;
	var timePressed: Float;

	public function new(x,y, keyToBind: KeyToBind) {
		super(x,y);
		ALL.push(this);

		ca = Main.ME.controller.createAccess("button");
		this.keyToBind = keyToBind;

		switch (keyToBind) {
			case Q: this.keyIndex = hxd.Key.Q;
			case W: this.keyIndex = hxd.Key.W;
			case E: this.keyIndex = hxd.Key.E;
			case A: this.keyIndex = hxd.Key.A;
			case S: this.keyIndex = hxd.Key.S;
			case D: this.keyIndex = hxd.Key.D;
		}

		setButtonUp();

		sprScaleX = 4;
		sprScaleY = 4;
    }
    
    override function update() {
		super.update();

		if(!game.allowInput) return;

		if(ca.isKeyboardDown(this.keyIndex)) {
			setButtonDown();
		}
		if(ca.isKeyboardUp(this.keyIndex)) {
			setButtonUp();
		}
	}

	public function setButtonUp() {
		if (isUp) return;

		isUp = true;
		spr.set("Button" + keyToBind + "Up");
		spr.uncolorize();
	}
	
	public function setButtonDown() {
		if (!isUp) return;

		timePressed = game.framesToMs(game.ftime);
		isUp = false;
		spr.set("Button" + keyToBind + "Down");
		spr.colorize(0xcccccc);
	}

	override function dispose() {
		super.dispose();
		ca.dispose();
	}
}