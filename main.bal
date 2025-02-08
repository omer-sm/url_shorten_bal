import ballerina/io as _;
public function main() {
    var db = checkpanic new FileDB("./data/data.json", true);
    var shortener = new Shortener(db);

    checkpanic shortener.add("https://google.com");
}
