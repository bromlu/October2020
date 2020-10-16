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
                }
        }
    }
}