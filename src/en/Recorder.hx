package en;

import dn.Process;

class Recorder extends Process {
    public var recordedPattern: Array<Pattern>;
    public var isRecording(get, never): Bool; inline function get_isRecording() return _isRecording;

    private var _isRecording: Bool;
    private var timer: Float;
    private var currentPatternIndex: Int;
    private var notesToRecord: Int;

    public function new() {
        super();
        _isRecording = false;
        recordedPattern = [];
        currentPatternIndex = -1;
    }

    public function finishRecording() {
        trace("DONE");
        _isRecording = false;
    }

    public function startRecording(notesToRecord: Int) {
        this.notesToRecord = notesToRecord;
        _isRecording = true;
    }

    override function update() {
        super.update();

        if (!isRecording) return;

        var snapshot: Array<Note> = takeSnapshot();
        if (currentPatternIndex == -1 || !compareSnapshots(recordedPattern[currentPatternIndex].notes, snapshot)) {
            if (currentPatternIndex != -1) {
                recordedPattern[currentPatternIndex].noteLength = framesToSec(ftime) - timer;
            }

            if (recordedPattern.length == notesToRecord) {
                finishRecording();
            } else {
                recordedPattern.push(new Pattern(snapshot, 0));
                timer = framesToSec(ftime);
                currentPatternIndex++;
            }
        }
    }

    override function onDispose() {
        super.onDispose();
        recordedPattern = null;
    }

    private function takeSnapshot() {
        return Note.ALL.filter(note -> note.isDown);
    }

    private function compareSnapshots(snapshot1: Array<Note>, snapshot2: Array<Note>) {
        if (snapshot1.length != snapshot2.length) {
            return false;
        }
        for (i in 0...snapshot1.length) {
            if(snapshot1[i].keyToBind != snapshot2[i].keyToBind) return false;
        }
        return true;
    }
}