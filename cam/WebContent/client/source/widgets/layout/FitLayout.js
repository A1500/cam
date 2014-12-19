/**
 * 
 * <p>
 * 所有有"占满"特性的布局的父类；在默认布局的基础上将活动子节点的大小设置为和渲染目标(渲染目标通常是容器组件对应的{@link L5.Element})一样大。
 * 
 * <p>
 * 例如:
 * 
 * 
 * <pre><code>
 * var p = new L5.Panel({
 * 	title : 'Fit Layout',
 * 	layout : 'fit',
 * 	items : {
 * 		title : 'Inner Panel',
 * 		html : '&lt;p&gt;This is the inner panel content&lt;/p&gt;',
 * 		border : false
 * 	}
 * });
 * </code></pre>
 * 
 * @class L5.layout.FitLayout
 * @extends L5.layout.ContainerLayout
 */
L5.layout.FitLayout = L5.extend(L5.layout.ContainerLayout, {
	// private
	monitorResize : true,

	/**
	 * 调用父类的布局方法，然后将活动子组件的大小设置成占满目标元素。
	 * 
	 * @param {L5.Container}
	 *            ct 对应的容器组件
	 * @param {L5.Element}
	 *            target 指定：渲染到哪个元素里
	 * @public
	 * 
	 * @override
	 */
	onLayout : function(ct, target) {
		L5.layout.FitLayout.superclass.onLayout.call(this, ct, target);
		if (!this.container.collapsed) {
			this.setItemSize(this.activeItem || ct.items.itemAt(0), target
					.getStyleSize());
		}
	},

	/**
	 * 设置子组件大小
	 * 
	 * @param {L5.Component}
	 *            item 子组件
	 * @param {Object}
	 *            size {width:width-value,height:height-value}
	 * @private
	 */
	setItemSize : function(item, size) {
		if (item && size.height > 0) { // display none?
			item.setSize(size);
		}
	}
});

L5.Container.LAYOUTS['fit'] = L5.layout.FitLayout;