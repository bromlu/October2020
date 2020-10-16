package en;

import hxd.Rand;

class Patterns {
    private static var noteLengths: Array<Float> = [
        1,
        0.5,
        0.25
    ];

    public static function GeneratePattern(numberOfNotes: Int, speedModifier: Float = 1): Array<Pattern> {
        var patterns = [];
        var rand = Rand.create();

        var i = 0;
        var availableNoteIndexs: Array<Int> = [while (i < Note.ALL.length) i++];
        rand.shuffle(availableNoteIndexs);
        var noteIndex: Int = -1;
        for (j in 0...numberOfNotes) {
            var lastNoteIndex = noteIndex;
            noteIndex = availableNoteIndexs.pop();

            if(lastNoteIndex != -1) {
                availableNoteIndexs.push(lastNoteIndex);
                rand.shuffle(availableNoteIndexs);
            }

            var noteLengthIndex = M.randRange(0, noteLengths.length - 1);

            var pattern = new Pattern([Note.ALL[noteIndex]], noteLengths[noteLengthIndex] / speedModifier);
            patterns.push(pattern);
        }

        return patterns;
    }

    public static function compareSnapshots(snapshot1: Array<Note>, snapshot2: Array<Note>) {
        if (snapshot1.length != snapshot2.length) {
            return false;
        }
        for (i in 0...snapshot1.length) {
            if(snapshot1[i].keyToBind != snapshot2[i].keyToBind) return false;
        }
        return true;
    }
}