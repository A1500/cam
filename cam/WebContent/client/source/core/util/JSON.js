/**
 * @class L5.util.JSON
 * Modified version of Douglas Crockford"s json.js that doesn"t
 * mess with the Object prototype
 * http://www.json.org/js.html
 * @singleton
 */
L5.util.JSON = new (function(){
    var useHasOwn = !!{}.hasOwnProperty;

    // crashes Safari in some instances
    //var validRE = /^("(\\.|[^"\\\n\r])*?"|[,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t])+?$/;

    var pad = function(n) {
        return n < 10 ? "0" + n : n;
    };

    var m = {
        "\b": '\\b',
        "\t": '\\t',
        "\n": '\\n',
        "\f": '\\f',
        "\r": '\\r',
        '"' : '\\"',
        "\\": '\\\\'
    };

    var encodeString = function(s){
        if (/["\\\x00-\x1f]/.test(s)) {
            return '"' + s.replace(/([\x00-\x1f\\"])/g, function(a, b) {
                var c = m[b];
                if(c){
                    return c;
                }
                c = b.charCodeAt();
                return "\\u00" +
                    Math.floor(c / 16).toString(16) +
                    (c % 16).toString(16);
            }) + '"';
        }
        return '"' + s + '"';
    };

    var encodeArray = function(o){
        var a = ["["], b, i, l = o.length, v;
            for (i = 0; i < l; i += 1) {
                v = o[i];
                switch (typeof v) {
                    case "undefined":
                    case "function":
                    case "unknown":
                        break;
                    default:
                        if (b) {
                            a.push(',');
                        }
                        a.push(v === null ? "null" : L5.util.JSON.encode(v));
                        b = true;
                }
            }
            a.push("]");
            return a.join("");
    };

    this.encodeDate = function(o){
        return '"' + o.getFullYear() + "-" +
                pad(o.getMonth() + 1) + "-" +
                pad(o.getDate()) + "T" +
                pad(o.getHours()) + ":" +
                pad(o.getMinutes()) + ":" +
                pad(o.getSeconds()) + '"';
    };

    /**
     * Encodes an Object, Array or other value
     * @param {Mixed} o The variable to encode
     * @return {String} The JSON string
     */
    this.encode = function(o){
        if(typeof o == "undefined" || o === null){
            return "null";
        }else if(o.toJsonString){
        	return o.toJsonString();
        }else if(L5.isArray(o)){
            return encodeArray(o);
        }else if(L5.isDate(o)){
            return L5.util.JSON.encodeDate(o);
        }else if(typeof o == "string"){
            return encodeString(o);
        }else if(typeof o == "number"){
            return isFinite(o) ? String(o) : "null";
        }else if(typeof o == "boolean"){
            return String(o);
        }else {
            var a = ["{"], b, i, v;
            for (i in o) {
                if(!useHasOwn || o.hasOwnProperty(i)) {
                    v = o[i];
                    switch (typeof v) {
                    case "undefined":
                    case "function":
                    case "unknown":
                        break;
                    default:
                        if(b){
                            a.push(',');
                        }
                        a.push(this.encode(i), ":",
                                v === null ? "null" : this.encode(v));
                        b = true;
                    }
                }
            }
            a.push("}");
            return a.join("");
        }
    };

    /**
     * Decodes (parses) a JSON string to an object. If the JSON is invalid, this function throws a SyntaxError.
     * @param {String} json The JSON string
     * @return {Object} The resulting object
     */
    this.decode = function(json){
    	try{
        return eval("(" + json + ')');
        }catch(e){
			throw new L5.Exception(550, L5.parseReturnError?L5.parseReturnError:"parse return error");
		}
    };
})();
/**
 * Shorthand for {@link L5.util.JSON#encode}
 * @param {Mixed} o The variable to encode
 * @return {String} The JSON string
 * @member L5
 * @method encode
 */
L5.encode = L5.util.JSON.encode;
/**
 * Shorthand for {@link L5.util.JSON#decode}
 * @param {String} json The JSON string
 * @return {Object} The resulting object
 * @member L5
 * @method decode
 */
L5.decode = L5.util.JSON.decode;
