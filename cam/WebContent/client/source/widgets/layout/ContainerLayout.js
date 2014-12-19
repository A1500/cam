/**
 * <p>
 * 容器 {@link L5.Container} 把子组件 {@link L5.Component}的渲染交给布局管理器来处理，通过设置容器对象的layout属性来设置容器使用哪种布局方式;
 * <p>
 * ContainerLayout是默认布局方式；同时是其它布局方式的父类，提供基本布局功能；只是简单地渲染子组件;
 * 
 * @class L5.layout.ContainerLayout
 */
L5.layout.ContainerLayout = function(config) {
	L5.apply(this, config);
};

L5.layout.ContainerLayout.prototype = {
	/**
	 * @cfg {String} extraCls An optional extra CSS class that will be added to
	 *      the container (defaults to ''). This can be useful for adding
	 *      customized styles to the container or any of its children using
	 *      standard CSS rules.
	 */

	/**
	 * @cfg {Boolean} renderHidden 设置了这个属性，子组件渲染完后都会隐藏(hide) (defaults to
	 *      false).
	 */

	/**
	 * 是否监听容器组件的resize事件
	 */
	monitorResize : true,

	/**
	 * @type {L5.Component} 活动子组件
	 */
	activeItem : null,

	/**
	 * 执行布局，会在{@link L5.Container}里调用这个方法
	 */
	layout : function() {
		var target = this.container.getLayoutTarget();
		this.onLayout(this.container, target);
		this.container.fireEvent('afterlayout', this.container, this);
	},

	/**
	 * 执行实际的布局工作
	 * 
	 * @param {L5.Container}
	 *            ct 对应的容器组件
	 * @param {L5.Element}
	 *            target 指定：渲染到哪个元素里
	 * @public
	 */
	onLayout : function(ct, target) {
		this.renderAll(ct, target);
		var items = ct.items.items;
		for ( var i = 0, len = items.length; i < len; i++) {
			var c = items[i];
			if (c.onWinResize) {
				c.onWinResize();
			}
		}
	},

	/**
	 * 
	 */
	isValidParent : function(c, target) {
		var el = c.getPositionEl ? c.getPositionEl() : c.getEl();
		return el.dom.parentNode == target.dom;
	},

	/**
	 * 简单的渲染所有子组件
	 * 
	 * @param {L5.Container}
	 *            ct 对应的容器组件
	 * @param {L5.Element}
	 *            target 指定：渲染到哪个元素里
	 */
	renderAll : function(ct, target) {
		var items = ct.items.items;
		for ( var i = 0, len = items.length; i < len; i++) {
			var c = items[i];
			if (c && (!c.rendered || !this.isValidParent(c, target))) {
				this.renderItem(c, i, target);
			}
		}
	},

	/**
	 * 渲染某个子组件
	 * 
	 * @param {L5.Component}
	 *            c 要渲染的子组件
	 * @param {Number}
	 *            position 子组件的位置：顺序号
	 * @param {L5.Element}
	 *            target 指定：渲染到哪个元素里
	 */
	renderItem : function(c, position, target) {
		if (c && !c.rendered) {
			c.render(target, position);
			if (this.extraCls) {
				var t = c.getPositionEl ? c.getPositionEl() : c;
				t.addClass(this.extraCls);
			}
			if (this.renderHidden && c != this.activeItem) {
				c.hide();
			}
		} else if (c && !this.isValidParent(c, target)) {
			if (this.extraCls) {
				var t = c.getPositionEl ? c.getPositionEl() : c;
				t.addClass(this.extraCls);
			}
			if (typeof position == 'number') {
				position = target.dom.childNodes[position];
			}
			target.dom.insertBefore(c.getEl().dom, position || null);
			if (this.renderHidden && c != this.activeItem) {
				c.hide();
			}
		}
	},

	/**
	 * 当容器组件发出resize事件时会调用这个方法，比如浏览器最大最小化、由于菜单栏或工具栏收缩引起部分窗口大小变化。
	 * 
	 * @private
	 */
	onResize : function() {
		if (this.container.collapsed) {
			return;
		}
		var b = this.container.bufferResize;
		if (b) {
			if (!this.resizeTask) {
				this.resizeTask = new L5.util.DelayedTask(this.layout, this);
				this.resizeBuffer = typeof b == 'number' ? b : 100;
			}
			this.resizeTask.delay(this.resizeBuffer);
		} else {
			this.layout();
		}
	},

	/**
	 * 设置对应的容器组件，会在{@link L5.Container}里调用这个方法
	 * 
	 * @param {L5.Container}
	 *            ct
	 * @public
	 */
	setContainer : function(ct) {
		if (this.monitorResize && ct != this.container) {
			if (this.container) {
				this.container.un('resize', this.onResize, this);
			}
			if (ct) {
				ct.on('resize', this.onResize, this);
			}
		}
		this.container = ct;
	},

	// private
	parseMargins : function(v) {
		var ms = v.split(' ');
		var len = ms.length;
		if (len == 1) {
			ms[1] = ms[0];
			ms[2] = ms[0];
			ms[3] = ms[0];
		}
		if (len == 2) {
			ms[2] = ms[0];
			ms[3] = ms[1];
		}
		return {
			top : parseInt(ms[0], 10) || 0,
			right : parseInt(ms[1], 10) || 0,
			bottom : parseInt(ms[2], 10) || 0,
			left : parseInt(ms[3], 10) || 0
		};
	},

	/*
	 * Destroys this layout. This is a template method that is empty by default,
	 * but should be implemented by subclasses that require explicit destruction
	 * to purge event handlers or remove DOM nodes. @protected
	 */
	destroy : L5.emptyFn
};

L5.Container.LAYOUTS['auto'] = L5.layout.ContainerLayout;