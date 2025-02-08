import ballerina/random;

public class Shortener {
    private DB db;
    private final int KEY_LEN = 5;

    function init(DB db) {
        self.db = db;
    }

    function add(string url) returns error? {
        string key = check self.generateKey();

        while check self.db.has(key) {
            key = check self.generateKey();
        }

        check self.db.insert(key, url);
    }

    function get(string key) returns json|error {
        return self.db.get(key);
    }

    private function generateKey() returns string|error {
        int[] keyChars = [];

        foreach int i in 0...self.KEY_LEN {
            keyChars.push(check random:createIntInRange(65, 123));
        }

        return string:fromCodePointInts(keyChars);
    }
}