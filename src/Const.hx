class Const {
	public static var FPS = 60;
	public static var FIXED_FPS = 30;
	public static var AUTO_SCALE_TARGET_WID = -1; // -1 to disable auto-scaling on width
	public static var AUTO_SCALE_TARGET_HEI = -1; // -1 to disable auto-scaling on height
	public static var SCALE = 1.0; // ignored if auto-scaling
	public static var UI_SCALE = 1.0;
	public static var GRID = 16;

	static var _uniq = 0;
	public static var NEXT_UNIQ(get,never) : Int; static inline function get_NEXT_UNIQ() return _uniq++;
	public static var INFINITE = 999999;

	static var _inc = 0;
	public static var DP_BG = _inc++;
	public static var DP_FX_BG = _inc++;
	public static var DP_MAIN = _inc++;
	public static var DP_FRONT = _inc++;
	public static var DP_FX_FRONT = _inc++;
	public static var DP_TOP = _inc++;
	public static var DP_UI = _inc++;

	public static var BUTTON_DELAY_MS = 60; 

	public static var LEVEL_RESET_POINT = 10;
	public static var LEVEL_DELAY_S = 2;
	
	public static var PERFECT_SCORE = 1000;
	public static var GOOD_SCORE = 500;
	public static var OK_SCORE = 250;
	public static var POOR_SCORE = 100;
	public static var BAD_SCORE_MULTIPLIER = 10;
	public static var PERFECT_SCORE_THRESHOLD_S = 0.10;
	public static var GOOD_SCORE_THRESHOLD_S = 0.5;
	public static var OK_SCORE_THRESHOLD_S = 1;
	public static var POOR_SCORE_THRESHOLD_S = 2;
	public static var BAD_SCORE_THRESHOLD_S = 3;
	public static var SCORE_TO_GET_A_LIFE = 10000;

	public static var HUD_SCALE = 4;
}
