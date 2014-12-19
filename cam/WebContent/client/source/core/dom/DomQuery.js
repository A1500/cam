/**
 * 根据编译请求提供高效的将选择符 / xpath 处理为可复用的函数的方法。可以添加新的伪类和匹配器。该类可以运行于 HTML 和 XML
 * 文档之上（如果给出了一个内容节点）。
 * <p>
 * DomQuery支持大多数的CSS3选择符，同时也支持某些自定义选择符和基本的XPath。
 * </p>
 * <p>
 * 下列所有的选择符、属性过滤器和伪类可以在任何命令中无限地组合使用。例如："div.foo:nth-child(odd)[@foo=bar].bar:first"将是一个完全有效的选择符。
 * 命令中出现的节点过滤器将可以使你根据自己的文档结构对查询做出优化。
 * </p>
 * <h4>元素选择符:</h4>
 * <ul class="list">
 * <li> <b>*</b>匹配所有元素</li>
 * <li> <b>E</b>匹配标签名为E的元素</li>
 * <li> <b>E F</b>匹配所有包含在E标签中的F标签元素，如<E><F></F></E></li>
 * <li> <b>E > F</b> 或者 <b>E/F</b>匹配所有包含在E标签中，作为直接子节点的F标签元素</li>
 * <li> <b>E + F</b>匹配所有E标签的直接前驱节点为F标签的元素</li>
 * <li> <b>E ~ F</b>匹配所有作为E标签前驱兄弟节点的F标签元素</li>
 * </ul>
 * <h4>属性选择符:</h4>
 * <p>
 * 
 * @和单引号都是可选的，div[@foo='bar']和div[foo=bar]是等价有效的
 * </p>
 * <ul class="list">
 * <li> <b>E[foo]</b>匹配所有拥有foo属性的<E>标签</li>
 * <li> <b>E[foo=bar]</b>匹配所有foo属性值为bar的<E>标签</li>
 * <li> <b>E[foo^=bar]</b>匹配所有foo属性值以bar开头的<E>标签</li>
 * <li> <b>E[foo$=bar]</b>匹配所有foo属性值以bar结尾的<E>标签</li>
 * <li> <b>E[foo*=bar]</b>匹配所有foo属性值包含bar的<E>标签</li>
 * <li> <b>E[foo%=2]</b>匹配所有foo属性值可以被2整除的<E>标签</li>
 * <li> <b>E[foo!=bar]</b>匹配所有fo属性值不为bar的<E>标签</li>
 * </ul>
 * <h4>伪类:</h4>
 * <ul class="list">
 * <li> <b>E:first-child</b>匹配所有当前标签是本身父节点的第一个子节点的元素</li>
 * <li> <b>E:last-child</b>匹配所有当前标签是本身父节点的最后一个子节点的元素</li>
 * <li> <b>E:nth-child(<i>n</i>)</b>匹配所有当前标签是本身父节点的第n个子节点的元素</li>
 * <li> <b>E:nth-child(odd)</b>匹配所有当前标签是本身父节点的奇数子节点的元素</li>
 * <li> <b>E:nth-child(even)</b>匹配所有当前标签是本身父节点的偶数子节点的元素</li>
 * <li> <b>E:only-child</b>匹配所有当前标签是本身父节点的唯一子节点的元素</li>
 * <li> <b>E:checked</b>匹配所有当前标签的check属性为true的元素</li>
 * <li> <b>E:first</b>当前标签为结果集的第一个元素</li>
 * <li> <b>E:last</b>当前标签是结果集的最后一个元素</li>
 * <li> <b>E:nth(<i>n</i>)</b>当前标签是结果集的第n个元素元素，索引从1开始计算</li>
 * <li> <b>E:odd</b>是nth-child(odd)的简写</li>
 * <li> <b>E:even</b> 是nth-child(even)的简写</li>
 * <li> <b>E:contains(foo)</b>标签的innerHTML属性值包含"foo"</li>
 * <li> <b>E:nodeValue(foo)</b>标签的textValue或nodeValue包含"foo"</li>
 * <li> <b>E:not(S)</b>标签不匹配单选择符S</li>
 * <li> <b>E:has(S)</b>标签有个后继与简单选择符S匹配</li>
 * <li> <b>E:next(S)</b>标签的后一个兄弟标签与简单选择符S匹配</li>
 * <li> <b>E:prev(S)</b>标签的前一个兄弟标签与简单选择符S匹配</li>
 * </ul>
 * <h4>CSS值选择符:</h4>
 * <ul class="list">
 * <li> <b>E{display=none}</b>匹配所有CSS的"display"值为"none"的元素</li>
 * <li> <b>E{display^=none}</b>匹配所有CSS的"display"值以"none"开头的元素</li>
 * <li> <b>E{display$=none}</b>匹配所有CSS的"display"值以"none"结尾的元素</li>
 * <li> <b>E{display*=none}</b>匹配所有CSS的"display"值包含"none"的元素</li>
 * <li> <b>E{display%=2}</b>匹配所有CSS的"display"值能被2整除的元素</li>
 * <li> <b>E{display!=none}</b>匹配所有CSS的"display"值不为"none"的元素</li>
 * </ul>
 * @constructor
 * @class L5.DomQuery
 */
L5.DomQuery = function() {
	// do nothing
};
(function() {
	var cache = {}, simpleCache = {}, valueCache = {};
	var nonSpace = /\S/;
	var trimRe = /^\s+|\s+$/g;
	var tplRe = /\{(\d+)\}/g;
	var modeRe = /^(\s?[\/>+~]\s?|\s|$)/;
	var tagTokenRe = /^(#)?([\w-\*]+)/;
	var nthRe = /(\d*)n\+?(\d*)/, nthRe2 = /\D/;
	/**
	 * 
	 * 查找p的子节点深度是index，节点类型是元素element
	 * 
	 * @private
	 */
	function child(p, index) {
		var i = 0;
		var n = p.firstChild;
		while (n) {
			/**
			 * nodeType是文档类型 元素类型 节点类型 元素element 1 属性attr 2 文本text 3 注释comments
			 * 8 文档document 9
			 */
			if (n.nodeType == 1) {
				if (++i == index) {
					return n;
				}
			}
			n = n.nextSibling;// n的下一个兄弟节点
		}
		return null;
	}

	/**
	 * 查找节点类型是element类型的的next的下一个兄弟节点
	 * 
	 * @private
	 */
	function next(n) {
		// 有next节点并且节点不是element类型的才会继续查找否则就将查找到的兄弟节点返回
		while ((n = n.nextSibling) && n.nodeType != 1)
			;
		return n;
	}

	/**
	 * 查找节点类型是element类型的的next的上一个兄弟节点
	 * 
	 * @private
	 */
	function prev(n) {
		while ((n = n.previousSibling) && n.nodeType != 1)
			;
		return n;
	}

	/**
	 * 为节点d的每个子节点都添加nodeIndex索引
	 * 
	 * @private
	 */
	function children(d) {
		var n = d.firstChild, ni = -1;
		while (n) {
			var nx = n.nextSibling;
			if (n.nodeType == 3 && !nonSpace.test(n.nodeValue)) {
				d.removeChild(n);
			} else {
				n.nodeIndex = ++ni;
			}
			n = nx;
		}
		return this;
	}

	/**
	 * 通过className查看c中是否有包含v中css选择器的节点，返回包含的数组
	 * 
	 * @private
	 */
	function byClassName(c, a, v) {
		if (!v) {
			return c;
		}
		var r = [], ri = -1, cn;
		for ( var i = 0, ci; ci = c[i]; i++) {
			if ((' ' + ci.className + ' ').indexOf(v) != -1) {
				r[++ri] = ci;
			}
		}
		return r;
	}

	/**
	 * @private 获取节点n的attr属性
	 */
	function attrValue(n, attr) {
		if (!n.tagName && typeof n.length != "undefined") {
			n = n[0];
		}
		if (!n) {
			return null;
		}
		if (attr == "for") {
			return n.htmlFor;
		}
		if (attr == "class" || attr == "className") {
			return n.className;
		}
		return n.getAttribute(attr) || n[attr];

	}

	/**
	 * @private 通过tagName和mode获取ns下的符合的集合 mode是选择模式 参照：
	 *          <h4>元素选择符:</h4>
	 *          <ul class="list">
	 *          <li> <b>*</b>匹配所有元素</li>
	 *          <li> <b>E</b>匹配标签名为E的元素</li>
	 *          <li> <b>E F</b>匹配所有包含在E标签中的F标签元素，如<E><F></F></E></li>
	 *          <li> <b>E > F</b> 或者 <b>E/F</b>匹配所有包含在E标签中，作为直接子节点的F标签元素</li>
	 *          <li> <b>E + F</b>匹配所有E标签的直接前驱节点为F标签的元素</li>
	 *          <li> <b>E ~ F</b>匹配所有作为E标签前驱兄弟节点的F标签元素</li>
	 *          </ul>
	 */
	function getNodes(ns, mode, tagName) {
		var result = [], ri = -1, cs;
		if (!ns) {
			return result;
		}
		tagName = tagName || "*";
		if (typeof ns.getElementsByTagName != "undefined") {
			ns = [ ns ];
		}
		if (!mode) {
			for ( var i = 0, ni; ni = ns[i]; i++) {
				cs = ni.getElementsByTagName(tagName);
				for ( var j = 0, ci; ci = cs[j]; j++) {
					result[++ri] = ci;
				}
			}
		} else if (mode == "/" || mode == ">") {
			var utag = tagName.toUpperCase();
			for ( var i = 0, ni, cn; ni = ns[i]; i++) {
				cn = ni.children || ni.childNodes;
				for ( var j = 0, cj; cj = cn[j]; j++) {
					if (cj.nodeName == utag || cj.nodeName == tagName
							|| tagName == '*') {
						result[++ri] = cj;
					}
				}
			}
		} else if (mode == "+") {
			var utag = tagName.toUpperCase();
			for ( var i = 0, n; n = ns[i]; i++) {
				while ((n = n.nextSibling) && n.nodeType != 1)
					;
				if (n
						&& (n.nodeName == utag || n.nodeName == tagName || tagName == '*')) {
					result[++ri] = n;
				}
			}
		} else if (mode == "~") {
			for ( var i = 0, n; n = ns[i]; i++) {
				while ((n = n.nextSibling)
						&& (n.nodeType != 1 || (tagName == '*' || n.tagName
								.toLowerCase() != tagName)))
					;
				if (n) {
					result[++ri] = n;
				}
			}
		}
		return result;
	}

	/**
	 * @private 类似数组的concat，是b转给a的一个方法
	 */
	function concat(a, b) {
		if (b.slice) {
			return a.concat(b);
		}
		for ( var i = 0, l = b.length; i < l; i++) {
			a[a.length] = b[i];
		}
		return a;
	}
	/**
	 * @private 内部使用
	 */
	function byTag(cs, tagName) {
		if (cs.tagName || cs == document) {
			cs = [ cs ];
		}
		if (!tagName) {
			return cs;
		}
		var r = [], ri = -1;
		tagName = tagName.toLowerCase();
		for ( var i = 0, ci; ci = cs[i]; i++) {
			if (ci.nodeType == 1 && ci.tagName.toLowerCase() == tagName) {
				r[++ri] = ci;
			}
		}
		return r;
	}

	/**
	 * @private 内部使用
	 */
	function byId(cs, attr, id) {
		if (cs.tagName || cs == document) {
			cs = [ cs ];
		}
		if (!id) {
			return cs;
		}
		var r = [], ri = -1;
		for ( var i = 0, ci; ci = cs[i]; i++) {
			if (ci && ci.id == id) {// 这里存在问题，因为IE下表单元素的id值不能为"id"
				r[++ri] = ci;
				return r;
			}
		}
		return r;
	}

	/**
	 * @private 内部使用
	 */
	function byAttribute(cs, attr, value, op, custom) {
		var r = [], ri = -1, st = custom == "{";
		var f = L5.DomQuery.operators[op];
		for ( var i = 0, ci; ci = cs[i]; i++) {
			var a;
			if (st) {
				a = L5.DomQuery.getStyle(ci, attr);
			} else if (attr == "class" || attr == "className") {
				a = ci.className;
			} else if (attr == "for") {
				a = ci.htmlFor;
			} else if (attr == "href") {
				a = ci.getAttribute("href", 2);
			} else {
				a = ci.getAttribute(attr);
			}
			if ((f && f(a, value)) || (!f && (a === 0 ? true : a))) {
				r[++ri] = ci;
			}
		}
		return r;
	}

	/**
	 * byPseudo方法，它只不过是个适配器，根据伪类的类型返回真正的处理函数。
	 * 
	 * @private
	 * 
	 */
	function byPseudo(cs, name, value) {
		return L5.DomQuery.pseudos[name](cs, value);
	}

	// This is for IE MSXML which does not support expandos.
	// IE runs the same speed using setAttribute, however FF slows way down
	// and Safari completely fails so they need to continue to use expandos.
	var isIE = window.ActiveXObject ? true : false;

	// this eval is stop the compressor from
	// renaming the variable to something shorter
	eval("var batch = 30803;");

	var key = 30803;

	function nodupIEXml(cs) {
		var d = ++key;
		cs[0].setAttribute("_nodup", d);
		var r = [ cs[0] ];
		for ( var i = 1, len = cs.length; i < len; i++) {
			var c = cs[i];
			if (!c.getAttribute("_nodup") != d) {
				c.setAttribute("_nodup", d);
				r[r.length] = c;
			}
		}
		for ( var i = 0, len = cs.length; i < len; i++) {
			cs[i].removeAttribute("_nodup");
		}
		return r;
	}

	function nodup(cs) {
		if (!cs) {
			return [];
		}
		var len = cs.length, c, i, r = cs, cj, ri = -1;
		if (!len || typeof cs.nodeType != "undefined" || len == 1) {
			return cs;
		}
		if (isIE && typeof cs[0].selectSingleNode != "undefined") {
			return nodupIEXml(cs);
		}
		var d = ++key;
		cs[0]._nodup = d;
		for (i = 1; c = cs[i]; i++) {
			if (c._nodup != d) {
				c._nodup = d;
			} else {
				r = [];
				for ( var j = 0; j < i; j++) {
					r[++ri] = cs[j];
				}
				for (j = i + 1; cj = cs[j]; j++) {
					if (cj._nodup != d) {
						cj._nodup = d;
						r[++ri] = cj;
					}
				}
				return r;
			}
		}
		return r;
	}

	function quickDiffIEXml(c1, c2) {
		var d = ++key;
		for ( var i = 0, len = c1.length; i < len; i++) {
			c1[i].setAttribute("_qdiff", d);
		}
		var r = [];
		for ( var i = 0, len = c2.length; i < len; i++) {
			if (c2[i].getAttribute("_qdiff") != d) {
				r[r.length] = c2[i];
			}
		}
		for ( var i = 0, len = c1.length; i < len; i++) {
			c1[i].removeAttribute("_qdiff");
		}
		return r;
	}

	function quickDiff(c1, c2) {
		var len1 = c1.length;
		if (!len1) {
			return c2;
		}
		if (isIE && c1[0].selectSingleNode) {
			return quickDiffIEXml(c1, c2);
		}
		var d = ++key;
		for ( var i = 0; i < len1; i++) {
			c1[i]._qdiff = d;
		}
		var r = [];
		for ( var i = 0, len = c2.length; i < len; i++) {
			if (c2[i]._qdiff != d) {
				r[r.length] = c2[i];
			}
		}
		return r;
	}
	/**
	 * 在处理ID选择器时，分为两个函数，分别为查找模式（type="select"）与过滤模式。
	 * <p>
	 * 个人觉得它好像不可能处理IE中的getElementById的bug。过滤模式用于反选选择器。
	 */
	function quickId(ns, mode, root, id) {
		if (ns == root) {
			var d = root.ownerDocument || root;
			return d.getElementById(id);
		}
		ns = getNodes(ns, mode, "*");
		return byId(ns, null, id);
	}

	/**
	 * 匹配的正则表达式集合和代码片段
	 */
	L5.DomQuery.matchers = [
			{
				re : /^\.([\w-]+)/,
				select : 'n = byClassName(n, null, " {1} ");'
			},
			{
				re : /^\:([\w-]+)(?:\(((?:[^\s>\/]*|.*?))\))?/,
				select : 'n = byPseudo(n, "{1}", "{2}");'
			},
			{
				re : /^(?:([\[\{])(?:@)?([\w-]+)\s?(?:(=|.=)\s?['"]?(.*?)["']?)?[\]\}])/,
				select : 'n = byAttribute(n, "{2}", "{4}", "{3}", "{1}");'
			}, {
				re : /^#([\w-]+)/,
				select : 'n = byId(n, null, "{1}");'
			}, {
				re : /^@([\w-]+)/,
				select : 'return {firstChild:{nodeValue:attrValue(n, "{1}")}};'
			} ];

	/**
	 * <p>
	 * 操作符比较函数的集合，默认的操作符是=, !=, ^=, $=, *=, %=, |= 和 ~=。
	 * <p>
	 * 可以添加格式为c=格式的操作符，其中c可以是除空格、>、<三种字符的任意字符
	 */
	L5.DomQuery.operators = {
		"=" : function(a, v) {
			return a == v;
		},
		"!=" : function(a, v) {
			return a != v;
		},
		"^=" : function(a, v) {
			return a && a.substr(0, v.length) == v;
		},
		"$=" : function(a, v) {
			return a && a.substr(a.length - v.length) == v;
		},
		"*=" : function(a, v) {
			return a && a.indexOf(v) !== -1;
		},
		"%=" : function(a, v) {
			return (a % v) == 0;
		},
		"|=" : function(a, v) {
			return a && (a == v || a.substr(0, v.length + 1) == v + '-');
		},
		"~=" : function(a, v) {
			return a && (' ' + a + ' ').indexOf(' ' + v + ' ') != -1;
		}
	};

	/**
	 * 伪类处理器集合。每一个处理器将传递当前节点集（数组形式）和参数（如果有）以供选择符使用。
	 * <p>
	 * pseudos你可以管它做适配器对象，也可以称之为switch Object。嘛，叫什么都一样，它可以帮我们从无限的if...else
	 * if....else if 语句中解放出来。
	 */
	L5.DomQuery.pseudos = {
		"first-child" : function(c) {
			var r = [], ri = -1, n;
			for ( var i = 0, ci; ci = n = c[i]; i++) {// 要求前面不能再有元素节点
				while ((n = n.previousSibling) && n.nodeType != 1)
					;
				if (!n) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"last-child" : function(c) {
			var r = [], ri = -1, n;
			for ( var i = 0, ci; ci = n = c[i]; i++) {// 要求其后不能再有元素节点
				while ((n = n.nextSibling) && n.nodeType != 1)
					;
				if (!n) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"nth-child" : function(c, a) {
			var r = [], ri = -1;
			var m = nthRe.exec(a == "even" && "2n" || a == "odd" && "2n+1"
					|| !nthRe2.test(a) && "n+" + a || a);
			var f = (m[1] || 1) - 0, l = m[2] - 0;
			for ( var i = 0, n; n = c[i]; i++) {
				var pn = n.parentNode;
				if (batch != pn._batch) {// 在父节点上添加一个私有属性_batch，
					var j = 0;
					for ( var cn = pn.firstChild; cn; cn = cn.nextSibling) {
						if (cn.nodeType == 1) {
							cn.nodeIndex = ++j;
						}
					}
					pn._batch = batch;
				}
				if (f == 1) {// f就是an+b中的a，如果f为1时，那么只取出nodeIndex为b的元素节点即可
					if (l == 0 || n.nodeIndex == l) {
						r[++ri] = n;
					}
					// 否则使用以下公式取元素(见实验2)
				} else if ((n.nodeIndex + l) % f == 0) {
					r[++ri] = n;
				}
			}

			return r;
		},

		"only-child" : function(c) {
			var r = [], ri = -1;
			;
			for ( var i = 0, ci; ci = c[i]; i++) {
				if (!prev(ci) && !next(ci)) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"empty" : function(c) {
			var r = [], ri = -1;
			for ( var i = 0, ci; ci = c[i]; i++) {
				var cns = ci.childNodes, j = 0, cn, empty = true;
				while (cn = cns[j]) {
					++j;
					if (cn.nodeType == 1 || cn.nodeType == 3) {
						empty = false;
						break;
					}
				}
				if (empty) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"contains" : function(c, v) {
			var r = [], ri = -1;
			for ( var i = 0, ci; ci = c[i]; i++) {
				if ((ci.textContent || ci.innerText || '').indexOf(v) != -1) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"nodeValue" : function(c, v) {
			var r = [], ri = -1;
			for ( var i = 0, ci; ci = c[i]; i++) {
				if (ci.firstChild && ci.firstChild.nodeValue == v) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"checked" : function(c) {
			var r = [], ri = -1;
			for ( var i = 0, ci; ci = c[i]; i++) {
				if (ci.checked == true) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"not" : function(c, ss) {
			return L5.DomQuery.filter(c, ss, true);
		},

		"any" : function(c, selectors) {
			var ss = selectors.split('|');
			var r = [], ri = -1, s;
			for ( var i = 0, ci; ci = c[i]; i++) {
				for ( var j = 0; s = ss[j]; j++) {
					if (L5.DomQuery.is(ci, s)) {
						r[++ri] = ci;
						break;
					}
				}
			}
			return r;
		},

		"odd" : function(c) {
			return this["nth-child"](c, "odd");
		},

		"even" : function(c) {
			return this["nth-child"](c, "even");
		},

		"nth" : function(c, a) {
			return c[a - 1] || [];
		},

		"first" : function(c) {
			return c[0] || [];
		},

		"last" : function(c) {
			return c[c.length - 1] || [];
		},

		"has" : function(c, ss) {
			var s = L5.DomQuery.select;
			var r = [], ri = -1;
			for ( var i = 0, ci; ci = c[i]; i++) {
				if (s(ss, ci).length > 0) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"next" : function(c, ss) {
			var is = L5.DomQuery.is;
			var r = [], ri = -1;
			for ( var i = 0, ci; ci = c[i]; i++) {
				var n = next(ci);
				if (n && is(n, ss)) {
					r[++ri] = ci;
				}
			}
			return r;
		},

		"prev" : function(c, ss) {
			var is = L5.DomQuery.is;
			var r = [], ri = -1;
			for ( var i = 0, ci; ci = c[i]; i++) {
				var n = prev(ci);
				if (n && is(n, ss)) {
					r[++ri] = ci;
				}
			}
			return r;
		}
	};

	/**
	 * 获得某个元素的某个样式属性
	 * 
	 * @param el
	 * @param name
	 * @returns {String}
	 */
	L5.DomQuery.getStyle = function(el, name) {
		return L5.fly(el).getStyle(name);
	};

	/**
	 * 将CSS选择符或者xpath表达式编译成一个回调函数，用户可以为回调函数传递一个root参数，回调寒素就会以root参数对应的元素为起点进行查询
	 * <p>
	 * 它用eval动态生成查询函数
	 * 
	 * @param {String}
	 *            path 选择符、xpath表达式
	 * @param {String}
	 *            type (可选) "select"或者"simple" 默认是"select"
	 * @return {Function} 回调函数
	 */
	L5.DomQuery.compile = function(path, type) {
		type = type || "select";
		// 用于编译的代码
		var fn = [ "var f = function(root){\n var mode; ++batch; var n = root || document;\n" ];
		// 选择器
		var q = path, mode, lq;
		var tk = L5.DomQuery.matchers;
		var tklen = tk.length;
		var mm;
		// 取出关系选择器的自符
		// accept leading mode switch
		var lmode = q.match(modeRe);
		// 如 alert("> .aaa".match(/^(/s?[//>+~]/s?|/s|$)/))
		// 弹出 > ,>
		if (lmode && lmode[1]) {// 如果存在 / > + ~ 这四个选择器，我们将对编译代码与选择器进行些操作
			// 编译代码将增加，如 mode=">"的字段
			fn[fn.length] = 'mode="' + lmode[1].replace(trimRe, "") + '";';
			// 选择器 > .aaa 将变成 .aaa
			q = q.replace(lmode[1], "");
		}
		// 如果选择器被消耗到以断句符“/”开头，那么移除它，把第二行代入path 如 "/h1[title]" 的情形
		while (path.substr(0, 1) == "/") {
			path = path.substr(1);
		}

		while (q && lq != q) {// 如果选择器q不等于undefined或null
			lq = q;// tagTokenRe = /^(#)?([/w-/*]+)/,
			var tm = q.match(tagTokenRe);// 判定其是ID选择器，标签选择器亦或通配符选择器
			if (type == "select") {
				if (tm) {
					if (tm[1] == "#") {// 如果是ID选择器，
						fn[fn.length] = 'n = quickId(n, mode, root, "' + tm[2]
								+ '");';
					} else {// 如果是标签选择器
						fn[fn.length] = 'n = getNodes(n, mode, "' + tm[2]
								+ '");';
					}
					q = q.replace(tm[0], "");
				} else if (q.substr(0, 1) != '@') {
					fn[fn.length] = 'n = getNodes(n, mode, "*");';
				}
			} else {
				if (tm) {
					if (tm[1] == "#") {
						fn[fn.length] = 'n = byId(n, null, "' + tm[2] + '");';
					} else {
						fn[fn.length] = 'n = byTag(n, "' + tm[2] + '");';
					}
					q = q.replace(tm[0], "");
				}
			}
			while (!(mm = q.match(modeRe))) {
				var matched = false;
				for ( var j = 0; j < tklen; j++) {
					var t = tk[j];
					var m = q.match(t.re);// 用matchers里面的正则依次匹配选择器，
					if (m) {// 如果通过则把matchers.select里面的{1},{2}这些东西替换为相应的字符
						fn[fn.length] = t.select.replace(tplRe, function(x, i) {
							return m[i];
						});
						q = q.replace(m[0], "");// 移除选择器相应的部分
						matched = true;// 中止循环
						break;
					}
				}
				// prevent infinite loop on bad selector
				if (!matched) {
					throw 'Error parsing selector, parsing failed at "' + q
							+ '"';
				}
			}
			if (mm[1]) {// 添加编译代码，如 mode="~"的字段
				fn[fn.length] = 'mode="' + mm[1].replace(trimRe, "") + '";';
				q = q.replace(mm[1], "");// 移除选择器相应的部分
			}
		}
		fn[fn.length] = "return nodup(n);\n}";// 添加移除重复元素的编译代码
		eval(fn.join(""));// 连结所有要编译的代码，用eval进行编译，于是当前作用域使增加一个叫f的函数
		return f;// 返回f查询函数
	};

	/**
	 * 查找一组元素，会根据CSS选择符和root根节点返回匹配的元素数组
	 * 
	 * @param {String}
	 *            path 选择符、xpath表达式
	 * @param {Node}
	 *            root (可选) 查询的起点(默认是document)
	 * @return {Array} 匹配的元素数组，如果没有匹配的对象，返回空数组
	 * @public
	 */
	L5.DomQuery.select = function(path, root, type) {
		if (!root || root == document) {
			root = document;
		}
		if (typeof root == "string") {
			root = document.getElementById(root);
		}
		var paths = path.split(",");// 把选择器按并联选择器分解
		var results = [];
		for ( var i = 0, len = paths.length; i < len; i++) {
			var p = paths[i].replace(trimRe, "");// 移除左右两边的空白节点
			if (!cache[p]) {
				cache[p] = L5.DomQuery.compile(p);// 把刚编译出来的查询函数放进缓存体中
				if (!cache[p]) {
					throw p + " is not a valid selector";
				}
			}
			var result = cache[p](root);// 把文档对象传进去，获取目标元素
			if (result && result != document) {// 如果能获取元素或并不返回我们原来传入的那个文档对象
				results = results.concat(result);// 就把它并入最终结果中
			}
		}
		if (paths.length > 1) {// 去除重复元素
			return nodup(results);
		}
		return results;
	};

	/**
	 * 选择一个满足条件的节点(满足条件的节点很多、取第一个)
	 * 
	 * @param {String}
	 *            path 选择符、xpath表达式
	 * @param {Node}
	 *            root (可选) 查询的起点(默认是document)
	 * @return {HTMLElement} 匹配的DOM元素
	 * @public
	 */
	L5.DomQuery.selectNode = function(path, root) {
		return L5.DomQuery.select(path, root)[0];
	};

	/**
	 * 返回节点的值，如果是null用defaultValue代替
	 * 
	 * @param {String}
	 *            path 选择符、xpath表达式
	 * @param {Node}
	 *            root (可选) 查询的起点(默认是document)
	 * @param {String}
	 *            defaultValue 默认值
	 *            
	 * @return {String} 节点的值
	 */
	L5.DomQuery.selectValue = function(path, root, defaultValue) {
		path = path.replace(trimRe, "");
		if (!valueCache[path]) {
			valueCache[path] = L5.DomQuery.compile(path, "select");
		}
		var n = valueCache[path](root);
		n = n[0] ? n[0] : n;
		var v = (n && n.firstChild ? n.firstChild.nodeValue : null);
		return ((v === null || v === undefined || v === '') ? defaultValue : v);
	};

	/**
	 * 返回root中第一个匹配selector的对象的节点值，转换为整数或浮点数返回，如果没有匹配的，返回默认值或者0
	 * 
	 * @param {String}
	 *            path 选择符、xpath表达式
	 * @param {Node}
	 *            root (optional) 查询的起点(默认是document)
	 * @param {Number}
	 *            defaultValue 默认值
	 * @return {Number}
	 */
	L5.DomQuery.selectNumber = function(path, root, defaultValue) {
		var v = L5.DomQuery.selectValue(path, root, defaultValue || 0);
		return parseFloat(v);
	};

	/**
	 * 验证el是否匹配传入的选择符(例如:div.some-class 或者 span:first-child)
	 * 
	 * @param {String/HTMLElement/Array}
	 *            el 元素的id或者元素对象或者元素对象数组
	 * @param {String}
	 *            ss 要验证的选择符
	 * @return {Boolean}
	 */
	L5.DomQuery.is = function(el, ss) {
		if (typeof el == "string") {
			el = document.getElementById(el);
		}
		var isArray = L5.isArray(el);
		var result = L5.DomQuery.filter(isArray ? el : [ el ], ss);
		return isArray ? (result.length == el.length) : (result.length > 0);
	};

	/**
	 * 过滤元素数组对象，保留匹配的元素对象(例如:div.some-class 或者 span:first-child)
	 * 
	 * @param {Array}
	 *            el 要过滤的元素对象数组
	 * @param {String}
	 *            ss 要匹配的选择符
	 * @param {Boolean}
	 *            nonMatches 如果是true，返回不匹配的元素
	 * @return {Array} 匹配或者不匹配的元素数组集合
	 */
	L5.DomQuery.filter = function(els, ss, nonMatches) {
		ss = ss.replace(trimRe, "");
		if (!simpleCache[ss]) {
			simpleCache[ss] = L5.DomQuery.compile(ss, "simple");
		}
		var result = simpleCache[ss](els);
		return nonMatches ? quickDiff(result, els) : result;
	};

})();

/**
 * 根据CSS选择符或者XPath查找DOM节点对象，返回数组，是{@link L5.DomQuery#select}的缩写
 * 
 * @param {String}
 *            path 选择符或者xpath表达式
 * @param {Node}
 *            root (可选) 查找的起点(默认是整个document)
 * @return {Array} 节点对象数组
 * @method query
 */
L5.query = L5.DomQuery.select;
