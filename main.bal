import ballerina/io;
public function main() {
    var db = checkpanic new FileDB("./data/data.json", true);
    checkpanic db.insert("mykey", "value");
    var val = checkpanic db.get("mykey");
    var val1 = checkpanic db.get("mykey1");

    io:println(val);
    io:println(val1 === ());
}
