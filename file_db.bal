import ballerina/file;
import ballerina/io;

public class FileDB {
    *DB;
    string filePath;

    function init(string filePath, boolean doReset = false) returns error? {
        self.filePath = filePath;
        check self.initializeDb(doReset);
    }

    function initializeDb(boolean doReset) returns error? {
        if doReset {
            check file:remove(self.filePath);
        }

        if !(check file:test(self.filePath, file:EXISTS)) {
            check file:create(self.filePath);
            check io:fileWriteJson(self.filePath, {});
        }
    }

    function get(string key) returns json|error {
        json data = check io:fileReadJson(self.filePath);
        map<json> dataMap = check data.ensureType();
        
        return dataMap[key];
    }

    function insert(string key, json value) returns error? {
        json data = check io:fileReadJson(self.filePath);
        json newData = check data.mergeJson({[key]: value});

        check io:fileWriteJson(self.filePath, newData);
    }
    
}