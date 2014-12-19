/**

 * <p>绝对布局就是指设置x，y坐标，定位到指定位置。
 * 
 * @class L5.layout.AbsoluteLayout
 * @extends L5.layout.AnchorLayout
 */
L5.layout.AbsoluteLayout = L5.extend(L5.layout.AnchorLayout, {
    /**
     * @cfg {String} extraCls
     * An optional extra CSS class that will be added to the container (defaults to 'l-abs-layout-item').  This can be useful for
     * adding customized styles to the container or any of its children using standard CSS rules.
     */
    extraCls: 'l-abs-layout-item',
    isForm: false,
    // private
    setContainer : function(ct){
        L5.layout.AbsoluteLayout.superclass.setContainer.call(this, ct);
        if(ct.isXType('form')){
            this.isForm = true;
        }
    },

    onLayout : function(ct, target){
        if(this.isForm){ ct.body.position(); } else { target.position(); }
        L5.layout.AbsoluteLayout.superclass.onLayout.call(this, ct, target);
    },

    // private
    getAnchorViewSize : function(ct, target){
        return this.isForm ? ct.body.getStyleSize() : L5.layout.AbsoluteLayout.superclass.getAnchorViewSize.call(this, ct, target);
    },

    // private
    isValidParent : function(c, target){
        return this.isForm ? true : L5.layout.AbsoluteLayout.superclass.isValidParent.call(this, c, target);
    },

    // private
    adjustWidthAnchor : function(value, comp){
        return value ? value - comp.getPosition(true)[0] : value;
    },

    // private
    adjustHeightAnchor : function(value, comp){
        return  value ? value - comp.getPosition(true)[1] : value;
    }
    /**
     * @property activeItem
     * @hide
     */
});
L5.Container.LAYOUTS['absolute'] = L5.layout.AbsoluteLayout;