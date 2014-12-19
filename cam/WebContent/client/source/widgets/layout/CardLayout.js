/**
 * 
 * <p>
 * 选项卡布局，只有一个子组件出于活动的、可见的状态；选项卡组件使用该布局方式。
 * 
 * 例如:
 * 
 * var card = new L5.Panel({
 * 	title : 'Example Wizard',
 * 	layout : 'card',
 * 	activeItem : 0, // make sure the active item is set on the container config!
 * 	bodyStyle : 'padding:15px',
 * 	defaults : {
 * 		// applied to each contained panel
 * 		border : false
 * 	},
 * 	// just an example of one possible navigation scheme, using buttons
 * 	bbar : [ {
 * 		id : 'move-prev',
 * 		text : 'Back',
 * 		handler : navHandler.createDelegate(this, [ -1 ]),
 * 		disabled : true
 * 	}, '-&gt;', // greedy spacer so that the buttons are aligned to each side
 * 	{
 * 		id : 'move-next',
 * 		text : 'Next',
 * 		handler : navHandler.createDelegate(this, [ 1 ])
 * 	} ],
 * 	// the panels (or &quot;cards&quot;) within the layout
 * 	items : [ {
 * 		id : 'card-0',
 * 		html : '&lt;h1&gt;Welcome to the Wizard!&lt;/h1&gt;&lt;p&gt;Step 1 of 3&lt;/p&gt;'
 * 	}, {
 * 		id : 'card-1',
 * 		html : '&lt;p&gt;Step 2 of 3&lt;/p&gt;'
 * 	}, {
 * 		id : 'card-2',
 * 		html : '&lt;h1&gt;Congratulations!&lt;/h1&gt;&lt;p&gt;Step 3 of 3 - Complete&lt;/p&gt;'
 * 	} ]
 * });
 * </code></pre> *
 * 
 * @class L5.layout.CardLayout
 * @extends L5.layout.FitLayout
 */
L5.layout.CardLayout = L5.extend(L5.layout.FitLayout, {
	/**
	 * @cfg {Boolean} deferredRender 延迟渲染：在子组件称为活动状态时才渲染，默认是false.
	 */
	deferredRender : false,

	/**
	 * 设置了这个属性，子组件渲染完后都会隐藏(hide)--通过setActiveItem方法把活动子组件show出来
	 */
	renderHidden : true,

	/**
	 * 设置一个活动的(可见的)子组件.
	 * 
	 * @param {String/Number}
	 *            item 子组件id或者所在顺序
	 */
	setActiveItem : function(item) {
		item = this.container.getComponent(item);
		if (this.activeItem != item) {
			if (this.activeItem) {
				this.activeItem.hide();
			}
			this.activeItem = item;
			item.show();
			this.layout();
		}
	},

	/**
	 * 渲染所有子组件，或者需要做延迟渲染只渲染活动子组件
	 * 
	 * @param {L5.Component}
	 *            ct
	 * @param {L5.Element}
	 *            target
	 * @override
	 * @private
	 */
	renderAll : function(ct, target) {
		if (this.deferredRender) {
			this.renderItem(this.activeItem, undefined, target);
		} else {
			L5.layout.CardLayout.superclass.renderAll.call(this, ct, target);
		}
	}
});
L5.Container.LAYOUTS['card'] = L5.layout.CardLayout;