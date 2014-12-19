/**
 * 增加按键处理：用户在选中某个元素并按下某个键时执行某个函数
 * 
 * @param {Number/Array/Object/String}
 *            key ，可以是下面几种可能：
 *            <li>字符串：键名(); </li>
 *            <li>数字：key code; </li>
 *            <li>数组：key code 数组;</li>
 *            <li>对象: {key: (number or array), shift: (true/false), ctrl:
 *            (true/false), alt: (true/false)}</li>
 * @param {Function}
 *            fn 按下键时要执行的函数
 * @param {Object}
 *            scope (optional)
 * @return {L5.KeyMap}
 */
L5.Element.prototype.addKeyListener = function(key, fn, scope) {
	var config;
	if (typeof key != "object" || L5.isArray(key)) {
		config = {
			key : key,
			fn : fn,
			scope : scope
		};
	} else {
		config = {
			key : key.key,
			shift : key.shift,
			ctrl : key.ctrl,
			alt : key.alt,
			fn : fn,
			scope : scope
		};
	}
	return new L5.KeyMap(this, config);
};

/**
 * 创建一个 KeyMap 对象
 * 
 * @param {Object}
 *            config 创建KeyMap对象需要的配置属性，具体配置介绍参考L5.KeyMap
 * @return {L5.KeyMap}
 */
L5.Element.prototype.addKeyMap = function(config) {
	return new L5.KeyMap(this, config);
};