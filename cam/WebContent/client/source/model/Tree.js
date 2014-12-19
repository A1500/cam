/**
 * 树的数据结构，节点的事件处理
 * @class L5.model.Tree
 * @extends L5.util.Observable
 * @constructor
 * 创建树对象
 * @param {L5.model.Node} root (可选) root节点
 */
L5.model.Tree = function(root) {
	this.nodeHash = {};
	/**
	 * 树的根节点
	 * @property root
	 * @type L5.model.Node
	 */
	this.root = null;
	if (root) {
		this.setRootNode(root);
	}
	this.addEvents(
			/**
			 * @event append
			 * 给树增加新的子节点时触发
			 * @param {L5.model.Tree} tree tree对象
			 * @param {L5.model.Node} parent 父节点
			 * @param {L5.model.Node} node 新增的节点
			 * @param {Number} index 新增节点的索引
			 */
			"append",
			/**
			 * @event remove
			 * 移除树的节点时触发
			 * @param {L5.model.Tree} tree tree对象
			 * @param {L5.model.Node} parent 父节点
			 * @param {L5.model.Node} node 要移除的节点
			 */
			"remove",
			/**
			 * @event move
			 * 移动树的节点时触发
			 * @param {L5.model.Tree} tree tree对象
			 * @param {L5.model.Node} node 移动的节点
			 * @param {L5.model.Node} oldParent 移动节点的原父节点
			 * @param {L5.model.Node} newParent 移动节点新的父节点
			 * @param {Number} index 移动节点新位置的索引
			 */
			"move",
			/**
			 * @event insert
			 * 给树的节点插入子节点时触发
			 * @param {L5.model.Tree} tree tree对象
			 * @param {L5.model.Node} parent 父节点
			 * @param {L5.model.Node} node 插入的子节点
			 * @param {L5.model.Node} refNode 插入前子节点的引用
			 */
			"insert",
			/**
			 * @event beforeappend
			 * 给树的某个节点添加子节点之前触发，如果返回false，取消添加。
			 * @param {L5.model.Tree} tree tree对象
			 * @param {L5.model.Node} parent 父节点
			 * @param {L5.model.Node} node 要添加的子节点
			 */
			"beforeappend",
			/**
			 * @event beforeremove
			 * 移除子节点之前触发，取消移除返回false
			 * @param {L5.model.Tree} tree tree对象
			 * @param {L5.model.Node} parent 父节点
			 * @param {L5.model.Node} node 要移除的子节点
			 */
			"beforeremove",
			/**
			 * @event beforemove
			 * 移动节点时触发，取消移动返回false
			 * @param {L5.model.Tree} tree tree对象
			 * @param {L5.model.Node} node 移动的节点
			 * @param {L5.model.Node} oldParent 父节点
			 * @param {L5.model.Node} newParent 移动后的父节点
			 * @param {Number} index 移动后的索引
			 */
			"beforemove",
			/**
			 * @event beforeinsert
			 * 插入子节点之前触发，取消插入操作返回false
			 * @param {L5.model.Tree} tree tree对象
			 * @param {L5.model.Node} parent 父节点
			 * @param {L5.model.Node} node 要插入的子节点
			 * @param {L5.model.Node} refNode 插入之前子节点
			 */
			"beforeinsert");

	L5.model.Tree.superclass.constructor.call(this);
};

L5.extend(L5.model.Tree, L5.util.Observable, {
			/**
			 * @cfg {String} pathSeparator node的id之间分隔符，默认值'/'
			 */
			pathSeparator : "/",

			/**
			 * 触发节点事件
			 * @method proxyNodeEvent
			 * @private
			 * @return {Boolean} 事件执行的结果
			 */
			proxyNodeEvent : function() {
				return this.fireEvent.apply(this, arguments);
			},

			/**
			 * 返回树的根节点
			 * @method getRootNode
			 * @return {L5.model.Node} 根节点
			 */
			getRootNode : function() {
				return this.root;
			},

			/**
			 * 跟树设置根节点
			 * @method setRootNode
			 * @param {L5.model.Node} node 根节点
			 * @return {L5.model.Node} 根节点
			 */
			setRootNode : function(node) {
				this.root = node;
				node.ownerTree = this;
				node.isRoot = true;
				this.registerNode(node);
				return node;
			},

			/**
			 * 根据id获取树的节点对象
			 * @method getNodeById
			 * @param {String} id 节点id
			 * @return {L5.model.Node} 节点
			 */
			getNodeById : function(id) {
				return this.nodeHash[id];
			},

			/**
			 * 向树中注册一个节点
			 * @method registerNode
			 * @private
			 * @param {L5.model.Node} node 节点对象
			 */
			registerNode : function(node) {
				this.nodeHash[node.id] = node;
			},

			/**
			 * 从树中注销一个节点
			 * @method unregisterNode
			 * @private
			 * @param {L5.model.Node} node 节点对象
			 */
			unregisterNode : function(node) {
				delete this.nodeHash[node.id];
			},
			/**
		     * 获取树Tree的字符串描述信息
		     * @method toString
		     * @return {String} 树Tree的字符串描述信息
		     */
			toString : function() {
				return "[Tree" + (this.id ? " " + this.id : "") + "]";
			}
		});

/**
 * 树的节点对象类
 * @class L5.model.Node
 * @extends L5.util.Observable
 * @cfg {Boolean} leaf 是否是叶子节点
 * @cfg {String} id 节点的id，如果没有指定，默认生成
 * @constructor
 * @param {Object} attributes 节点的属性集
 */
L5.model.Node = function(attributes) {
	/**
	 * 节点属性集
	 * @property attributes
	 * @type {Object}
	 */
	this.attributes = attributes || {};
	this.leaf = this.attributes.leaf;
	/**
	 * 节点id
	 * @property id
	 * @type String
	 */
	this.id = this.attributes.id;
	if (!this.id) {
		this.id = L5.id(null, "ynode-");
		this.attributes.id = this.id;
	}
	/**
	 * 节点的子节点集
	 * @property childNodes
	 * @type Array
	 */
	this.childNodes = [];
	if (!this.childNodes.indexOf) { // indexOf is a must
		this.childNodes.indexOf = function(o) {
			for (var i = 0, len = this.length; i < len; i++) {
				if (this[i] == o)
					return i;
			}
			return -1;
		};
	}
	/**
	 * 父节点
	 * @property parentNode
	 * @type L5.model.Node
	 */
	this.parentNode = null;
	/**
	 * 第一个子节点，没有为null
	 * @property firstChild 
	 * @type L5.model.Node
	 */
	this.firstChild = null;
	/**
	 * 最后一个子节点，没有子节点为null
	 * @property lastChild
	 * @type L5.model.Node
	 */
	this.lastChild = null;
	/**
	 * 前一个兄弟节点，没有为null
	 * @property previousSibling
	 * @type L5.model.Node
	 */
	this.previousSibling = null;
	/**
	 * 后一个兄弟节点，没有为null
	 * @property nextSibling
	 * @type L5.model.Node
	 */
	this.nextSibling = null;

	this.addEvents({
				/**
				 * @event append
				 * 增加新的子节点时触发
				 * @param {L5.model.Tree} tree 所属树对象
				 * @param {L5.model.Node} this 当前节点
				 * @param {L5.model.Node} node 新增加的节点
				 * @param {Number} index 新增加节点的索引
				 */
				"append" : true,
				/**
				 * @event remove
				 * 移除子节点时触发
				 * @param {L5.model.Tree} tree 所属树对象
				 * @param {L5.model.Node} this 当前节点
				 * @param {L5.model.Node} node 要移动的节点
				 */
				"remove" : true,
				/**
				 * @event move
				 * 移动到新位置时触发
				 * @param {L5.model.Tree} tree 所属树对象
				 * @param {L5.model.Node} this 当前节点
				 * @param {L5.model.Node} oldParent 原来的父节点
				 * @param {L5.model.Node} newParent 新的父节点
				 * @param {Number} index 移动后的索引
				 */
				"move" : true,
				/**
				 * @event insert
				 * 增加新的子节点时触发
				 * @param {L5.model.Tree} tree 所属树对象
				 * @param {L5.model.Node} this 当前节点
				 * @param {L5.model.Node} node 要插入的子节点
				 * @param {L5.model.Node} refNode 插入之前的子节点
				 */
				"insert" : true,
				/**
				 * @event beforeappend
				 * 增加新的子节点时触发，取消操作返回false
				 * @param {L5.model.Tree} tree 所属树对象
				 * @param {L5.model.Node} this 当前节点
				 * @param {L5.model.Node} node 要添加的子节点
				 */
				"beforeappend" : true,
				/**
				 * @event beforeremove
				 * 子节点移除之前触发，取消操作返回false
				 * @param {L5.model.Tree} tree 所属树对象
				 * @param {L5.model.Node} this 当前节点
				 * @param {L5.model.Node} node 要移除的子节点
				 */
				"beforeremove" : true,
				/**
				 * @event beforemove
				 * 在节点移动到新位置之前触发，取消移动返回false
				 * @param {L5.model.Tree} tree 所属树对象
				 * @param {L5.model.Node} this 当前节点
				 * @param {L5.model.Node} oldParent 父节点
				 * @param {L5.model.Node} newParent 新的父节点
				 * @param {Number} index 节点移动后的索引
				 */
				"beforemove" : true,
				/**
				 * @event beforeinsert
				 * 插入新的子节点前触发，取消操作返回false
				 * @param {L5.model.Tree} tree 所属树对象
				 * @param {L5.model.Node} this 当前节点
				 * @param {L5.model.Node} node 要插入的子节点
				 * @param {L5.model.Node} refNode 插入之前的节点
				 */
				"beforeinsert" : true
			});
	this.listeners = this.attributes.listeners;
	L5.model.Node.superclass.constructor.call(this);
};

L5.extend(L5.model.Node, L5.util.Observable, {
	/**
	 * 触发事件
	 * @method fireEvent
	 * @private
	 * @param {String} evtName 事件名称
	 * @return {Boolean} 事件执行的结果
	 */
	fireEvent : function(evtName) {
		// first do standard event for this node
		if (L5.model.Node.superclass.fireEvent.apply(this, arguments) === false) {
			return false;
		}
		// then bubble it up to the tree if the event wasn't cancelled
		var ot = this.getOwnerTree();
		if (ot) {
			if (ot.proxyNodeEvent.apply(ot, arguments) === false) {
				return false;
			}
		}
		return true;
	},

	/**
	 * 判断节点是否是叶子节点
	 * @method isLeaf
	 * @return {Boolean} true或者false
	 */
	isLeaf : function() {
		return this.leaf === true;
	},

	/**
	 * 设置第一个子节点
	 * @method setFirstChild
	 * @private
	 * @param {L5.model.Node} node 节点
	 */
	setFirstChild : function(node) {
		this.firstChild = node;
	},

	/**
	 * 设置最后一个子节点
	 * @method setLastChild
	 * @private
	 * @param {L5.model.Node} node 节点
	 */
	setLastChild : function(node) {
		this.lastChild = node;
	},

	/**
	 * 是否是父节点的最后一个子节点
	 * @method isLast
	 * @return {Boolean} true或者false
	 */
	isLast : function() {
		return (!this.parentNode ? true : this.parentNode.lastChild == this);
	},

	/**
	 * 是否是父节点的第一个子节点
	 * @method isFirst
	 * @return {Boolean} true或者false
	 */
	isFirst : function() {
		return (!this.parentNode ? true : this.parentNode.firstChild == this);
	},

	/**
	 * 判断节点是否包含子节点
	 * @method hasChildNodes
	 * @return {Boolean} true或者false
	 */
	hasChildNodes : function() {
		return !this.isLeaf() && this.childNodes.length > 0;
	},

	/**
	 * 如果节点有子节点返回true，或者expandable节点属性被显式指定为true，否则返回false
	 * @method isExpandable
	 * @return {Boolean} true或者false
	 */
	isExpandable : function() {
		return this.attributes.expandable || this.hasChildNodes();
	},

	/**
	 * 作为节点的最后一个子节点插入
	 * @method appendChild
	 * @param {L5.model.Node/Array} node 要插入的节点或者节点对象数组
	 * @return {L5.model.Node} 如果是插入一个节点，返回该节点，如果是插入数据节点返回null
	 */
	appendChild : function(node) {
		var multi = false;
		if (L5.isArray(node)) {
			multi = node;
		} else if (arguments.length > 1) {
			multi = arguments;
		}
		// if passed an array or multiple args do them one by one
		if (multi) {
			for (var i = 0, len = multi.length; i < len; i++) {
				this.appendChild(multi[i]);
			}
		} else {
			if (this.fireEvent("beforeappend", this.ownerTree, this, node) === false) {
				return false;
			}
			var index = this.childNodes.length;
			var oldParent = node.parentNode;
			// it's a move, make sure we move it cleanly
			if (oldParent) {
				if (node.fireEvent("beforemove", node.getOwnerTree(), node,
						oldParent, this, index) === false) {
					return false;
				}
				oldParent.removeChild(node);
			}
			index = this.childNodes.length;
			if (index == 0) {
				this.setFirstChild(node);
			}
			this.childNodes.push(node);
			node.parentNode = this;
			var ps = this.childNodes[index - 1];
			if (ps) {
				node.previousSibling = ps;
				ps.nextSibling = node;
			} else {
				node.previousSibling = null;
			}
			node.nextSibling = null;
			this.setLastChild(node);
			node.setOwnerTree(this.getOwnerTree());
			this.fireEvent("append", this.ownerTree, this, node, index);
			if (oldParent) {
				node.fireEvent("move", this.ownerTree, node, oldParent, this,
						index);
			}
			return node;
		}
	},

	/**
	 * 移除子节点
	 * @method removeChild
	 * @param {L5.model.Node} node 要移除的节点
	 * @return {L5.model.Node} 移除的节点
	 */
	removeChild : function(node) {
		var index = this.childNodes.indexOf(node);
		if (index == -1) {
			return false;
		}
		if (this.fireEvent("beforeremove", this.ownerTree, this, node) === false) {
			return false;
		}

		// remove it from childNodes collection
		this.childNodes.splice(index, 1);

		// update siblings
		if (node.previousSibling) {
			node.previousSibling.nextSibling = node.nextSibling;
		}
		if (node.nextSibling) {
			node.nextSibling.previousSibling = node.previousSibling;
		}

		// update child refs
		if (this.firstChild == node) {
			this.setFirstChild(node.nextSibling);
		}
		if (this.lastChild == node) {
			this.setLastChild(node.previousSibling);
		}

		node.setOwnerTree(null);
		// clear any references from the node
		node.parentNode = null;
		node.previousSibling = null;
		node.nextSibling = null;
		this.fireEvent("remove", this.ownerTree, this, node);
		return node;
	},

	/**
	 * 在参考节点refNode之前插入node节点
	 * @method insertBefore
	 * @param {L5.model.Node} node 要插入的节点
	 * @param {L5.model.Node} refNode 参考节点
	 * @return {L5.model.Node} 插入的节点
	 */
	insertBefore : function(node, refNode) {
		if (!refNode) { // like standard Dom, refNode can be null for append
			return this.appendChild(node);
		}
		// nothing to do
		if (node == refNode) {
			return false;
		}

		if (this.fireEvent("beforeinsert", this.ownerTree, this, node, refNode) === false) {
			return false;
		}
		var index = this.childNodes.indexOf(refNode);
		var oldParent = node.parentNode;
		var refIndex = index;

		// when moving internally, indexes will change after remove
		if (oldParent == this && this.childNodes.indexOf(node) < index) {
			refIndex--;
		}

		// it's a move, make sure we move it cleanly
		if (oldParent) {
			if (node.fireEvent("beforemove", node.getOwnerTree(), node,
					oldParent, this, index, refNode) === false) {
				return false;
			}
			oldParent.removeChild(node);
		}
		if (refIndex == 0) {
			this.setFirstChild(node);
		}
		this.childNodes.splice(refIndex, 0, node);
		node.parentNode = this;
		var ps = this.childNodes[refIndex - 1];
		if (ps) {
			node.previousSibling = ps;
			ps.nextSibling = node;
		} else {
			node.previousSibling = null;
		}
		node.nextSibling = refNode;
		refNode.previousSibling = node;
		node.setOwnerTree(this.getOwnerTree());
		this.fireEvent("insert", this.ownerTree, this, node, refNode);
		if (oldParent) {
			node.fireEvent("move", this.ownerTree, node, oldParent, this,
					refIndex, refNode);
		}
		return node;
	},

	/**
	 * 从父节点中移除当前节点
	 * @method remove
	 * @return {L5.model.Node} 被移除的当前节点
	 */
	remove : function() {
		this.parentNode.removeChild(this);
		return this;
	},

	/**
	 * 根据指定的索引返回子节点
	 * @method item
	 * @param {Number} index 索引
	 * @return {L5.model.Node} 节点对象
	 */
	item : function(index) {
		return this.childNodes[index];
	},

	/**
	 * 用newchild替换oldchild子节点
	 * @method replaceChild
	 * @param {L5.model.Node} newChild 替换的新节点
	 * @param {L5.model.Node} oldChild 要替换的节点
	 * @return {L5.model.Node} 替换的节点
	 */
	replaceChild : function(newChild, oldChild) {
		var s = oldChild ? oldChild.nextSibling : null;
		this.removeChild(oldChild);
		this.insertBefore(newChild, s);
		return oldChild;
	},

	/**
	 * 子节点的索引
	 * @method indexOf
	 * @param {L5.model.Node} node 子节点对象
	 * @return {Number} 节点的索引，没有找到返回-1
	 */
	indexOf : function(child) {
		return this.childNodes.indexOf(child);
	},

	/**
	 * 返回节点所属的树
	 * @method getOwnerTree
	 * @return {L5.model.Tree} 树对象
	 */
	getOwnerTree : function() {
		// if it doesn't have one, look for one
		if (!this.ownerTree) {
			var p = this;
			while (p) {
				if (p.ownerTree) {
					this.ownerTree = p.ownerTree;
					break;
				}
				p = p.parentNode;
			}
		}
		return this.ownerTree;
	},

	/**
	 * 得到当前节点深度,根节点深度为0
	 * @method getDepth
	 * @return {Number} 节点深度
	 */
	getDepth : function() {
		var depth = 0;
		var p = this;
		while (p.parentNode) {
			++depth;
			p = p.parentNode;
		}
		return depth;
	},

	/**
	 * 设置节点所属的树
	 * @method setOwnerTree
	 * @private
	 * @param {L5.model.Tree} 树对象
	 */
	setOwnerTree : function(tree) {
		// if it's move, we need to update everyone
		if (tree != this.ownerTree) {
			if (this.ownerTree) {
				this.ownerTree.unregisterNode(this);
			}
			this.ownerTree = tree;
			var cs = this.childNodes;
			for (var i = 0, len = cs.length; i < len; i++) {
				cs[i].setOwnerTree(tree);
			}
			if (tree) {
				tree.registerNode(this);
			}
		}
	},

	/**
	 * 得到当前节点的路径
	 * @method getPath
	 * @param {String} attr (可选)节点的属性(默认值id)
	 * @return {String} 路径
	 */
	getPath : function(attr) {
		attr = attr || "id";
		var p = this.parentNode;
		var b = [this.attributes[attr]];
		while (p) {
			b.unshift(p.attributes[attr]);
			p = p.parentNode;
		}
		var sep = this.getOwnerTree().pathSeparator;
		return sep + b.join(sep);
	},

	/**
	 * 由当前节点开始一直上溯到根节点,对于每个节点应用fn,直到有一个fn返回false为止
	 * @method bubble
	 * @param {Function} fn 调用的函数
	 * @param {Object} scope (可选)函数的作用域 (默认值当前节点)
	 * @param {Array} args (可选) 调用函数的参数(默认参数是当前节点)
	 */
	bubble : function(fn, scope, args) {
		var p = this;
		while (p) {
			if (fn.apply(scope || p, args || [p]) === false) {
				break;
			}
			p = p.parentNode;
		}
	},

	/**
	 * 由当前节点开始一下对每个子孙节点应用fn.直到返回false为止
	 * @method cascade
	 * @param {Function} fn 调用的函数
	 * @param {Object} scope (可选)函数的作用域 (默认值当前节点)
	 * @param {Array} args (可选) 调用函数的参数(默认参数是当前节点)
	 */
	cascade : function(fn, scope, args) {
		if (fn.apply(scope || this, args || [this]) !== false) {
			var cs = this.childNodes;
			for (var i = 0, len = cs.length; i < len; i++) {
				cs[i].cascade(fn, scope, args);
			}
		}
	},

	/**
	 * 基本同cascade,但只针对子节点应用fn
	 * @method eachChild
	 * @param {Function} fn 调用的函数
	 * @param {Object} scope (可选)函数的作用域 (默认值当前节点)
	 * @param {Array} args (可选) 调用函数的参数(默认参数是当前节点)
	 */
	eachChild : function(fn, scope, args) {
		var cs = this.childNodes;
		for (var i = 0, len = cs.length; i < len; i++) {
			if (fn.apply(scope || this, args || [cs[i]]) === false) {
				break;
			}
		}
	},

	/**
	 * 在子节点中找到第一个有属性attribute值为value的节点
	 * @method findChild
	 * @param {String} attribute 属性名称
	 * @param {Mixed} value 要查找的值
	 * @return {L5.model.Node} 查找的节点，没有找到返回null
	 */
	findChild : function(attribute, value) {
		var cs = this.childNodes;
		for (var i = 0, len = cs.length; i < len; i++) {
			if (cs[i].attributes[attribute] == value) {
				return cs[i];
			}
		}
		return null;
	},

	/**
	 * 在子节点中找到第一个应用fn返回真的节点
	 * @method findChildBy
	 * @param {Function} fn 查找函数
	 * @param {Object} scope (可选)函数作用域
	 * @return {L5.model.Node} 查找的节点，没有找到返回null
	 */
	findChildBy : function(fn, scope) {
		var cs = this.childNodes;
		for (var i = 0, len = cs.length; i < len; i++) {
			if (fn.call(scope || cs[i], cs[i]) === true) {
				return cs[i];
			}
		}
		return null;
	},

	/**
	 * 根据传入的函数给所有的子节点排序
	 * @method sort
	 * @param {Function} fn 排序函数
	 * @param {Object} scope (可选) 作用域
	 */
	sort : function(fn, scope) {
		var cs = this.childNodes;
		var len = cs.length;
		if (len > 0) {
			var sortFn = scope ? function() {
				fn.apply(scope, arguments);
			} : fn;
			cs.sort(sortFn);
			for (var i = 0; i < len; i++) {
				var n = cs[i];
				n.previousSibling = cs[i - 1];
				n.nextSibling = cs[i + 1];
				if (i == 0) {
					this.setFirstChild(n);
				}
				if (i == len - 1) {
					this.setLastChild(n);
				}
			}
		}
	},

	/**
	 * 当前节点是否是node的祖先节点
	 * @method contains
	 * @param {L5.model.Node} node 节点对象
	 * @return {Boolean} true或者false
	 */
	contains : function(node) {
		return node.isAncestor(this);
	},

	/**
	 * 当前节点是否是祖先节点
	 * @method isAncestor
	 * @param {L5.model.Node} node 节点对象
	 * @return {Boolean} true或者false
	 */
	isAncestor : function(node) {
		var p = this.parentNode;
		while (p) {
			if (p == node) {
				return true;
			}
			p = p.parentNode;
		}
		return false;
	},
    /**
     * 获取树节点Node的字符串描述信息
     * @method toString
     * @return {String} 树节点Node的字符串描述信息
     */
	toString : function() {
		return "[Node" + (this.id ? " " + this.id : "") + "]";
	}
});