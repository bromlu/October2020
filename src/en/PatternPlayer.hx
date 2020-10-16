package en;

import dn.Process;

class PatternPlayer extends Process {
    public var pattern: Array<Pattern>;
    public var isPlaying(get, never): Bool; inline function get_isPlaying() return _isPlaying;

    private var _isPlaying: Bool;
    private var timer: Float;
    private var currentPatternIndex: Int;

    public function new() {
        super();
        _isPlaying = false;
    }

    public function playPattern(pattern: Array<Pattern>) {
        this.pattern = pattern;
        currentPatternIndex = 0;
        timer = framesToSec(ftime);
        _isPlaying = true;
    }

    public function stopPlayingPattern() {
        _isPlaying = false;
    }

    override function update() {
        super.update();

        if (!isPlaying) return;

        if (framesToSec(ftime) - timer >= pattern[currentPatternIndex].noteLength) {
            for (note in pattern[currentPatternIndex].notes) {
                note.setButtonUp();
            }
            currentPatternIndex++;
            timer = framesToSec(ftime);
            if (currentPatternIndex >= pattern.length) {
                _isPlaying = false;
            }
        } else {
            for (note in pattern[currentPatternIndex].notes) {
                note.setButtonDown();
            }
        }			
	
    }

    override function onDispose() {
        super.onDispose();
        pattern = null;
    }
}