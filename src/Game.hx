import en.GameOver;
import hxd.snd.Manager;
import en.Score;
import en.LevelManager;
import en.Recorder;
import en.PatternPlayer;
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
	public var recorder: Recorder;
	public var levelManager : LevelManager;
	public var gameOver: GameOver;

	private var patternPlayer : PatternPlayer;
	private var score : Score;

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

		new Note(4,20, KeyToBind.Q, Assets.QHarmonics);
		new Note(8,20, KeyToBind.W, Assets.WHarmonics);
		new Note(12,20, KeyToBind.E, Assets.EHarmonics);
		new Note(4,24, KeyToBind.A, Assets.AHarmonics);
		new Note(8,24, KeyToBind.S, Assets.SHarmonics);
		new Note(12,24, KeyToBind.D, Assets.DHarmonics);
		
		levelManager = new LevelManager(-10,0);
		score = new Score(-10,6);
		patternPlayer = new PatternPlayer();
		recorder = new Recorder();
		gameOver = null;

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

	override function update() {
		super.update();

		for(e in Entity.ALL) if( !e.destroyed ) e.update();

		if (levelManager.currentNumberOfLives > 0 && !patternPlayer.isPlaying && !recorder.isRecording && !delayer.hasId("waitingToPlay")) {
			if (levelManager.currentLevel != -1 && recorder.recordedPattern.length == 0) {
				allowInput = true;
				recorder.startRecording(levelManager.numberOfNotesForLevel);
			} else {
				score.scorePattern(levelManager.currentPattern, recorder.recordedPattern);
				levelManager.nextLevel();
				recorder.resetRecorder();
				allowInput = false;
				for (note in Note.ALL) {
					note.setButtonUp();
				}
				delayer.addS("waitingToPlay", () -> {
					patternPlayer.playPattern(levelManager.currentPattern);
				}, Const.LEVEL_DELAY_S);	
			}
		}

		if (levelManager.currentNumberOfLives <= 0 ) {
			if (gameOver == null) {
				gameOver = new GameOver(-10,10, score.currentScore);
			}
			if(ca.isKeyboardPressed(Key.R)) {
				levelManager.reset();
				score.reset();
				patternPlayer.stopPlayingPattern();
				recorder.resetRecorder();
				gameOver.destroy();
				gameOver = null;
			}
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

