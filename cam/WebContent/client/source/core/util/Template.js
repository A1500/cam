/**
 * 轻量级html模版工具，用于处理html片段。模版可以使用参数，也可以使用L5.util.Format类提供的函数 <br />
 * 例如：
 * 
 * <pre><code>
 * var t = new L5.Template('&lt;div name=&quot;{id}&quot;&gt;',
 * 		'&lt;span class=&quot;{cls}&quot;&gt;{name:trim} {value:ellipsis(10)}&lt;/span&gt;', '&lt;/div&gt;');
 * 
 * t.append('some-element', {
 * 	id : 'myid',
 * 	cls : 'myclass',
 * 	name : 'foo',
 * 	value : 'bar'
 * });
 * </code></pre>
 * 
 * @class L5.Template
 * @constructor
 * @param {String/Array}
 *            html
 */
L5.Template = function(html) {
	var a = arguments;
	if (L5.isArray(html)) {
		html = html.join("");
	} else if (a.length > 1) {
		var buf = [];
		for ( var i = 0, len = a.length; i < len; i++) {
			if (typeof a[i] == 'object') {
				L5.apply(this, a[i]);
			} else {
				buf[buf.length] = a[i];
			}
		}
		html = buf.join('');
	}
	/** @private */
	this.html = html;
	if (this.compiled) {
		this.compile();
	}
};
L5.Template.prototype = {
	/**
	 * 应用指定参数值生成HTML片段
	 * 
	 * @param {Object}
	 *            values 应用到模版上的参数值. (比如. {foo: 'bar'})
	 * 
	 * @return {String} HTML片段
	 */
	applyTemplate : function(values) {
		if (this.compiled) {
			return this.compiled(values);
		}
		var useF = this.disableFormats !== true;
		var fm = L5.util.Format, tpl = this;
		var fn = function(m, name, format, args) {
			if (format && useF) {
				if (format.substr(0, 5) == "this.") {
					return tpl.call(format.substr(5), values[name], values);
				} else {
					if (args) {
						// quoted values are required for strings in compiled
						// templates,
						// but for non compiled we need to strip them
						// quoted reversed for jsmin
						var re = /^\s*['"](.*)["']\s*$/;
						args = args.split(',');
						for ( var i = 0, len = args.length; i < len; i++) {
							args[i] = args[i].replace(re, "$1");
						}
						args = [ values[name] ].concat(args);
					} else {
						args = [ values[name] ];
					}
					return fm[format].apply(fm, args);
				}
			} else {
				return values[name] !== undefined ? values[name] : "";
			}
		};
		return this.html.replace(this.re, fn);
	},

	/**
	 * 设置这个模版使用的html片段
	 * 
	 * @param {String}
	 *            html
	 * @param {Boolean}
	 *            compile (optional) true表示编译这个模版(默认是 undefined)
	 * @return {L5.Template} this
	 * @private
	 */
	set : function(html, compile) {
		this.html = html;
		this.compiled = null;
		if (compile) {
			this.compile();
		}
		return this;
	},

	/**
	 * true表示不使用L5.util.Format定义的函数 (默认是false)
	 * 
	 * @type Boolean
	 */
	disableFormats : false,

	/**
	 * @type RegExp
	 * @property
	 */
	re : /\{([\w-]+)(?:\:([\w\.]*)(?:\((.*?)?\))?)?\}/g,

	/**
	 * 编译模版
	 * 
	 * @return {L5.Template} this
	 * @private
	 */
	compile : function() {
		var fm = L5.util.Format;
		var useF = this.disableFormats !== true;
		var sep = L5.isGecko ? "+" : ",";
		var fn = function(m, name, format, args) {
			if (format && useF) {
				args = args ? ',' + args : "";
				if (format.substr(0, 5) != "this.") {
					format = "fm." + format + '(';
				} else {
					format = 'this.call("' + format.substr(5) + '", ';
					args = ", values";
				}
			} else {
				args = '';
				format = "(values['" + name + "'] == undefined ? '' : ";
			}
			return "'" + sep + format + "values['" + name + "']" + args + ")"
					+ sep + "'";
		};
		var body;
		// branched to use + in gecko and [].join() in others
		if (L5.isGecko) {
			body = "this.compiled = function(values){ return '"
					+ this.html.replace(/\\/g, '\\\\').replace(/(\r\n|\n)/g,
							'\\n').replace(/'/g, "\\'").replace(this.re, fn)
					+ "';};";
		} else {
			body = [ "this.compiled = function(values){ return ['" ];
			body.push(this.html.replace(/\\/g, '\\\\').replace(/(\r\n|\n)/g,
					'\\n').replace(/'/g, "\\'").replace(this.re, fn));
			body.push("'].join('');};");
			body = body.join('');
		}
		eval(body);
		return this;
	},

	/**
	 * @private
	 */
	call : function(fnName, value, allValues) {
		return this[fnName](value, allValues);
	},

	/**
	 * 应用指定参数值生成内容，并将生成的内容插入到指定元素中作为给元素的第一个子元素。
	 * 
	 * @param {Mixed}
	 *            el 父元素、生成的新的内容插入到这个元素中
	 * @param {Object}
	 *            values 应用到模版上的参数值. (比如. {foo: 'bar'})
	 * @param {Boolean}
	 *            returnElement (optional)
	 *            true表示返回值是个L5.Element对象false表示返回的是HTMLElement对象 (默认是
	 *            undefined)
	 * 
	 * @return {HTMLElement/L5.Element} 新节点或是新的L5.Element对象
	 */
	insertFirst : function(el, values, returnElement) {
		return this.doInsert('afterBegin', el, values, returnElement);
	},

	/**
	 * 应用指定参数值生成内容，并将生成的内容插入到指定元素的前面，作为指定元素的前一个兄弟节点。
	 * 
	 * @param {Mixed}
	 *            el 指定元素，新内容会是这个元素的前一个兄弟节点
	 * @param {Object}
	 *            values 应用到模版上的参数值. (比如. {foo: 'bar'})
	 * @param {Boolean}
	 *            returnElement (optional)
	 *            true表示返回值是个L5.Element对象false表示返回的是HTMLElement对象 (默认是
	 *            undefined)
	 * @return {HTMLElement/L5.Element} 新节点或是新的L5.Element对象
	 */
	insertBefore : function(el, values, returnElement) {
		return this.doInsert('beforeBegin', el, values, returnElement);
	},

	/**
	 * 应用指定参数值生成内容，并将生成的内容插入到指定元素后面，作为指定元素的后一个兄弟节点。
	 * 
	 * @param {Mixed}
	 *            el 指定元素，新内容会是这个元素的后一个兄弟节点
	 * @param {Object}
	 *            values 应用到模版上的参数值. (比如. {foo: 'bar'})
	 * @param {Boolean}
	 *            returnElement (optional)
	 *            true表示返回值是个L5.Element对象false表示返回的是HTMLElement对象 (默认是
	 *            undefined)
	 * @return {HTMLElement/L5.Element} 新节点或是新的L5.Element对象
	 */
	insertAfter : function(el, values, returnElement) {
		return this.doInsert('afterEnd', el, values, returnElement);
	},

	/**
	 * 应用指定参数值生成内容，并将生成的内容插入到指定元素中作为给元素的最后一个子元素。
	 * 
	 * @param {Mixed}
	 *            el 父元素、生成的新的内容插入到这个元素中
	 * @param {Object}
	 *            values 应用到模版上的参数值. (比如. {foo: 'bar'})
	 * @param {Boolean}
	 *            returnElement (optional)
	 *            true表示返回值是个L5.Element对象false表示返回的是HTMLElement对象 (默认是
	 *            undefined)
	 * 
	 * @return {HTMLElement/L5.Element} 新节点或是新的L5.Element对象
	 */
	append : function(el, values, returnElement) {
		return this.doInsert('beforeEnd', el, values, returnElement);
	},

	/**
	 * @private
	 */
	doInsert : function(where, el, values, returnEl) {
		el = L5.getDom(el);
		var newNode = L5.DomHelper.insertHtml(where, el, this
				.applyTemplate(values));
		return returnEl ? L5.get(newNode, true) : newNode;
	},

	/**
	 * 应用指定参数值生成内容，并将生成的内容覆盖指定元素的innerHTML。
	 * 
	 * @param el
	 *            要换innerHTML的元素
	 * @param {Object}
	 *            values 应用到模版上的参数值. (比如. {foo: 'bar'})
	 * @param {Boolean}
	 *            returnElement (optional)
	 *            true表示返回值是个L5.Element对象false表示返回的是HTMLElement对象 (默认是
	 *            undefined)
	 * @return {HTMLElement/L5.Element} 新节点或是新的L5.Element对象
	 */
	overwrite : function(el, values, returnElement) {
		el = L5.getDom(el);
		el.innerHTML = this.applyTemplate(values);
		return returnElement ? L5.get(el.firstChild, true) : el.firstChild;
	}
};
/**
 * 应用指定参数值生成HTML片段
 * 
 * @param {Object}
 *            values 应用到模版上的参数值. (比如. {foo: 'bar'})
 * 
 * @return {String} HTML片段
 */
L5.Template.prototype.apply = L5.Template.prototype.applyTemplate;

/**
 * 根据一个HTMLElement对象的value属性(主要指textarea的value属性)或者innerHTML属性创建一个模版。
 * 
 * @param {String/HTMLElement}
 *            el 一个HTMLElement对象或它的id
 * @param {Object}
 *            config 模版配置对象
 * @return {L5.Template} 新建的模版对象
 * 
 * @static
 */
L5.Template.from = function(el, config) {
	el = L5.getDom(el);
	return new L5.Template(el.value || el.innerHTML, config || '');
};

// 向后兼容
L5.DomHelper.Template = L5.Template;