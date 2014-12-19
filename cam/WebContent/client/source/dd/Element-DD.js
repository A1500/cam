/*
 * Element的拖拽(Drag-Drop)
 */
/**
 * Initializes a {@link L5.dd.DD} drag drop object for this element.
 * 
 * @param {String}
 *            group The group the DD object is member of
 * @param {Object}
 *            config The DD config object
 * @param {Object}
 *            overrides An object containing methods to override/implement on
 *            the DD object
 * @return {L5.dd.DD} The DD object
 */
L5.Element.prototype.initDD = function(group, config, overrides) {
	var dd = new L5.dd.DD(L5.id(this.dom), group, config);
	return L5.apply(dd, overrides);
};

/**
 * chu'shi a {@link L5.dd.DDProxy} object for this element.
 * 
 * @param {String}
 *            group 代理对象所在组名
 * @param {Object}
 *            config 给代理对象用的配置属性
 * @param {Object}
 *            overrides 给代理对象附加的一些方法
 * @return {L5.dd.DDProxy} 代理对象
 */
L5.Element.prototype.initDDProxy = function(group, config, overrides) {
	var dd = new L5.dd.DDProxy(L5.id(this.dom), group, config);
	return L5.apply(dd, overrides);
};

/**
 * 初始化一个拖拽目标对象 {@link L5.dd.DDTarget}
 * 
 * @param {String}
 *            group 拖拽目标对象所在组名
 * @param {Object}
 *            config 给目标对象用的配置属性
 * @param {Object}
 *            overrides 给目标对象附加的一些方法
 * @return {L5.dd.DDTarget} 目标对象
 */
L5.Element.prototype.initDDTarget = function(group, config, overrides) {
	var dd = new L5.dd.DDTarget(L5.id(this.dom), group, config);
	return L5.apply(dd, overrides);
};