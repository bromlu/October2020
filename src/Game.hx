import en.Enums.KeyToBind;
import hxd.Timer;
import en.Pattern;
import en.Patterns;
import h3d.Vector;
import en.Note;
import dn.Process;
import hxd.Key;

class Game extends Process {
	public static var ME : Game;

	public var ca : dn.heaps.Controller.ControllerAccess;
	public var fx : Fx;
	public var camera : Camera;
	public var scroller : h2d.Layers;
	public var level : Level;
	public var hud : ui.Hud;

	public var allowInput : Bool;

	public function new() {
		super(Main.ME);
		ME = this;
		ca = Main.ME.controller.createAccess("game");
		ca.setLeftDeadZone(0.2);
		ca.setRightDeadZone(0.2);
		createRootInLayers(Main.ME.root, Const.DP_BG);

		scroller = new h2d.Layers();
		root.add(scroller, Const.DP_BG);
		scroller.filter = new h2d.filter.ColorMatrix(); // force rendering for pixel perfect

		camera = new Camera();
		level = new Level();
		fx = new Fx();
		hud = new ui.Hud();

		new Note(12,20, KeyToBind.Q);
		new Note(16,20, KeyToBind.W);
		new Note(20,20, KeyToBind.E);
		new Note(12,24, KeyToBind.A);
		new Note(16,24, KeyToBind.S);
		new Note(20,24, KeyToBind.D);

		Process.resizeAll();
		trace(Lang.t._("Game is ready."));
	}

	public function onCdbReload() {
	}

	override function onResize() {
		super.onResize();
		scroller.setScale(Const.SCALE);
	}


	function gc() {
		if( Entity.GC==null || Entity.GC.length==0 )
			return;

		for(e in Entity.GC)
			e.dispose();
		Entity.GC = [];
	}

	override function onDispose() {
		super.onDispose();

		fx.destroy();
		for(e in Entity.ALL)
			e.destroy();
		gc();
	}

	override function preUpdate() {
		super.preUpdate();

		for(e in Entity.ALL) if( !e.destroyed ) e.preUpdate();
	}

	override function postUpdate() {
		super.postUpdate();

		for(e in Entity.ALL) if( !e.destroyed ) e.postUpdate();
		gc();
	}

	override function fixedUpdate() {
		super.fixedUpdate();

		for(e in Entity.ALL) if( !e.destroyed ) e.fixedUpdate();
	}

	var isPatternPlaying = false;
	var currentLevel = 1;
	var currentNote = 0;
	var currentNotePlayStart = 0.0;
	var currentPattern: Array<Pattern>;

	override function update() {
		super.update();

		for(e in Entity.ALL) if( !e.destroyed ) e.update();

		if (isPatternPlaying == true) {
			if (framesToSec(ftime) - currentNotePlayStart >= currentPattern[currentNote].noteLength) {
				currentPattern[currentNote].note.setButtonUp();
				currentNote++;
				if (currentNote >= currentPattern.length) {
					isPatternPlaying = false;
					currentLevel++;
					currentNote = 0;
				}
			} else {
				currentPattern[currentNote].note.setButtonDown();
			}			
		} else {
			currentPattern = Patterns.GeneratePattern(1 + currentLevel % 10, 1 + M.round(currentLevel/10));
			trace(currentLevel);
			trace(1 + currentLevel % 10);
			trace(1 + M.round(currentLevel/10));
			currentNotePlayStart = framesToSec(ftime);
			isPatternPlaying = true;
		}

		if( !ui.Console.ME.isActive() && !ui.Modal.hasAny() ) {
			#if hl
			// Exit
			if( ca.isKeyboardPressed(Key.ESCAPE) )
				if( !cd.hasSetS("exitWarn",3) )
					trace(Lang.t._("Press ESCAPE again to exit."));
				else
					hxd.System.exit();
			#end

			// Restart
			if( ca.selectPressed() )
				Main.ME.startGame();
		}
	}
}

