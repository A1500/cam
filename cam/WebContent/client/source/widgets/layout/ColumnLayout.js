/**
 * <p>列布局，子控件一字排开、各人占一列，按设置分好宽度
 * 
 * <p>例如：
 * <pre><code>
// All columns are percentages -- they must add up to 1
var p = new L5.Panel({
    title: 'Column Layout - Percentage Only',
    layout:'column',
    items: [{
        title: 'Column 1',
        columnWidth: .25 
    },{
        title: 'Column 2',
        columnWidth: .6
    },{
        title: 'Column 3',
        columnWidth: .15
    }]
});


var p = new L5.Panel({
    title: 'Column Layout - Mixed',
    layout:'column',
    items: [{
        title: 'Column 1',
        width: 120
    },{
        title: 'Column 2',
        columnWidth: .8
    },{
        title: 'Column 3',
        columnWidth: .2
    }]
});
</code></pre>
 * @class L5.layout.ColumnLayout
 * @extends L5.layout.ContainerLayout
 */
L5.layout.ColumnLayout = L5.extend(L5.layout.ContainerLayout, {
	
    // 监听容器组件的resize事件
    monitorResize:true,    
    
    extraCls: 'l-column',

    scrollOffset : 0,

    // private
    isValidParent : function(c, target){
        return (c.getPositionEl ? c.getPositionEl() : c.getEl()).dom.parentNode == this.innerCt.dom;
    },

    /**
	 * 执行实际的布局工作:渲染所有的子控件，并设置宽度
	 * 
	 * @param {L5.Container}
	 *            ct 对应的容器组件
	 * @param {L5.Element}
	 *            target 指定：渲染到哪个元素里
	 * @override
	 */
    onLayout : function(ct, target){
        var cs = ct.items.items, len = cs.length, c, i;
       if(!this.innerCt){
            target.addClass('l-column-layout-ct');

            // the innerCt prevents wrapping and shuffling while
            // the container is resizing
            this.innerCt = target.createChild({cls:'l-column-inner'});
            this.innerCt.createChild({cls:'l-clear'});
        }
        this.renderAll(ct, this.innerCt);

        var size = L5.isIE && target.dom != L5.getBody().dom ? target.getStyleSize() : target.getViewSize();

        if(size.width < 1 && size.height < 1){ // display none?
            return;
        }

        var w = size.width - target.getPadding('lr') - this.scrollOffset,
            h = size.height - target.getPadding('tb'),
            pw = w;

        this.innerCt.setWidth(w);
        
        
        
        for(i = 0; i < len; i++){
            c = cs[i];

            if(!c.columnWidth){
                pw -= (c.getSize().width + c.getEl().getMargins('lr'));
            }
        }

        pw = pw < 0 ? 0 : pw;

        for(i = 0; i < len; i++){
            c = cs[i];
            if(c.columnWidth){
                c.setSize(Math.floor(c.columnWidth*pw) - c.getEl().getMargins('lr'));
            } 
        }
        
        // some columns can be percentages while others are fixed
        // so we need to make 2 passes
        for(i = 0; i < len; i++){
            c = cs[i];
            if(c.onWinResize){
            	c.onWinResize();
            }
        }
    }
    
    /**
     * @property activeItem
     * @hide
     */
});

L5.Container.LAYOUTS['column'] = L5.layout.ColumnLayout;