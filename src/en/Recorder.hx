package en;

import dn.Process;

class Recorder extends Process {
    public var recordedPattern: Array<Pattern>;
    public var isRecording(get, never): Bool; inline function get_isRecording() return _isRecording;
    public var currentPatternIndex: Int;
    
    private var _isRecording: Bool;
    private var timer: Float;
    private var notesToRecord: Int;
    private var noButtonsPressedLastFrame: Bool;

    public function new() {
        super();
        resetRecorder();
    }

    public function finishRecording() {
        _isRecording = false;
    }

    public function startRecording(notesToRecord: Int) {
        this.notesToRecord = notesToRecord;  
        _isRecording = true;
    }

    public function resetRecorder() {
        _isRecording = false;
        recordedPattern = [];
        currentPatternIndex = -1;
    }

    override function update() {
        super.update();

        if (!isRecording) return;

        var snapshot: Array<Note> = takeSnapshot();
        if (currentPatternIndex == -1 || !Patterns.compareSnapshots(noButtonsPressedLastFrame ? [] : recordedPattern[currentPatternIndex].notes, snapshot)) {
            if (currentPatternIndex != -1 && recordedPattern[currentPatternIndex].noteLength == -1) {
                recordedPattern[currentPatternIndex].noteLength = framesToSec(ftime) - timer;
            }

            if (recordedPattern.length == notesToRecord) {
                finishRecording();
            } else if (snapshot.length > 0) {
                recordedPattern.push(new Pattern(snapshot, -1));
                timer = framesToSec(ftime);
                currentPatternIndex++;
            }

            noButtonsPressedLastFrame = snapshot.length == 0;
        }
    }

    override function onDispose() {
        super.onDispose();
        recordedPattern = null;
    }

    private function takeSnapshot() {
        return Note.ALL.filter(note -> note.isDown);
    }
}