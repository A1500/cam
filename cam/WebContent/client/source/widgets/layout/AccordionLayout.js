/**
 * <p>accordion布局就是推拉布局，点一下当前页，会把其它弹开。
 * 
 * 例如:</p>
 * <pre><code>
var accordion = new L5.Panel({
    title: 'Accordion Layout',
    layout:'accordion',
    defaults: {
        // applied to each contained panel
        bodyStyle: 'padding:15px'
    },
    layoutConfig: {
        // layout-specific configs go here
        titleCollapse: false,
        animate: true,
        activeOnTop: true
    },
    items: [{
        title: 'Panel 1',
        html: '&lt;p&gt;Panel content!&lt;/p&gt;'
    },{
        title: 'Panel 2',
        html: '&lt;p&gt;Panel content!&lt;/p&gt;'
    },{
        title: 'Panel 3',
        html: '&lt;p&gt;Panel content!&lt;/p&gt;'
    }]
});
</code></pre>
 * @class L5.layout.Accordion
 * @extends L5.layout.FitLayout
 */
L5.layout.Accordion = L5.extend(L5.layout.FitLayout, {
    /**
     * @cfg {Boolean} fill
     * 活动子组件是否占满可用空间(defaults to true).
     */
    fill : true,
    /**
     * @cfg {Boolean} autoWidth
     * 是否设置所有子组件的width属性为'auto'(defaults to true).
     */
    autoWidth : true,
    /**
     * @cfg {Boolean} titleCollapse
     * 是否随便点子组件的什么地方都可以触发打开/合起动作，还是只能点那个小按钮才能打开/合起(defaults to true). 如果是 false,{@link #hideCollapseTool} 也必须是false.
     */
    titleCollapse : true,
    /**
     * @cfg {Boolean} hideCollapseTool
     * 是否隐藏父容器的打开/合起动作
     */
    hideCollapseTool : false,
    /**
     * @cfg {Boolean} collapseFirst
     * True to make sure the collapse/expand toggle button always renders first (to the left of) any other tools
     * in the contained panels' title bars, false to render it last (defaults to false).
     */
    collapseFirst : false,
    /**
     * @cfg {Boolean} animate
     * True to slide the contained panels open and closed during expand/collapse using animation, false to open and
     * close directly with no animation (defaults to false).  Note: to defer to the specific config setting of each
     * contained panel for this property, set this to undefined at the layout level.
     */
    animate : false,
    /**
     * @cfg {Boolean} sequence
     * <b>Experimental</b>. If animate is set to true, this will result in each animation running in sequence.
     */
    sequence : false,
    /**
     * @cfg {Boolean} activeOnTop
     * True to swap the position of each panel as it is expanded so that it becomes the first item in the container,
     * false to keep the panels in the rendered order. <b>This is NOT compatible with "animate:true"</b> (defaults to false).
     */
    activeOnTop : false,

    
    renderItem : function(c){
        if(this.animate === false){
            c.animCollapse = false;
        }
        c.collapsible = true;
        if(this.autoWidth){
            c.autoWidth = true;
        }
        if(this.titleCollapse){
            c.titleCollapse = true;
        }
        if(this.hideCollapseTool){
            c.hideCollapseTool = true;
        }
        if(this.collapseFirst !== undefined){
            c.collapseFirst = this.collapseFirst;
        }
        if(!this.activeItem && !c.collapsed){
            this.activeItem = c;
        }else if(this.activeItem){
            c.collapsed = true;
        }
        L5.layout.Accordion.superclass.renderItem.apply(this, arguments);
        c.header.addClass('l-accordion-hd');
        c.on('beforeexpand', this.beforeExpand, this);
    },

    // private
    beforeExpand : function(p, anim){
        var ai = this.activeItem;
        if(ai){
            if(this.sequence){
                delete this.activeItem;
                if (!ai.collapsed){
                    ai.collapse({callback:function(){
                        p.expand(anim || true);
                    }, scope: this});
                    return false;
                }
            }else{
                ai.collapse(this.animate);
            }
        }
        this.activeItem = p;
        if(this.activeOnTop){
            p.el.dom.parentNode.insertBefore(p.el.dom, p.el.dom.parentNode.firstChild);
        }
        this.layout();
    },

    // private
    setItemSize : function(item, size){
        if(this.fill && item){
            var items = this.container.items.items;
            var hh = 0;
            for(var i = 0, len = items.length; i < len; i++){
                var p = items[i];
                if(p != item){
                    hh += (p.getSize().height - p.bwrap.getHeight());
                }
            }
            size.height -= hh;
            item.setSize(size);
        }
    }
});
L5.Container.LAYOUTS['accordion'] = L5.layout.Accordion;