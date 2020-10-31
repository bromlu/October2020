package en;

import h3d.Vector;
import h2d.Text;

class GameOver extends Entity {
    public function new(x, y, finalScore: Int) {
        super(x, y);

        var gameOverText = new h2d.Text(Assets.fontPixel);
        gameOverText.color = new Vector(1, 0, 0);
        gameOverText.text = "Game Over! Final Score " + Std.string(finalScore) + ". Press R to restart.";
        gameOverText.scale(Const.HUD_SCALE/2);
    
        spr.addChild(gameOverText);
        spr.set("Nothing");
    }
}