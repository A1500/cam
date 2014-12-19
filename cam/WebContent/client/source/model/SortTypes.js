/**
 * 定义排序用的默认转换函数
 * @class L5.model.SortTypes
 */
L5.model.SortTypes = {
    /**
     * 默认排序，什么都不做
     * @method none
     * @private
     * @param {Mixed} s 需要转换的值
     * @return {Mixed} 比较值
     */
    none : function(s){
        return s;
    },
    
    /**
     * 正则表达式标签
     * @private
     * @type {RegExp}
     * @property stripTagsRE
     */
    stripTagsRE : /<\/?[^>]+>/gi,
    
    /**
     * 剔除HTML标记，只是纯粹的文本排序
     * @method asText
     * @param {Mixed} s 要转换的值
     * @return {String} 比较值
     */
    asText : function(s){
        return String(s).replace(this.stripTagsRE, "");
    },
    
    /**
     * 剔除HTML标记，只是纯粹的text排序，大小写敏感
     * @method asUCText
     * @param {Mixed} s 要转换的值
     * @return {String} 比较值
     */
    asUCText : function(s){
        return String(s).toUpperCase().replace(this.stripTagsRE, "");
    },
    
    /**
     * 忽略大小写的字符串比较
     * @method asUCString
     * @param {Mixed} s 要转换的值
     * @return {String} 比较值
     */
    asUCString : function(s) {
    	return String(s).toUpperCase();
    },
    
    /**
     * 日期排序
     * @method asDate
     * @param {Mixed} s 要转换的值
     * @return {String} 比较值
     */
    asDate : function(s) {
        if(!s){
            return 0;
        }
        if(L5.isDate(s)){
            return s.getTime();
        }
    	return Date.parse(String(s));
    },
    
    /**
     * Fload类型的排序
     * @method asFloat
     * @param {Mixed} s 要转换的值
     * @return {String} 比较值
     */
    asFloat : function(s) {
    	var val = parseFloat(String(s).replace(/,/g, ""));
        if(isNaN(val)) val = 0;
    	return val;
    },
    
    /**
     * Integer类型的排序
     * @method asInt
     * @param {Mixed} s 要转换的值
     * @return {String} 比较值
     */
    asInt : function(s) {
        var val = parseInt(String(s).replace(/,/g, ""));
        if(isNaN(val)) val = 0;
    	return val;
    }
};