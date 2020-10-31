package en;

import h3d.Vector;
import h2d.Text;

class Score extends Entity {
    public var currentScore: Int = 0;
    var scoreValue: Text;

    public function new(x, y) {
        super(x, y);

        var scoreDescription = new h2d.Text(Assets.fontPixel);
        scoreValue = new h2d.Text(Assets.fontPixel);
        scoreDescription.text = "Score: ";
        scoreDescription.scale(Const.HUD_SCALE);
        scoreValue.text = Std.string(currentScore);
        scoreValue.scale(Const.HUD_SCALE);
        scoreValue.x = Const.HUD_SCALE * 32 + 4;
        spr.addChild(scoreDescription);
        spr.addChild(scoreValue);
        spr.set("Nothing");
    }

    override function update() {
        super.update();

        if(game.recorder.isRecording) {
            if (game.recorder.currentPatternIndex == -1) return;

            if (!Patterns.compareSnapshots(
                game.recorder.recordedPattern[game.recorder.currentPatternIndex].notes, 
                game.levelManager.currentPattern[game.recorder.currentPatternIndex].notes)) {
                    game.recorder.finishRecording();
                    game.levelManager.loseALife();
                    return;
                }
        }
    }

    public function scorePattern(expectedPattern: Array<Pattern>, actualPattern: Array<Pattern>) {
        if (expectedPattern.length == 0 || actualPattern.length == 0) return;
        
        var totalDiff: Float = 0.0;

        if (expectedPattern.length != actualPattern.length 
            || !Patterns.compareSnapshots(expectedPattern[expectedPattern.length - 1].notes, actualPattern[actualPattern.length - 1].notes)) {
            totalDiff = Const.BAD_SCORE_THRESHOLD_S;
        } else {
            for (i in 0...expectedPattern.length) {
                totalDiff += Math.abs(expectedPattern[i].noteLength - actualPattern[i].noteLength);
            }
            totalDiff /= expectedPattern.length;
        }

        var howWellYouDidText: String = "";
        var color: Vector = new Vector(0,0,0);
        if (totalDiff < Const.PERFECT_SCORE_THRESHOLD_S) {
            currentScore += Const.PERFECT_SCORE;
            howWellYouDidText = "PERFECT!";
            color = new Vector(0,1,0);
        } else if (totalDiff < Const.GOOD_SCORE_THRESHOLD_S) {
            currentScore += Const.GOOD_SCORE;
            howWellYouDidText = "GOOD!";
            color = new Vector(0,1,0);
        } else if (totalDiff < Const.OK_SCORE_THRESHOLD_S) {
            currentScore += Const.OK_SCORE;
            howWellYouDidText = "OK!";
            color = new Vector(1,1,0);
        } else if (totalDiff < Const.POOR_SCORE_THRESHOLD_S) {
            currentScore += Const.POOR_SCORE;
            howWellYouDidText = "POOR!";
            color = new Vector(1,1,0);
        } else {
            currentScore += (Const.BAD_SCORE_MULTIPLIER * (actualPattern.length - 1));
            howWellYouDidText = "BAD!";
            color = new Vector(1,0,0);
        }

        scoreValue.text = Std.string(currentScore);
        fx.markerText(cx + 13,cy - 1, howWellYouDidText, color, 3);
    }

    public function reset() {
        currentScore = 0;
        scoreValue.text = Std.string(currentScore);
    }
}