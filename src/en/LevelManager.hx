package en;

import h2d.Text;

class LevelManager extends Entity {
    public var currentLevel: Int;
    public var numberOfNotesForLevel(get,never): Int; inline function get_numberOfNotesForLevel() return 1 + (currentLevel % Const.LEVEL_RESET_POINT);
    public var speedModifierForLevel(get,never): Int; inline function get_speedModifierForLevel() return (1 + Std.int(M.floor(currentLevel / Const.LEVEL_RESET_POINT) / 2));
    public var currentPattern: Array<Pattern>;
    
    private var levelValue: Text;
    private var lastSongSwitch: Float = -1;

    public function new(x, y) {
        super(x, y);

        var levelDescription = new h2d.Text(Assets.fontPixel);
        levelValue = new h2d.Text(Assets.fontPixel);
        levelDescription.text = "Level: ";
        levelDescription.scale(Const.HUD_SCALE);
        levelValue.text = Std.string(0);
        levelValue.scale(Const.HUD_SCALE);
        levelValue.x = Const.HUD_SCALE * 32 + 4;
        spr.addChild(levelDescription);
        spr.addChild(levelValue);
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
}