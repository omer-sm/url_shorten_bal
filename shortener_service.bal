import ballerina/http;
import ballerina/data.jsondata;

Shortener shortener = new(checkpanic new FileDB("./data.json", true));

service on new http:Listener(8080) {
    resource function get [string urlKey]() returns http:Response {
        var res = new http:Response();
        json url = checkpanic shortener.get(urlKey);

        if url === () {
            res.statusCode = http:STATUS_NOT_FOUND;

            return res;
        }

        res.setBinaryPayload(("<script>window.location.href = '" + url.toString()  + "'</script>").toBytes(), "text/html");

        return res;
    }

    resource function post shorten(@http:Payload string payload) returns http:Response|error {
        var newUrl = check jsondata:read(check jsondata:parseString(payload), `$.url`);
        check shortener.add(newUrl.toString());
        var res = new http:Response();
        res.statusCode = http:STATUS_CREATED;

        return res;
    }
}
