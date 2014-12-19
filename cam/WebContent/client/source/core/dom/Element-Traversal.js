/*
 * 节点路由，寻找父节点、寻找子节点 
 */
/**
 * 选择一个满足条件的子孙节点 (选择器不能包含id).
 * 
 * @param {String}
 *            selector 选择符、xpath表达式
 * @param {Boolean}
 *            returnDom (optional) True：返回HTMLElement元素而不是L5.Element(默认是 false)
 * @return {HTMLElement/L5.Element}
 */
L5.Element.prototype.child = function(selector, returnDom) {
	var n = L5.DomQuery.selectNode(selector, this.dom);
	return returnDom ? n : L5.get(n);
};

/**
 * 选择一个满足条件的子孙节点 (选择器不能包含id);"只在一个方向上找"?
 * 
 * @param {String}
 *            selector 选择符、xpath表达式
 * @param {Boolean}
 *            returnDom (optional) True：返回HTMLElement对象而不是L5.Element(默认是 false)
 * 
 * @return {HTMLElement/L5.Element}
 */
L5.Element.prototype.down = function(selector, returnDom) {
	var n = L5.DomQuery.selectNode(" > " + selector, this.dom);
	return returnDom ? n : L5.get(n);
};

/**
 * 如果当前节点满足条件就返回当前节点；否则查找满足条件的祖先节点
 * 
 * @param {String}
 *            selector 选择符、xpath表达式
 * @param {Number/Mixed}
 *            maxDepth (optional) 最大递归深度 (defaults to 10 || document.body)
 * @param {Boolean}
 *            returnEl (optional) Tree:返回L5.Element对象，否则返回HTMLElement
 * 
 * @return {L5.Element/HTMLElement}
 */
L5.Element.prototype.findParent = function(simpleSelector, maxDepth, returnEl) {
	var p = this.dom, b = document.body, depth = 0, dq = L5.DomQuery, stopEl;
	maxDepth = maxDepth || 50;
	if (typeof maxDepth != "number") {
		stopEl = L5.getDom(maxDepth);
		maxDepth = 10;
	}
	while (p && p.nodeType == 1 && depth < maxDepth && p != b && p != stopEl) {
		if (dq.is(p, simpleSelector)) {
			return returnEl ? L5.get(p) : p;
		}
		depth++;
		p = p.parentNode;
	}
	return null;
};

/**
 * 查找满足条件的祖先节点；
 * 
 * @param {String}
 *            selector 选择符、xpath表达式
 * @param {Number/Mixed}
 *            maxDepth (optional) 最大递归深度 (defaults to 10 || document.body)
 * @param {Boolean}
 *            returnEl (optional) Tree:返回L5.Element对象，否则返回HTMLElement
 * 
 * @return {L5.Element/HTMLElement}
 */
L5.Element.prototype.findParentNode = function(simpleSelector, maxDepth,
		returnEl) {
	var p = L5.fly(this.dom.parentNode, '_internal');
	return p ? p.findParent(simpleSelector, maxDepth, returnEl) : null;
};

/**
 * 同(@link #findParentNode)，只不过这个方法只返回对应的L5.Element对象。
 * 
 * @param {String}
 *            selector 选择符、xpath表达式
 * @param {Number/Mixed}
 *            maxDepth (optional) 最大递归深度 (defaults to 10 || document.body)
 * 
 * @return {L5.Element}
 */
L5.Element.prototype.up = function(simpleSelector, maxDepth) {
	return this.findParentNode(simpleSelector, maxDepth, true);
};

/**
 * 查询满足条件的子节点 (选择符不能包含id).
 * 
 * @param {String}
 *            selector 选择符、xpath表达式
 * 
 * @return {Array} 满足条件的节点组成的数组
 */
L5.Element.prototype.query = function(selector) {
	return L5.DomQuery.select(selector, this.dom);
};

/**
 * 获取一个祖先节点
 * 
 * @param {String}
 *            selector (optional) 选择符、xpath表达式
 * @param {Boolean}
 *            returnDom (optional) True：返回HTMLElement元素而不是L5.Element(默认是 false)
 * 
 * @return {L5.Element/HTMLElement}
 */
L5.Element.prototype.parent = function(selector, returnDom) {
	return this.matchNode('parentNode', 'parentNode', selector, returnDom);
};

/**
 * 获取下一个兄弟节点、忽略文本节点
 * 
 * @param {String}
 *            selector (optional) 选择符、xpath表达式
 * @param {Boolean}
 *            returnDom (optional) True：返回HTMLElement元素而不是L5.Element(默认是 false)
 * 
 * @return {L5.Element/HTMLElement}
 */
L5.Element.prototype.next = function(selector, returnDom) {
	return this.matchNode('nextSibling', 'nextSibling', selector, returnDom);
};

/**
 * 获取前一个兄弟节点、忽略文本节点
 * 
 * @param {String}
 *            selector (optional) 选择符、xpath表达式
 * @param {Boolean}
 *            returnDom (optional) True：返回HTMLElement元素而不是L5.Element(默认是 false)
 * 
 * @return {L5.Element/HTMLElement}
 */
L5.Element.prototype.prev = function(selector, returnDom) {
	return this.matchNode('previousSibling', 'previousSibling', selector,
			returnDom);
};

/**
 * 获得第一个子节点、忽略文本节点
 * 
 * @param {String}
 *            selector (optional) 选择符、xpath表达式
 * @param {Boolean}
 *            returnDom (optional) True：返回HTMLElement元素而不是L5.Element(默认是 false)
 * 
 * @return {L5.Element/HTMLElement}
 */
L5.Element.prototype.first = function(selector, returnDom) {
	return this.matchNode('nextSibling', 'firstChild', selector, returnDom);
};

/**
 * 获得最后一个子节点, 忽略文本节点
 * 
 * @param {String}
 *            selector (optional) 选择符、xpath表达式
 * @param {Boolean}
 *            returnDom (optional) True：返回HTMLElement元素而不是L5.Element(默认是 false)
 * 
 * @return {L5.Element/HTMLElement}
 */
L5.Element.prototype.last = function(selector, returnDom) {
	return this.matchNode('previousSibling', 'lastChild', selector, returnDom);
};

/**
 * 按指定方向(往前找所有兄弟节点/往后找所有兄弟节点/找所有祖先节点)找合适的节点
 * 
 * @param {String}
 *            dir
 *            方向：previousSibling：往前找所有兄弟节点；nextSibling：往后找所有兄弟节点；parentNode：找所有祖先节点
 * @param {}
 *            start 起始位置
 * @param {String}
 *            selector 选择符、xpath表达式
 * @param {Boolean}
 *            returnDom (optional) True：返回HTMLElement元素而不是L5.Element(默认是 false)
 * 
 */
L5.Element.prototype.matchNode = function(dir, start, selector, returnDom) {
	var n = this.dom[start];
	while (n) {
		if (n.nodeType == 1 && (!selector || L5.DomQuery.is(n, selector))) {
			return !returnDom ? L5.get(n) : n;
		}
		n = n[dir];
	}
	return null;
};