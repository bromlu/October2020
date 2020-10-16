package en;

class LevelManager {
    public var currentLevel: Int;
    public var numberOfNotesForLevel(get,never): Int; inline function get_numberOfNotesForLevel() return 1 + (currentLevel % Const.LEVEL_RESET_POINT);
    public var speedModifierForLevel(get,never): Int; inline function get_speedModifierForLevel() return 1 + M.floor(currentLevel / Const.LEVEL_RESET_POINT);
    public var currentPattern: Array<Pattern>;

    public function new() {
        currentLevel = -1;
    }

    public function nextLevel() {
        currentLevel++;
        currentPattern = Patterns.GeneratePattern(numberOfNotesForLevel, speedModifierForLevel);
    }
}