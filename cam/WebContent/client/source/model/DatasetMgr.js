/**
 * Dataset注册管理器 
 * @class L5.DatasetMgr
 * @extends L5.util.MixedCollection
 */
L5.DatasetMgr = L5.apply(new L5.util.MixedCollection(), {

    /**
     * 注册一个或多个Dataset对象，任何dataset对象只要有id标识并初始化后即会自动注册
     * @method register
     * @private
     * @param {L5.model.Dataset} dataset1 dataset实例对象
     * @param {L5.model.Dataset} dataset2 (可选)
     * @param {L5.model.Dataset} etc (可选)
     */
    register : function(){
        for (var i = 0, s; s = arguments[i]; i++) {
			this.add(s);
			s.on("loadexception", function() {
				var n = arguments.length;
				var e = arguments[n - 1];
				if (e.statusText != null)
					e = e.statusText;
				L5.Msg.alert(e.title?e.title:(L5.loadDateError ? L5.loadDateError : "load date error:"),
						e);
			});
		}
    },

    /**
     * 取消一个或多个Dataset的注册信息
     * @method unregister
     * @private
     * @param {String/Object} id1 dataset的id或者是dataset实例对象
     * @param {String/Object} id2 (可选)
     * @param {String/Object} etc (可选)
     */
    unregister : function(){
        for (var i = 0, s; s = arguments[i]; i++) {
			this.remove(this.lookup(s));
		}
    },

    /**
     * 根据id得到注册的dataset对象
     * @method lookup
     * @param {String/Object} id dataset的id或者是dataset实例对象
     * @return {L5.model.Dataset} dataset对象
     */
    lookup : function(id){
    	var dataset = typeof id == "object" ? id : this.get(id);
		if (dataset == null) {
			alert(L5.notfind + id);
		}
		return dataset;
    },

    /**
     * 获取dataset对象的id
     * @method getKey
     * @private
     * @param {Object} o 对象
     * @return {String} id
     */
    getKey : function(o){
         return o.ds || o.id;
    }
});