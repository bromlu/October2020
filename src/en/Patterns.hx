package en;

class Patterns {
    private static var noteLengths: Array<Float> = [
        1,
        0.5,
        0.25
    ];

    public static function GeneratePattern(numberOfNotes: Int, speedModifier: Float = 1): Array<Pattern> {
        var patterns = [];

        for (i in 0...numberOfNotes) {
            var noteIndex = M.randRange(0, Note.ALL.length - 1);
            var noteLengthIndex = M.randRange(0, noteLengths.length - 1);

            var pattern = new Pattern(Note.ALL[noteIndex], noteLengths[noteLengthIndex] / speedModifier);
            patterns.push(pattern);
        }

        return patterns;
    }
}