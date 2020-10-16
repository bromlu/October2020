package en;

class Pattern {
    public var notes: Array<Note>;
    public var noteLength: Float;

    public function new(notes: Array<Note>, noteLength: Float) {
        this.notes = notes;
        this.noteLength = noteLength;
    }
}