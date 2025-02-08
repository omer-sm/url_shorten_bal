import ballerina/http;

Shortener shortener = new(checkpanic new FileDB("./data/data.json", true));

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
}
