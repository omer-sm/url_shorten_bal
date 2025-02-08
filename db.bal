public type DB object {
    function insert(string key, json value) returns error?;
    function get(string key) returns json|error;
    function has(string key) returns boolean|error;
    function getAll() returns json|error;
};