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

	public static var C4: Sound;
	public static var DS4: Sound;
	public static var E4: Sound;
	public static var FS4: Sound;
	public static var G4: Sound;
	public static var AS4: Sound;

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

		C4 = hxd.Res.loader.load("C4.mp3").toSound();
		DS4 = hxd.Res.loader.load("DS4.mp3").toSound();
		E4 = hxd.Res.loader.load("E4.mp3").toSound();
		FS4 = hxd.Res.loader.load("FS4.mp3").toSound();
		G4 = hxd.Res.loader.load("G4.mp3").toSound();
		AS4 = hxd.Res.loader.load("AS4.mp3").toSound();
	}
}