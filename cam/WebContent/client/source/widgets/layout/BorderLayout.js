/**

 * <p>This is a multi-pane, application-oriented UI layout style that supports multiple nested panels, automatic
 * split bars between regions and built-in expanding and collapsing of regions.
 * This class is intended to be extended or created via the layout:'border' {@link L5.Container#layout} config,
 * and should generally not need to be created directly via the new keyword.</p>
 * <p>BorderLayout does not have any direct config options (other than inherited ones).  All configs available
 * for customizing the BorderLayout are at the {@link L5.layout.BorderLayout.Region} and
 * {@link L5.layout.BorderLayout.SplitRegion} levels.</p>
 * <p><b>The regions of a BorderLayout are fixed at render time and thereafter, no regions may be removed or
 * added. The BorderLayout must have a center region, which will always fill the remaining space not used by
 * the other regions in the layout.</b></p>
 * <p>Example usage:</p>
 * <pre><code>
var border = new L5.Panel({
    title: 'Border Layout',
    layout:'border',
    items: [{
        title: 'South Panel',
        region: 'south',
        height: 100,
        minSize: 75,
        maxSize: 250,
        margins: '0 5 5 5'
    },{
        title: 'West Panel',
        region:'west',
        margins: '5 0 0 5',
        cmargins: '5 5 0 5',
        width: 200,
        minSize: 100,
        maxSize: 300
    },{
        title: 'Main Content',
        region:'center',
        margins: '5 5 0 0'
    }]
});
</code></pre>
 * @class L5.layout.BorderLayout
 * @extends L5.layout.ContainerLayout
 */
L5.layout.BorderLayout = L5.extend(L5.layout.ContainerLayout, {
    // private
    monitorResize:true,
    // private
    rendered : false,

    // private
    onLayout : function(ct, target){
        var collapsed;
        if(!this.rendered){
            target.position();
            target.addClass('l-border-layout-ct');
            var items = ct.items.items;
            collapsed = [];
            for(var i = 0, len = items.length; i < len; i++) {
                var c = items[i];
                var pos = c.region;
                if(c.collapsed){
                    collapsed.push(c);
                }
                c.collapsed = false;
                if(!c.rendered){
                    c.cls = c.cls ? c.cls +' l-border-panel' : 'l-border-panel';
                    c.render(target, i);
                }
                this[pos] = pos != 'center' && c.split ?
                    new L5.layout.BorderLayout.SplitRegion(this, c.initialConfig, pos) :
                    new L5.layout.BorderLayout.Region(this, c.initialConfig, pos);
                this[pos].render(target, c);  
                
                if(c.onWinResize)
                	L5.EventManager.removeResizeListener(c.onWinResize, c);//不让这些子组件监听了，由布局管理器直接调用
            }
            this.rendered = true;
        }

        var size = target.getViewSize();
        if(size.width < 20 || size.height < 20){ // display none?
            if(collapsed){
                this.restoreCollapsed = collapsed;
            }
            return;
        }else if(this.restoreCollapsed){
            collapsed = this.restoreCollapsed;
            delete this.restoreCollapsed;
        }

        var w = size.width, h = size.height;
        var centerW = w, centerH = h, centerY = 0, centerX = 0;

        var n = this.north, s = this.south, west = this.west, e = this.east, c = this.center;
        if(!c && L5.layout.BorderLayout.WARN !== false){
            throw 'No center region defined in BorderLayout ' + ct.id;
        }
        
        if(n && n.isVisible()){
        	n.panel.onWinResize();  
            var b = n.getSize();
            var m = n.getMargins();
            b.width = w - (m.left+m.right);
            b.x = m.left;
            b.y = m.top;
            centerY = b.height + b.y + m.bottom;
            centerH -= centerY;
            n.applyLayout(b);
        }
        if(s && s.isVisible()){
        	s.panel.onWinResize();
            var b = s.getSize();
            var m = s.getMargins();
            b.width = w - (m.left+m.right);
            b.x = m.left;
            var totalHeight = (b.height + m.top + m.bottom);
            b.y = h - totalHeight + m.top;
            centerH -= totalHeight;
            s.applyLayout(b);
        }
        if(west && west.isVisible()){
        	west.panel.onWinResize();
            var b = west.getSize();
            var m = west.getMargins();
            b.height = centerH - (m.top+m.bottom);
            b.x = m.left;
            b.y = centerY + m.top;
            var totalWidth = (b.width + m.left + m.right);
            centerX += totalWidth;
            centerW -= totalWidth;
            west.applyLayout(b);
        }
        if(e && e.isVisible()){
        	e.panel.onWinResize();
            var b = e.getSize();
            var m = e.getMargins();
            b.height = centerH - (m.top+m.bottom);
            var totalWidth = (b.width + m.left + m.right);
            b.x = w - totalWidth + m.left;
            b.y = centerY + m.top;
            centerW -= totalWidth;
            e.applyLayout(b);
        }

        if(c){
        	c.panel.onWinResize();
            var m = c.getMargins();
            var centerBox = {
                x: centerX + m.left,
                y: centerY + m.top,
                width: centerW - (m.left+m.right),
                height: centerH - (m.top+m.bottom)
            };
            c.applyLayout(centerBox);
        }
        if(collapsed){
            for(var i = 0, len = collapsed.length; i < len; i++){
                collapsed[i].collapse(false);
            }
        }

        if(L5.isIE && L5.isStrict){ // workaround IE strict repainting issue
            target.repaint();
        }
    },

    // inherit docs
    destroy: function() {
        var r = ['north', 'south', 'east', 'west'];
        for (var i = 0; i < r.length; i++) {
            var region = this[r[i]];
            if(region){
                if(region.destroy){
	                region.destroy();
	            }else if (region.split){
	                region.split.destroy(true);
	            }
            }
        }
        L5.layout.BorderLayout.superclass.destroy.call(this);
    }
    
    /**
     * @property activeItem
     * @hide
     */
});

/**
 * @class L5.layout.BorderLayout.Region
 * This is a region of a BorderLayout that acts as a subcontainer within the layout.  Each region has its own
 * layout that is independent of other regions and the containing BorderLayout, and can be any of the valid
 * L5 layout types.  Region size is managed automatically and cannot be changed by the user -- for resizable
 * regions, see {@link L5.layout.BorderLayout.SplitRegion}.
 * @constructor
 * Create a new Region.
 * @param {Layout} layout Any valid L5 layout class
 * @param {Object} config The configuration options
 * @param {String} position The region position.  Valid values are: north, south, east, west and center.  Every
 * BorderLayout must have a center region for the primary content -- all other regions are optional.
 */
L5.layout.BorderLayout.Region = function(layout, config, pos){
    L5.apply(this, config);
    this.layout = layout;
    this.position = pos;
    this.state = {};
    if(typeof this.margins == 'string'){
        this.margins = this.layout.parseMargins(this.margins);
    }
    this.margins = L5.applyIf(this.margins || {}, this.defaultMargins);
    if(this.collapsible){
        if(typeof this.cmargins == 'string'){
            this.cmargins = this.layout.parseMargins(this.cmargins);
        }
        if(this.collapseMode == 'mini' && !this.cmargins){
            this.cmargins = {left:0,top:0,right:0,bottom:0};
        }else{
            this.cmargins = L5.applyIf(this.cmargins || {},
                pos == 'north' || pos == 'south' ? this.defaultNSCMargins : this.defaultEWCMargins);
        }
    }
};

L5.layout.BorderLayout.Region.prototype = {
    /**
     * @cfg {Boolean} animFloat
     * When a collapsed region's bar is clicked, the region's panel will be displayed as a floated panel that will
     * close again once the user mouses out of that panel (or clicks out if autoHide = false).  Setting animFloat
     * to false will prevent the open and close of these floated panels from being animated (defaults to true).
     */
    /**
     * @cfg {Boolean} autoHide
     * When a collapsed region's bar is clicked, the region's panel will be displayed as a floated panel.  If
     * autoHide is true, the panel will automatically hide after the user mouses out of the panel.  If autoHide
     * is false, the panel will continue to display until the user clicks outside of the panel (defaults to true).
     */
	/**
	 * @cfg {Boolean} collapsed
	 * By default, collapsible regions will be visible when rendered. Set the collapsed config to true to render
	 * the region as collapsed.
	 */
    /**
     * @cfg {String} collapseMode
     * By default, collapsible regions are collapsed by clicking the expand/collapse tool button that renders into
     * the region's title bar.  Optionally, when collapseMode is set to 'mini' the region's split bar will also
     * display a small collapse button in the center of the bar.  In 'mini' mode the region will collapse to a
     * thinner bar than in normal mode.  By default collapseMode is undefined, and the only two supported values
     * are undefined and 'mini'.  Note that if a collapsible region does not have a title bar, then collapseMode
     * must be set to 'mini' in order for the region to be collapsible by the user as the tool button will not
     * be rendered.
     */
    /**
     * @cfg {Object} margins
     * An object containing margins to apply to the region when in the expanded state in the format:<pre><code>
{
    top: (top margin),
    right: (right margin),
    bottom: (bottom margin)
    left: (left margin),
}</code></pre>
     * <p>May also be a string containing space-separated, numeric margin values. The order of the sides associated
     * with each value matches the way CSS processes margin values:</p>
     * <p><ul>
     * <li>If there is only one value, it applies to all sides.</li>
     * <li>If there are two values, the top and bottom borders are set to the first value and the right
     * and left are set to the second.</li>
     * <li>If there are three values, the top is set to the first value, the left and right are set to the second, and the bottom
     * is set to the third.</li>
     * <li>If there are four values, they apply to the top, right, bottom, and left, respectively.</li>
     * </ul></p>
     */
    /**
     * @cfg {Object} cmargins
     * An object containing margins to apply to the region when in the collapsed state in the format:<pre><code>
{
    top: (top margin),
    right: (right margin),
    bottom: (bottom margin)
    left: (left margin),
}</code></pre>
     * <p>May also be a string containing space-separated, numeric margin values. The order of the sides associated
     * with each value matches the way CSS processes margin values.</p>
     * <p><ul>
     * <li>If there is only one value, it applies to all sides.</li>
     * <li>If there are two values, the top and bottom borders are set to the first value and the right
     * and left are set to the second.</li>
     * <li>If there are three values, the top is set to the first value, the left and right are set to the second, and the bottom
     * is set to the third.</li>
     * <li>If there are four values, they apply to the top, right, bottom, and left, respectively.</li>
     * </ul></p>
     */
    /**
     * @cfg {Boolean} collapsible
     * True to allow the user to collapse this region (defaults to false).  If true, an expand/collapse tool button
     * will automatically be rendered into the title bar of the region, otherwise the button will not be shown.
     * Note that a title bar is required to display the toggle button -- if no region title is specified, the
     * region will only be collapsible if {@link #collapseMode} is set to 'mini'.
     */
    collapsible : false,
    /**
     * @cfg {Boolean} split
     * True to display a {@link L5.SplitBar} between this region and its neighbor, allowing the user to resize
     * the regions dynamically (defaults to false).  When split == true, it is common to specify a minSize
     * and maxSize for the BoxComponent representing the region. These are not native configs of BoxComponent, and
     * are used only by this class.
     */
    split:false,
    /**
     * @cfg {Boolean} floatable
     * True to allow clicking a collapsed region's bar to display the region's panel floated above the layout,
     * false to force the user to fully expand a collapsed region by clicking the expand button to see it again
     * (defaults to true).
     */
    floatable: true,
    /**
     * @cfg {Number} minWidth
     * The minimum allowable width in pixels for this region (defaults to 50)
     */
    minWidth:50,
    /**
     * @cfg {Number} minHeight
     * The minimum allowable height in pixels for this region (defaults to 50)
     */
    minHeight:50,

    // private
    defaultMargins : {left:0,top:0,right:0,bottom:0},
    // private
    defaultNSCMargins : {left:5,top:5,right:5,bottom:5},
    // private
    defaultEWCMargins : {left:5,top:0,right:5,bottom:0},
    /**
     * 各个position的组件收起展开图标的基本css
     * 各个方向的图标css应该是一组css样式，遵守一定的命名规范，baseToggleCls只是这组css所有的开头部分，命名规范如下：
     * css类选择器：
     * 					现在展开，点击闭合的css：baseToggleCls+"-collapse-"+position
     * 					现在展开，点击闭合，鼠标悬空在按钮上改变的css：baseToggleCls+"-collapse-"+position+"-over"
     * 					现在闭合，点击展开的css：baseToggleCls+"-expand-"+position
     * 					现在闭合，点击展开，鼠标悬空在按钮上改变的css：baseToggleCls+"-expand-"+position+"-over"
     * 因为有多个方向的图标，所以需要定义一组css类选择器，方向包括：south，north，west，east。
     * 示例：
     * 		
		.l-border-collapse-south {
		    background-image:url(../images/default/panel/border-toggle-collapse-south.gif) !important;
		}
		
		.l-border-collapse-south-over {
		    background-image:url(../images/default/panel/border-toggle-collapse-south-over.gif) !important;
		}
		
		.l-border-collapse-north {
		    background-image:url(../images/default/panel/border-toggle-collapse-north.gif) !important;
		}
		
		.l-border-collapse-north-over {
		    background-image:url(../images/default/panel/border-toggle-collapse-north-over.gif) !important;
		}
		
		.l-border-collapse-west {
		    background-image:url(../images/default/panel/border-toggle-collapse-west.gif) !important;
		}
		
		.l-border-collapse-west-over {
		    background-image:url(../images/default/panel/border-toggle-collapse-west-over.gif) !important;
		}
		
		.l-border-collapse-east {
		    background-image:url(../images/default/panel/border-toggle-collapse-east.gif) !important;
		}
		
		.l-border-collapse-east-over {
		    background-image:url(../images/default/panel/border-toggle-collapse-east-over.gif) !important;
		}
		
		.l-border-expand-south {
		    background-image:url(../images/default/panel/border-toggle-collapse-north.gif) !important;
		}
		
		.l-border-expand-south-over {
		    background-image:url(../images/default/panel/border-toggle-collapse-north-over.gif) !important;
		}
		
		.l-border-expand-north {
		    background-image:url(../images/default/panel/border-toggle-collapse-south.gif) !important;
		}
		
		.l-border-expand-north-over {
		    background-image:url(../images/default/panel/border-toggle-collapse-south-over.gif) !important;
		}
		
		.l-border-expand-west {
		    background-image:url(../images/default/panel/border-toggle-collapse-east.gif) !important;
		}
		
		.l-border-expand-west-over {
		    background-image:url(../images/default/panel/border-toggle-collapse-east-over.gif) !important;
		}
		
		.l-border-expand-east {
		    background-image:url(../images/default/panel/border-toggle-collapse-west.gif) !important;
		}
		
		.l-border-expand-east-over {
		    background-image:url(../images/default/panel/border-toggle-collapse-west-over.gif) !important;
		}
		
		.l-border-expand-north,.l-border-expand-south {
			float: right;
			margin: 3px;
		}
		
		.l-border-expand-east,.l-border-expand-west {
			float: none;
			margin: 3px auto;
		}
     * 
     */
    baseToggleCls:"l-tool",

    /**
     * True if this region is collapsed. Read-only.
     * @type Boolean
     * @property
     */
    isCollapsed : false,

    /**
     * This region's panel.  Read-only.
     * 
     * @type L5.Panel
     * @property panel
     */
    
    /**
     * This region's layout.  Read-only.
     * @type Layout
     * @property layout
     */
    
    /**
     * This region's layout position (north, south, east, west or center).  Read-only.
     * @type String
     * @property position
     */
    
    /**
     * 区域的渲染
     * @param ct
     * @param p
     * @private
     */
    render : function(ct, p){
        this.panel = p;
        p.el.enableDisplayMode();
        this.targetEl = ct;
        this.el = p.el;

        var gs = p.getState, ps = this.position;
        p.getState = function(){
            return L5.apply(gs.call(p) || {}, this.state);
        }.createDelegate(this);

        if(ps != 'center'){
            p.allowQueuedExpand = false;
            p.on({
                beforecollapse: this.beforeCollapse,
                collapse: this.onCollapse,
                beforeexpand: this.beforeExpand,
                expand: this.onExpand,
                hide: this.onHide,
                show: this.onShow,
                scope: this
            });
            if(this.collapsible){
                p.collapseEl = 'el';
                p.slideAnchor = this.getSlideAnchor();
            }
            if(p.tools && p.tools.toggle){
            	if(this.baseToggleCls!="l-tool"){
            		 p.tools.toggle.removeClass("l-tool-toggle");
            		 p.tools.toggle.dom.style.backgroundPosition = "0px 0px";
            	}
                p.tools.toggle.addClass(this.baseToggleCls+'-collapse-'+ps);
                p.tools.toggle.addClassOnOver(this.baseToggleCls+'-collapse-'+ps+'-over');
            }
        }
    },

    // private
    getCollapsedEl : function(){
        if(!this.collapsedEl){
            if(!this.toolTemplate){
                var tt = new L5.Template(
                     '<div class="l-tool '+this.baseToggleCls+'-{id}">&#160;</div>'
                );
                tt.disableFormats = true;
                tt.compile();
                L5.layout.BorderLayout.Region.prototype.toolTemplate = tt;
            }
            this.collapsedEl = this.targetEl.createChild({
                cls: "l-layout-collapsed l-layout-collapsed-"+this.position,
                id: this.panel.id + '-xcollapsed'
            });
            this.collapsedEl.enableDisplayMode('block');

            if(this.collapseMode == 'mini'){
                this.collapsedEl.addClass('l-layout-cmini-'+this.position);
                this.miniCollapsedEl = this.collapsedEl.createChild({
                    cls: "l-layout-mini l-layout-mini-"+this.position, html: "&#160;"
                });
                this.miniCollapsedEl.addClassOnOver('l-layout-mini-over');
                this.collapsedEl.addClassOnOver("l-layout-collapsed-over");
                this.collapsedEl.on('click', this.onExpandClick, this, {stopEvent:true});
            }else {
                var t = this.toolTemplate.append(
                        this.collapsedEl.dom,
                        {id:'expand-'+this.position}, true);
                if(this.title)
                	t.parent().createChild('<span style="font:bold 12px/15px tahoma, arial, verdana, sans-serif;color:#15428b">'+this.title+'</span>');
                t.addClassOnOver(this.baseToggleCls+'-expand-'+this.position+'-over');
                t.on('click', this.onExpandClick, this, {stopEvent:true});
                
                if(this.floatable !== false){
                   this.collapsedEl.addClassOnOver("l-layout-collapsed-over");
                   this.collapsedEl.on("click", this.collapseClick, this);
                }
                this.collapsedEl.on("dblclick", this.onExpandClick, this, {stopEvent:true});
            }
        }
        return this.collapsedEl;
    },

    // private
    onExpandClick : function(e){
        if(this.isSlid){
            this.afterSlideIn();
            this.panel.expand(false);
        }else{
            this.panel.expand();
        }
    },

    // private
    onCollapseClick : function(e){
        this.panel.collapse();
    },

    // private
    beforeCollapse : function(p, animate){
        this.lastAnim = animate;
        if(this.splitEl){
            this.splitEl.hide();
        }
        this.getCollapsedEl().show();
        this.panel.el.setStyle('z-index', 100);
        this.isCollapsed = true;
        this.layout.layout();
    },

    // private
    onCollapse : function(animate){
        this.panel.el.setStyle('z-index', 1);
        if(this.lastAnim === false || this.panel.animCollapse === false){
            this.getCollapsedEl().dom.style.visibility = 'visible';
        }else{
            this.getCollapsedEl().slideIn(this.panel.slideAnchor, {duration:.2});
        }
        this.state.collapsed = true;
        this.panel.saveState();
    },

    // private
    beforeExpand : function(animate){
        var c = this.getCollapsedEl();
        this.el.show();
        if(this.position == 'east' || this.position == 'west'){
            this.panel.setSize(undefined, c.getHeight());
        }else{
            this.panel.setSize(c.getWidth(), undefined);
        }
        c.hide();
        c.dom.style.visibility = 'hidden';
        this.panel.el.setStyle('z-index', 100);
    },

    // private
    onExpand : function(){
        this.isCollapsed = false;
        if(this.splitEl){
            this.splitEl.show();
        }
        this.layout.layout();
        this.panel.el.setStyle('z-index', 1);
        this.state.collapsed = false;
        this.panel.saveState();
    },

    // private
    collapseClick : function(e){
    	if(this.isSlid){
           e.stopPropagation();
           this.slideIn();
        }else{
           e.stopPropagation();
           this.slideOut();
        }
    },

    // private
    onHide : function(){
        if(this.isCollapsed){
            this.getCollapsedEl().hide();
        }else if(this.splitEl){
            this.splitEl.hide();
        }
    },

    // private
    onShow : function(){
        if(this.isCollapsed){
            this.getCollapsedEl().show();
        }else if(this.splitEl){
            this.splitEl.show();
        }
    },

    /**
     * True if this region is currently visible, else false.
     * @return {Boolean}
     */
    isVisible : function(){
        return !this.panel.hidden;
    },

    /**
     * Returns the current margins for this region.  If the region is collapsed, the cmargins (collapsed
     * margins) value will be returned, otherwise the margins value will be returned.
     * @return {Object} An object containing the element's margins: {left: (left margin), top: (top margin),
     * right: (right margin), bottom: (bottom margin)}
     */
    getMargins : function(){
        return this.isCollapsed && this.cmargins ? this.cmargins : this.margins;
    },

    /**
     * Returns the current size of this region.  If the region is collapsed, the size of the collapsedEl will
     * be returned, otherwise the size of the region's panel will be returned.
     * @return {Object} An object containing the element's size: {width: (element width), height: (element height)}  
     */
    getSize : function(){
        return this.isCollapsed ? this.getCollapsedEl().getSize() : this.panel.getSize();
    },

    /**
     * Sets the specified panel as the container element for this region.
     * @param {L5.Panel} panel The new panel
     */
    setPanel : function(panel){
        this.panel = panel;
    },

    /**
     * Returns the minimum allowable width for this region.
     * @return {Number} The minimum width
     */
    getMinWidth: function(){
        return this.minWidth;
    },

    /**
     * Returns the minimum allowable height for this region.
     * @return {Number} The minimum height
     */
    getMinHeight: function(){
        return this.minHeight;
    },

    // private
    applyLayoutCollapsed : function(box){
        var ce = this.getCollapsedEl();
        ce.setLeftTop(box.x, box.y);
        ce.setSize(box.width, box.height);
    },

    // private
    applyLayout : function(box){
        if(this.isCollapsed){
            this.applyLayoutCollapsed(box);
        }else{
            this.panel.setPosition(box.x, box.y);
            this.panel.setSize(box.width, box.height);
        }
    },

    // private
    beforeSlide: function(){
        this.panel.beforeEffect();
    },

    // private
    afterSlide : function(){
        this.panel.afterEffect();
    },

    // private
    initAutoHide : function(){
        if(this.autoHide !== false){
            if(!this.autoHideHd){
                var st = new L5.util.DelayedTask(this.slideIn, this);
                this.autoHideHd = {
                    "mouseout": function(e){
                        if(!e.within(this.el, true)){
                            st.delay(500);
                        }
                    },
                    "mouseover" : function(e){
                        st.cancel();
                    },
                    scope : this
                };
            }
            this.el.on(this.autoHideHd);
        }
    },

    // private
    clearAutoHide : function(){
        if(this.autoHide !== false){
        	if(this.autoHideHd && this.autoHideHd.mouseout && this.autoHideHd.mouseover){
        		this.el.un("mouseout", this.autoHideHd.mouseout);
                this.el.un("mouseover", this.autoHideHd.mouseover);
        	}
        }
    },

    // private
    clearMonitor : function(){
        L5.getDoc().un("click", this.slideInIf, this);
    },

    // these names are backwards but not changed for compat
    // private
    slideOut : function(){
        if(this.isSlid || this.el.hasActiveFx()){
            return;
        }
        if(this.collapsedEl && this.collapsedEl.child("span"))
        	this.collapsedEl.child("span").dom.innerHTML="";
        this.isSlid = true;
        var ts = this.panel.tools;
        if(ts && ts.toggle){
            ts.toggle.hide();
        }
        this.el.show();
        if(this.position == 'east' || this.position == 'west'){
            this.panel.setSize(undefined, this.collapsedEl.getHeight());
        }else{
            this.panel.setSize(this.collapsedEl.getWidth(), undefined);
        }
        this.restoreLT = [this.el.dom.style.left, this.el.dom.style.top];
        this.el.alignTo(this.collapsedEl, this.getCollapseAnchor());
        this.el.setStyle("z-index", 102);
        this.panel.el.replaceClass('l-panel-collapsed', 'l-panel-floating');
        if(this.animFloat !== false){
            this.beforeSlide();
            this.el.slideIn(this.getSlideAnchor(), {
                callback: function(){
                    this.afterSlide();
                    this.initAutoHide();
                    L5.getDoc().on("click", this.slideInIf, this);
                },
                scope: this,
                block: true
            });
        }else{
            this.initAutoHide();
             L5.getDoc().on("click", this.slideInIf, this);
        }
    },

    // private
    afterSlideIn : function(){
        this.clearAutoHide();
        this.isSlid = false;
        this.clearMonitor();
        this.el.setStyle("z-index", "");
        this.panel.el.replaceClass('l-panel-floating', 'l-panel-collapsed');
        this.el.dom.style.left = this.restoreLT[0];
        this.el.dom.style.top = this.restoreLT[1];

        var ts = this.panel.tools;
        if(ts && ts.toggle){
            ts.toggle.show();
        }
    },

    // private
    slideIn : function(cb){
        if(!this.isSlid || this.el.hasActiveFx()){
            L5.callback(cb);
            return;
        }
        if(this.collapsedEl && this.collapsedEl.child("span"))
        	this.collapsedEl.child("span").dom.innerHTML =  this.title?this.title:"";
        this.isSlid = false;
        if(this.animFloat !== false){
            this.beforeSlide();
            this.el.slideOut(this.getSlideAnchor(), {
                callback: function(){
                    this.el.hide();
                    this.afterSlide();
                    this.afterSlideIn();
                    L5.callback(cb);
                },
                scope: this,
                block: true
            });
        }else{
            this.el.hide();
            this.afterSlideIn();
        }
    },

    // private
    slideInIf : function(e){
        if(!e.within(this.el)){
            this.slideIn();
        }
    },

    // private
    anchors : {
        "west" : "left",
        "east" : "right",
        "north" : "top",
        "south" : "bottom"
    },

    // private
    sanchors : {
        "west" : "l",
        "east" : "r",
        "north" : "t",
        "south" : "b"
    },

    // private
    canchors : {
        "west" : "tl-tr",
        "east" : "tr-tl",
        "north" : "tl-bl",
        "south" : "bl-tl"
    },

    // private
    getAnchor : function(){
        return this.anchors[this.position];
    },

    // private
    getCollapseAnchor : function(){
        return this.canchors[this.position];
    },

    // private
    getSlideAnchor : function(){
        return this.sanchors[this.position];
    },

    // private
    getAlignAdj : function(){
        var cm = this.cmargins;
        switch(this.position){
            case "west":
                return [0, 0];
            break;
            case "east":
                return [0, 0];
            break;
            case "north":
                return [0, 0];
            break;
            case "south":
                return [0, 0];
            break;
        }
    },

    // private
    getExpandAdj : function(){
        var c = this.collapsedEl, cm = this.cmargins;
        switch(this.position){
            case "west":
                return [-(cm.right+c.getWidth()+cm.left), 0];
            break;
            case "east":
                return [cm.right+c.getWidth()+cm.left, 0];
            break;
            case "north":
                return [0, -(cm.top+cm.bottom+c.getHeight())];
            break;
            case "south":
                return [0, cm.top+cm.bottom+c.getHeight()];
            break;
        }
    }
};

/**
 * @class L5.layout.BorderLayout.SplitRegion
 * @extends L5.layout.BorderLayout.Region
 * This is a specialized type of BorderLayout region that has a built-in {@link L5.SplitBar} for user resizing of regions.
 * @constructor
 * Create a new SplitRegion.
 * @param {Layout} layout Any valid L5 layout class
 * @param {Object} config The configuration options
 * @param {String} position The region position.  Valid values are: north, south, east, west and center.  Every
 * BorderLayout must have a center region for the primary content -- all other regions are optional.
 */
L5.layout.BorderLayout.SplitRegion = function(layout, config, pos){
    L5.layout.BorderLayout.SplitRegion.superclass.constructor.call(this, layout, config, pos);
    // prevent switch
    this.applyLayout = this.applyFns[pos];
};

L5.extend(L5.layout.BorderLayout.SplitRegion, L5.layout.BorderLayout.Region, {
    /**
     * @cfg {String} splitTip
     * The tooltip to display when the user hovers over a non-collapsible region's split bar (defaults to "Drag
     * to resize.").  Only applies if {@link #useSplitTips} = true.
     */
    splitTip : "Drag to resize.",
    /**
     * @cfg {String} collapsibleSplitTip
     * The tooltip to display when the user hovers over a collapsible region's split bar (defaults to "Drag
     * to resize. Double click to hide.").  Only applies if {@link #useSplitTips} = true.
     */
    collapsibleSplitTip : "Drag to resize. Double click to hide.",
    /**
     * @cfg {Boolean} useSplitTips
     * True to display a tooltip when the user hovers over a region's split bar (defaults to false).  The tooltip
     * text will be the value of either {@link #splitTip} or {@link #collapsibleSplitTip} as appropriate.
     */
    useSplitTips : false,

    // private
    splitSettings : {
        north : {
            orientation: L5.SplitBar.VERTICAL,
            placement: L5.SplitBar.TOP,
            maxFn : 'getVMaxSize',
            minProp: 'minHeight',
            maxProp: 'maxHeight'
        },
        south : {
            orientation: L5.SplitBar.VERTICAL,
            placement: L5.SplitBar.BOTTOM,
            maxFn : 'getVMaxSize',
            minProp: 'minHeight',
            maxProp: 'maxHeight'
        },
        east : {
            orientation: L5.SplitBar.HORIZONTAL,
            placement: L5.SplitBar.RIGHT,
            maxFn : 'getHMaxSize',
            minProp: 'minWidth',
            maxProp: 'maxWidth'
        },
        west : {
            orientation: L5.SplitBar.HORIZONTAL,
            placement: L5.SplitBar.LEFT,
            maxFn : 'getHMaxSize',
            minProp: 'minWidth',
            maxProp: 'maxWidth'
        }
    },

    // private
    applyFns : {
        west : function(box){
            if(this.isCollapsed){
                return this.applyLayoutCollapsed(box);
            }
            var sd = this.splitEl.dom, s = sd.style;
            this.panel.setPosition(box.x, box.y);
            var sw = sd.offsetWidth;
            s.left = (box.x+box.width-sw)+'px';
            s.top = (box.y)+'px';
            s.height = Math.max(0, box.height)+'px';
            this.panel.setSize(box.width-sw, box.height);
        },
        east : function(box){
            if(this.isCollapsed){
                return this.applyLayoutCollapsed(box);
            }
            var sd = this.splitEl.dom, s = sd.style;
            var sw = sd.offsetWidth;
            this.panel.setPosition(box.x+sw, box.y);
            s.left = (box.x)+'px';
            s.top = (box.y)+'px';
            s.height = Math.max(0, box.height)+'px';
            this.panel.setSize(box.width-sw, box.height);
        },
        north : function(box){
            if(this.isCollapsed){
                return this.applyLayoutCollapsed(box);
            }
            var sd = this.splitEl.dom, s = sd.style;
            var sh = sd.offsetHeight;
            this.panel.setPosition(box.x, box.y);
            s.left = (box.x)+'px';
            s.top = (box.y+box.height-sh)+'px';
            s.width = Math.max(0, box.width)+'px';
            this.panel.setSize(box.width, box.height-sh);
        },
        south : function(box){
            if(this.isCollapsed){
                return this.applyLayoutCollapsed(box);
            }
            var sd = this.splitEl.dom, s = sd.style;
            var sh = sd.offsetHeight;
            this.panel.setPosition(box.x, box.y+sh);
            s.left = (box.x)+'px';
            s.top = (box.y)+'px';
            s.width = Math.max(0, box.width)+'px';
            this.panel.setSize(box.width, box.height-sh);
        }
    },

    // private
    render : function(ct, p){
        L5.layout.BorderLayout.SplitRegion.superclass.render.call(this, ct, p);

        var ps = this.position;

        this.splitEl = ct.createChild({
            cls: "l-layout-split l-layout-split-"+ps, html: "&#160;",
            id: this.panel.id + '-xsplit'
        });

        if(this.collapseMode == 'mini'){
            this.miniSplitEl = this.splitEl.createChild({
                cls: "l-layout-mini l-layout-mini-"+ps, html: "&#160;"
            });
            this.miniSplitEl.addClassOnOver('l-layout-mini-over');
            this.miniSplitEl.on('click', this.onCollapseClick, this, {stopEvent:true});
        }

        var s = this.splitSettings[ps];

        this.split = new L5.SplitBar(this.splitEl.dom, p.el, s.orientation);
        this.split.placement = s.placement;
        this.split.getMaximumSize = this[s.maxFn].createDelegate(this);
        this.split.minSize = this.minSize || this[s.minProp];
        this.split.on("beforeapply", this.onSplitMove, this);
        this.split.useShim = this.useShim === true;
        this.maxSize = this.maxSize || this[s.maxProp];

        if(p.hidden){
            this.splitEl.hide();
        }

        if(this.useSplitTips){
            this.splitEl.dom.title = this.collapsible ? this.collapsibleSplitTip : this.splitTip;
        }
        if(this.collapsible){
            this.splitEl.on("dblclick", this.onCollapseClick,  this);
        }
    },

    //docs inherit from superclass
    getSize : function(){
        if(this.isCollapsed){
            return this.collapsedEl.getSize();
        }
        var s = this.panel.getSize();
        if(this.position == 'north' || this.position == 'south'){
            s.height += this.splitEl.dom.offsetHeight;
        }else{
            s.width += this.splitEl.dom.offsetWidth;
        }
        return s;
    },

    // private
    getHMaxSize : function(){
         var cmax = this.maxSize || 10000;
         var center = this.layout.center;
         return Math.min(cmax, (this.el.getWidth()+center.el.getWidth())-center.getMinWidth());
    },

    // private
    getVMaxSize : function(){
        var cmax = this.maxSize || 10000;
        var center = this.layout.center;
        return Math.min(cmax, (this.el.getHeight()+center.el.getHeight())-center.getMinHeight());
    },

    // private
    onSplitMove : function(split, newSize){
        var s = this.panel.getSize();
        this.lastSplitSize = newSize;
        if(this.position == 'north' || this.position == 'south'){
            //this.panel.setSize(s.width, newSize);
        	//换成百分比
        	var ownerCt = this.panel.ownerCt;
        	var newH = (newSize/ownerCt.getEl().getHeight()).toString();
    		if(newH.length<4){
    			newH +="00000";
    		}
    		newSize = newH.toString().substring(2,4)+"%";
        	
            this.panel.setHeight(newSize);
            
            
            this.state.height = newSize;
        }else{
            //this.panel.setSize(newSize, s.height);
        	//换成百分比
        	var ownerCt = this.panel.ownerCt;
        	var newW = (newSize/ownerCt.getEl().getWidth()).toString();
    		if(newW.length<4){
    			newW +="00000";
    		}
    		newSize = newW.toString().substring(2,4)+"%";
            this.panel.setWidth(newSize);
            
            
            this.state.width = newSize;
        }
        this.layout.layout();
        this.panel.saveState();
        return false;
    },

    /**
     * Returns a reference to the split bar in use by this region.
     * @return {L5.SplitBar} The split bar
     */
    getSplitBar : function(){
        return this.split;
    },
    
    // inherit docs
    destroy : function() {
        L5.destroy(
            this.miniSplitEl, 
            this.split, 
            this.splitEl
        );
    }
});

L5.Container.LAYOUTS['border'] = L5.layout.BorderLayout;