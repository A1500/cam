/**
 * 扩展标准的数字类型
 * 
 * @class Number
 */
L5.applyIf(Number.prototype, {
	/**
	 * 检查当前数字是否在特定的区间内. 否则将返回最大值或者最小值，取决于当前数字本身。
	 * 
	 * @param {Number}
	 *            min 最小值
	 * @param {Number}
	 *            max 最大值
	 * @return {Number} 如果大于最大值则是最大值，如果小于最小值则是最小值，否则当前值本身。
	 */
	constrain : function(min, max) {
		return Math.min(Math.max(this, min), max);
	}
});