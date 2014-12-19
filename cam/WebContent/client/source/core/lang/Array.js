/**
 * 扩展标准的数组类型
 * 
 * @class Array
 */
L5.applyIf(Array.prototype, {
	/**
	 * 检查某个对象是否在数组里.
	 * 
	 * @param {Object}
	 *            o 需要检查的对象
	 * @return {Number} 如果在数组里，则返回所在index (或者 -1 表示没有找到)
	 */
	indexOf : function(o) {
		for ( var i = 0, len = this.length; i < len; i++) {
			if (this[i] == o)
				return i;
		}
		return -1;
	},

	/**
	 * 删除数组里的某个对象 如果对象没有找到则什么都不做.
	 * 
	 * @param {Object}
	 *            o 需要删除的对象
	 * @return {Array} 当前数组
	 */
	remove : function(o) {
		var index = this.indexOf(o);
		if (index != -1) {
			this.splice(index, 1);
		}
		return this;
	}
});