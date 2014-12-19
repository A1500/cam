//doc
/**
 * @class L5.Viewport
 * @extends L5.Container
 */
// * A specialized container representing the viewable application area (the browser viewport).
// * <p> The Viewport renders itself to the document body, and automatically sizes itself to the size of
// * the browser viewport and manages window resizing. There may only be one Viewport created
// * in a page. Inner layouts are available by virtue of the fact that all {@link L5.Panel Panel}s
// * added to the Viewport, either through its {@link #items}, or through the items, or the {@link #add}
// * method of any of its child Panels may themselves have a layout.</p>
// * <p>The Viewport does not provide scrolling, so child Panels within the Viewport should provide
// * for scrolling if needed using the {@link #autoScroll} config.</p>
// * Example showing a classic application border layout :<pre><code>
//new L5.Viewport({
//    layout: 'border',
//    items: [{
//        region: 'north',
//        html: '&lt;h1 class="l-panel-header">Page Title&lt;/h1>',
//        autoHeight: true,
//        border: false,
//        margins: '0 0 5 0'
//    }, {
//        region: 'west',
//        collapsible: true,
//        title: 'Navigation',
//        xtype: 'treepanel',
//        width: 200,
//        autoScroll: true,
//        split: true,
//        loader: new L5.tree.TreeLoader(),
//        root: new L5.tree.AsyncTreeNode({
//            expanded: true,
//            children: [{
//                text: 'Menu Option 1',
//                leaf: true
//            }, {
//                text: 'Menu Option 2',
//                leaf: true
//            }, {
//                text: 'Menu Option 3',
//                leaf: true
//            }]
//        }),
//        rootVisible: false,
//        listeners: {
//            click: function(n) {
//                L5.Msg.alert('Navigation Tree Click', 'You clicked: "' + n.attributes.text + '"');
//            }
//        }
//    }, {
//        region: 'center',
//        xtype: 'tabpanel',
//        items: {
//            title: 'Default Tab',
//            html: 'The first tab\'s content. Others may be added dynamically'
//        }
//    }, {
//        region: 'south',
//        title: 'Information',
//        collapsible: true,
//        html: 'Information goes here',
//        split: true,
//        height: 100,
//        minHeight: 100
//    }]
//});
//</code></pre>
// * @constructor
// * Create a new Viewport
// * @param {Object} config The config object
// */
L5.Viewport = L5.extend(L5.Container, {
	/*
	 * Privatize config options which, if used, would interfere with the
	 * correct operation of the Viewport as the sole manager of the
	 * layout of the document body.
	 */
    /**
     * @cfg {Mixed} applyTo @hide
	 */
    /**
     * @cfg {Boolean} allowDomMove @hide
	 */
    /**
     * @cfg {Boolean} hideParent @hide
	 */
    /**
     * @cfg {Mixed} renderTo @hide
	 */
    /**
     * @cfg {Boolean} hideParent @hide
	 */
    /**
     * @cfg {Number} height @hide
	 */
    /**
     * @cfg {Number} width @hide
	 */
    /**
     * @cfg {Boolean} autoHeight @hide
	 */
    /**
     * @cfg {Boolean} autoWidth @hide
	 */
    /**
     * @cfg {Boolean} deferHeight @hide
	 */
    /**
     * @cfg {Boolean} monitorResize @hide
	 */
    initComponent : function() {
        L5.Viewport.superclass.initComponent.call(this);
        document.getElementsByTagName('html')[0].className += ' l-viewport';
        this.el = L5.getBody();
        this.el.setHeight = L5.emptyFn;
        this.el.setWidth = L5.emptyFn;
        this.el.setSize = L5.emptyFn;
        this.el.dom.scroll = 'no';
        this.allowDomMove = false;
        this.autoWidth = true;
        this.autoHeight = true;
        L5.EventManager.onWindowResize(this.fireResize, this);
        this.renderTo = this.el;
    },

    fireResize : function(w, h){
        this.fireEvent('resize', this, w, h, w, h);
    }
});
L5.reg('viewport', L5.Viewport);