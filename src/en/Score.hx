package en;

class Score extends Entity {
    public function new(x, y) {
        super(x, y);
    }

    override function update() {
        super.update();

        if(game.recorder.isRecording) {
            if (game.recorder.currentPatternIndex == -1) return;

            if (!Patterns.compareSnapshots(
                game.recorder.recordedPattern[game.recorder.currentPatternIndex].notes, 
                game.levelManager.currentPattern[game.recorder.currentPatternIndex].notes)) {
                    game.recorder.finishRecording();
                    trace("FAIL!!!");
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

        if (totalDiff < Const.PERFECT_SCORE_THRESHOLD_S) {
            trace("PERFECT! " + Const.PERFECT_SCORE);
        } else if (totalDiff < Const.GOOD_SCORE_THRESHOLD_S) {
            trace("GOOD! " + Const.GOOD_SCORE);
        } else if (totalDiff < Const.OK_SCORE_THRESHOLD_S) {
            trace("OK! " + Const.OK_SCORE);
        } else if (totalDiff < Const.POOR_SCORE_THRESHOLD_S) {
            trace("POOR! " + Const.POOR_SCORE);
        } else {
            trace("BAD! " + (Const.BAD_SCORE_MULTIPLIER * (actualPattern.length - 1)));
        }
    }
}