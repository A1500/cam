/**
 * <p>相对布局，就是说可以相对容器指定像素或者100%，支持宽度。此布局是相对容器确定自身长宽。比如宽度是父窗口的50%或比父窗口小100。
 * @class L5.layout.AnchorLayout
 * @extends L5.layout.ContainerLayout
 */
L5.layout.AnchorLayout = L5.extend(L5.layout.ContainerLayout, {
    // private 监听容器组件的resiez事件
    monitorResize:true,

    /**
     * 取得渲染目标位置的大小
     */
    getAnchorViewSize : function(ct, target){
        return target.dom == document.body ?
                   target.getViewSize() : target.getStyleSize();
    },

    /**
	 * 执行实际的布局工作
	 * 
	 * @param {L5.Container}
	 *            ct 对应的容器组件
	 * @param {L5.Element}
	 *            target 指定：渲染到哪个元素里
	 * @override 
	 */
    onLayout : function(ct, target){
        L5.layout.AnchorLayout.superclass.onLayout.call(this, ct, target);

        var size = this.getAnchorViewSize(ct, target);

        var w = size.width, h = size.height;

        if(w < 20 || h < 20){
            return;
        }

        // find the container anchoring size
        var aw, ah;
        if(ct.anchorSize){
            if(typeof ct.anchorSize == 'number'){
                aw = ct.anchorSize;
            }else{
                aw = ct.anchorSize.width;
                ah = ct.anchorSize.height;
            }
        }else{
            aw = ct.initialConfig.width;
            ah = ct.initialConfig.height;
        }

        var cs = ct.items.items, len = cs.length, i, c, a, cw, ch;
        for(i = 0; i < len; i++){
            c = cs[i];
            if(c.anchor){
                a = c.anchorSpec;
                if(!a){ // cache all anchor values
                    var vs = c.anchor.split(' ');
                    c.anchorSpec = a = {
                        right: this.parseAnchor(vs[0], c.initialConfig.width, aw),
                        bottom: this.parseAnchor(vs[1], c.initialConfig.height, ah)
                    };
                }
                cw = a.right ? this.adjustWidthAnchor(a.right(w), c) : undefined;
                ch = a.bottom ? this.adjustHeightAnchor(a.bottom(h), c) : undefined;

                if(cw || ch){
                    c.setSize(cw || undefined, ch || undefined);
                }
            }
        }
    },

    // private
    parseAnchor : function(a, start, cstart){
        if(a && a != 'none'){
            var last;
            if(/^(r|right|b|bottom)$/i.test(a)){   // standard anchor
                var diff = cstart - start;
                return function(v){
                    if(v !== last){
                        last = v;
                        return v - diff;
                    }
                }
            }else if(a.indexOf('%') != -1){
                var ratio = parseFloat(a.replace('%', ''))*.01;   // percentage
                return function(v){
                    if(v !== last){
                        last = v;
                        return Math.floor(v*ratio);
                    }
                }
            }else{
                a = parseInt(a, 10);
                if(!isNaN(a)){                            // simple offset adjustment
                    return function(v){
                        if(v !== last){
                            last = v;
                            return v + a;
                        }
                    }
                }
            }
        }
        return false;
    },

    // private
    adjustWidthAnchor : function(value, comp){
        return value;
    },

    // private
    adjustHeightAnchor : function(value, comp){
        return value;
    }
    
    /**
     * @property activeItem
     * @hide
     */
});
L5.Container.LAYOUTS['anchor'] = L5.layout.AnchorLayout;