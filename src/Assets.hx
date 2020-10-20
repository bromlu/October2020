import hxd.res.Sound;
import dn.heaps.assets.SfxDirectory;
import dn.heaps.slib.*;

class Assets {
	public static var fontPixel : h2d.Font;
	public static var fontTiny : h2d.Font;
	public static var fontSmall : h2d.Font;
	public static var fontMedium : h2d.Font;
	public static var fontLarge : h2d.Font;
	public static var tiles : SpriteLib;

	public static var QHarmonics: Sound;
	public static var WHarmonics: Sound;
	public static var EHarmonics: Sound;
	public static var AHarmonics: Sound;
	public static var SHarmonics: Sound;
	public static var DHarmonics: Sound;

	public static var Baseline1: Sound;

	static var initDone = false;
	public static function init() {
		if( initDone )
			return;
		initDone = true;

		fontPixel = hxd.Res.fonts.minecraftiaOutline.toFont();
		fontTiny = hxd.Res.fonts.barlow_condensed_medium_regular_9.toFont();
		fontSmall = hxd.Res.fonts.barlow_condensed_medium_regular_11.toFont();
		fontMedium = hxd.Res.fonts.barlow_condensed_medium_regular_17.toFont();
		fontLarge = hxd.Res.fonts.barlow_condensed_medium_regular_32.toFont();
		tiles = dn.heaps.assets.Atlas.load("atlas/tiles.atlas");

		QHarmonics = hxd.Res.loader.load("audio/QHarmonics.wav").toSound();
		WHarmonics = hxd.Res.loader.load("audio/WHarmonics.wav").toSound();
		EHarmonics = hxd.Res.loader.load("audio/EHarmonics.wav").toSound();
		AHarmonics = hxd.Res.loader.load("audio/AHarmonics.wav").toSound();
		SHarmonics = hxd.Res.loader.load("audio/SHarmonics.wav").toSound();
		DHarmonics = hxd.Res.loader.load("audio/DHarmonics.wav").toSound();

		Baseline1 = hxd.Res.loader.load("audio/Baseline1.wav").toSound();
	}
}