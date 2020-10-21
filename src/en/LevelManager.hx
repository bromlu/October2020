package en;

import h2d.Text;

class LevelManager extends Entity {
    public var currentLevel: Int;
    public var numberOfNotesForLevel(get,never): Int; inline function get_numberOfNotesForLevel() return 1 + (currentLevel % Const.LEVEL_RESET_POINT);
    public var speedModifierForLevel(get,never): Int; inline function get_speedModifierForLevel() return (1 + Std.int(M.floor(currentLevel / Const.LEVEL_RESET_POINT) / 2));
    public var currentPattern: Array<Pattern>;
    public var currentNumberOfLives: Int;
    
    private var levelValue: Text;
    private var livesValue: Text;
    private var lastSongSwitch: Float = -1;

    public function new(x, y) {
        super(x, y);

        currentNumberOfLives = 3;

        var levelDescription = new h2d.Text(Assets.fontPixel);
        levelValue = new h2d.Text(Assets.fontPixel);
        levelDescription.text = "Level: ";
        levelDescription.scale(Const.HUD_SCALE);
        levelValue.text = Std.string(0);
        levelValue.scale(Const.HUD_SCALE);
        levelValue.x = Const.HUD_SCALE * 32 + 4;

        var livesDescription = new h2d.Text(Assets.fontPixel);
        livesValue = new h2d.Text(Assets.fontPixel);
        livesDescription.text = "Lives: ";
        livesDescription.scale(Const.HUD_SCALE);
        livesDescription.y += 50;
        livesValue.text = Std.string(currentNumberOfLives);
        livesValue.scale(Const.HUD_SCALE);
        livesValue.x = Const.HUD_SCALE * 32 + 4;
        livesValue.y += 50;

        spr.addChild(levelDescription);
        spr.addChild(levelValue);
        spr.addChild(livesDescription);
        spr.addChild(livesValue);
        spr.set("Nothing");

        currentLevel = -2;
        nextLevel();
    }

    public function nextLevel() {
        currentLevel++;
        currentPattern = Patterns.GeneratePattern(numberOfNotesForLevel, speedModifierForLevel);

        if (currentLevel >= 0) {
            levelValue.text = Std.string(currentLevel + 1);
            
            if (currentLevel % Const.LEVEL_RESET_POINT == 0) {

                if (Assets.Baseline1.lastPlay == lastSongSwitch) {
                    Assets.Baseline1.stop();
                    Assets.Baseline2.play(true);
                    lastSongSwitch = Assets.Baseline2.lastPlay;
                } else {
                    Assets.Baseline2.stop();
                    Assets.Baseline1.play(true);
                    lastSongSwitch = Assets.Baseline1.lastPlay;
                }
            }
        }

    }

    public function gainALife() {
        currentNumberOfLives++;
        livesValue.text = Std.string(currentNumberOfLives);
    }

    public function loseALife() {
        currentNumberOfLives--;
        livesValue.text = Std.string(currentNumberOfLives);
    }
}