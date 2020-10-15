package en;

class Pattern {
    public var note: Note;
    public var noteLength: Float;

    public function new(note: Note, noteLength: Float) {
        this.note = note;
        this.noteLength = noteLength;
    }
}