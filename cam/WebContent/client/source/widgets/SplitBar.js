/**
 * @class L5.SplitBar
 * @extends L5.util.Observable
 * Creates draggable splitter bar functionality from two elements (element to be dragged and element to be resized).
 * <br><br>
 * Usage:
 * <pre><code>
var split = new L5.SplitBar("elementToDrag", "elementToSize",
                   L5.SplitBar.HORIZONTAL, L5.SplitBar.LEFT);
split.setAdapter(new L5.SplitBar.AbsoluteLayoutAdapter("container"));
split.minSize = 100;
split.maxSize = 600;
split.animate = true;
split.on('moved', splitterMoved);
</code></pre>
 * @constructor
 * Create a new SplitBar
 * @param {Mixed} dragElement The element to be dragged and act as the SplitBar.
 * @param {Mixed} resizingElement The element to be resized based on where the SplitBar element is dragged
 * @param {Number} orientation (optional) Either L5.SplitBar.HORIZONTAL or L5.SplitBar.VERTICAL. (Defaults to HORIZONTAL)
 * @param {Number} placement (optional) Either L5.SplitBar.LEFT or L5.SplitBar.RIGHT for horizontal or  
                        L5.SplitBar.TOP or L5.SplitBar.BOTTOM for vertical. (By default, this is determined automatically by the initial
                        position of the SplitBar).
 */
L5.SplitBar = function(dragElement, resizingElement, orientation, placement, existingProxy){
    
    /** @private */
    this.el = L5.get(dragElement, true);
    this.el.dom.unselectable = "on";
    /** @private */
    this.resizingEl = L5.get(resizingElement, true);

    /**
     * @private
     * The orientation of the split. Either L5.SplitBar.HORIZONTAL or L5.SplitBar.VERTICAL. (Defaults to HORIZONTAL)
     * Note: If this is changed after creating the SplitBar, the placement property must be manually updated
     * @type Number
     */
    this.orientation = orientation || L5.SplitBar.HORIZONTAL;
    
    /**
     * The minimum size of the resizing element. (Defaults to 0)
     * @type Number
     */
    this.minSize = 0;
    
    /**
     * The maximum size of the resizing element. (Defaults to 2000)
     * @type Number
     */
    this.maxSize = 2000;
    
    /**
     * Whether to animate the transition to the new size
     * @type Boolean
     */
    this.animate = false;
    
    /**
     * Whether to create a transparent shim that overlays the page when dragging, enables dragging across iframes.
     * @type Boolean
     */
    this.useShim = false;
    
    /** @private */
    this.shim = null;
    
    if(!existingProxy){
        /** @private */
        this.proxy = L5.SplitBar.createProxy(this.orientation);
    }else{
        this.proxy = L5.get(existingProxy).dom;
    }
    /** @private */
    this.dd = new L5.dd.DDProxy(this.el.dom.id, "XSplitBars", {dragElId : this.proxy.id});
    
    /** @private */
    this.dd.b4StartDrag = this.onStartProxyDrag.createDelegate(this);
    
    /** @private */
    this.dd.endDrag = this.onEndProxyDrag.createDelegate(this);
    
    /** @private */
    this.dragSpecs = {};
    
    /**
     * @private The adapter to use to positon and resize elements
     */
    this.adapter = new L5.SplitBar.BasicLayoutAdapter();
    this.adapter.init(this);
    
    if(this.orientation == L5.SplitBar.HORIZONTAL){
        /** @private */
        this.placement = placement || (this.el.getX() > this.resizingEl.getX() ? L5.SplitBar.LEFT : L5.SplitBar.RIGHT);
        this.el.addClass("l-splitbar-h");
    }else{
        /** @private */
        this.placement = placement || (this.el.getY() > this.resizingEl.getY() ? L5.SplitBar.TOP : L5.SplitBar.BOTTOM);
        this.el.addClass("l-splitbar-v");
    }
    
    this.addEvents(
        /**
         * @event resize
         * Fires when the splitter is moved (alias for {@link #moved})
         * @param {L5.SplitBar} this
         * @param {Number} newSize the new width or height
         */
        "resize",
        /**
         * @event moved
         * Fires when the splitter is moved
         * @param {L5.SplitBar} this
         * @param {Number} newSize the new width or height
         */
        "moved",
        /**
         * @event beforeresize
         * Fires before the splitter is dragged
         * @param {L5.SplitBar} this
         */
        "beforeresize",

        "beforeapply"
    );

    L5.SplitBar.superclass.constructor.call(this);
};

L5.extend(L5.SplitBar, L5.util.Observable, {
    onStartProxyDrag : function(x, y){
        this.fireEvent("beforeresize", this);
        this.overlay =  L5.DomHelper.append(document.body,  {cls: "l-drag-overlay", html: "&#160;"}, true);
        this.overlay.unselectable();
        this.overlay.setSize(L5.lib.Dom.getViewWidth(true), L5.lib.Dom.getViewHeight(true));
        this.overlay.show();
        L5.get(this.proxy).setDisplayed("block");
        var size = this.adapter.getElementSize(this);
        this.activeMinSize = this.getMinimumSize();
        this.activeMaxSize = this.getMaximumSize();
        var c1 = size - this.activeMinSize;
        var c2 = Math.max(this.activeMaxSize - size, 0);
        if(this.orientation == L5.SplitBar.HORIZONTAL){
            this.dd.resetConstraints();
            this.dd.setXConstraint(
                this.placement == L5.SplitBar.LEFT ? c1 : c2, 
                this.placement == L5.SplitBar.LEFT ? c2 : c1
            );
            this.dd.setYConstraint(0, 0);
        }else{
            this.dd.resetConstraints();
            this.dd.setXConstraint(0, 0);
            this.dd.setYConstraint(
                this.placement == L5.SplitBar.TOP ? c1 : c2, 
                this.placement == L5.SplitBar.TOP ? c2 : c1
            );
         }
        this.dragSpecs.startSize = size;
        this.dragSpecs.startPoint = [x, y];
        L5.dd.DDProxy.prototype.b4StartDrag.call(this.dd, x, y);
    },
    
    /** 
     * @private Called after the drag operation by the DDProxy
     */
    onEndProxyDrag : function(e){
        L5.get(this.proxy).setDisplayed(false);
        var endPoint = L5.lib.Event.getXY(e);
        if(this.overlay){
            L5.destroy(this.overlay);
            delete this.overlay;
        }
        var newSize;
        if(this.orientation == L5.SplitBar.HORIZONTAL){
            newSize = this.dragSpecs.startSize + 
                (this.placement == L5.SplitBar.LEFT ?
                    endPoint[0] - this.dragSpecs.startPoint[0] :
                    this.dragSpecs.startPoint[0] - endPoint[0]
                );
        }else{
            newSize = this.dragSpecs.startSize + 
                (this.placement == L5.SplitBar.TOP ?
                    endPoint[1] - this.dragSpecs.startPoint[1] :
                    this.dragSpecs.startPoint[1] - endPoint[1]
                );
        }
        newSize = Math.min(Math.max(newSize, this.activeMinSize), this.activeMaxSize);
        if(newSize != this.dragSpecs.startSize){
            if(this.fireEvent('beforeapply', this, newSize) !== false){
                this.adapter.setElementSize(this, newSize);
                this.fireEvent("moved", this, newSize);
                this.fireEvent("resize", this, newSize);
            }
        }
    },
    
    /**
     * Get the adapter this SplitBar uses
     * @return The adapter object
     */
    getAdapter : function(){
        return this.adapter;
    },
    
    /**
     * Set the adapter this SplitBar uses
     * @param {Object} adapter A SplitBar adapter object
     */
    setAdapter : function(adapter){
        this.adapter = adapter;
        this.adapter.init(this);
    },
    
    /**
     * Gets the minimum size for the resizing element
     * @return {Number} The minimum size
     */
    getMinimumSize : function(){
        return this.minSize;
    },
    
    /**
     * Sets the minimum size for the resizing element
     * @param {Number} minSize The minimum size
     */
    setMinimumSize : function(minSize){
        this.minSize = minSize;
    },
    
    /**
     * Gets the maximum size for the resizing element
     * @return {Number} The maximum size
     */
    getMaximumSize : function(){
        return this.maxSize;
    },
    
    /**
     * Sets the maximum size for the resizing element
     * @param {Number} maxSize The maximum size
     */
    setMaximumSize : function(maxSize){
        this.maxSize = maxSize;
    },
    
    /**
     * Sets the initialize size for the resizing element
     * @param {Number} size The initial size
     */
    setCurrentSize : function(size){
        var oldAnimate = this.animate;
        this.animate = false;
        this.adapter.setElementSize(this, size);
        this.animate = oldAnimate;
    },
    
    /**
     * Destroy this splitbar. 
     * @param {Boolean} removeEl True to remove the element
     */
    destroy : function(removeEl){
        if(this.shim){
            this.shim.remove();
        }
        this.dd.unreg();
        L5.destroy(L5.get(this.proxy));
        if(removeEl){
            this.el.remove();
        }
    }
});

/**
 * @private static Create our own proxy element element. So it will be the same same size on all browsers, we won't use borders. Instead we use a background color.
 */
L5.SplitBar.createProxy = function(dir){
    var proxy = new L5.Element(document.createElement("div"));
    proxy.unselectable();
    var cls = 'l-splitbar-proxy';
    proxy.addClass(cls + ' ' + (dir == L5.SplitBar.HORIZONTAL ? cls +'-h' : cls + '-v'));
    document.body.appendChild(proxy.dom);
    return proxy.dom;
};

/** 
 * @class L5.SplitBar.BasicLayoutAdapter
 * Default Adapter. It assumes the splitter and resizing element are not positioned
 * elements and only gets/sets the width of the element. Generally used for table based layouts.
 */
L5.SplitBar.BasicLayoutAdapter = function(){
};

L5.SplitBar.BasicLayoutAdapter.prototype = {
    // do nothing for now
    init : function(s){
    
    },
    /**
     * Called before drag operations to get the current size of the resizing element. 
     * @param {L5.SplitBar} s The SplitBar using this adapter
     */
     getElementSize : function(s){
        if(s.orientation == L5.SplitBar.HORIZONTAL){
            return s.resizingEl.getWidth();
        }else{
            return s.resizingEl.getHeight();
        }
    },
    
    /**
     * Called after drag operations to set the size of the resizing element.
     * @param {L5.SplitBar} s The SplitBar using this adapter
     * @param {Number} newSize The new size to set
     * @param {Function} onComplete A function to be invoked when resizing is complete
     */
    setElementSize : function(s, newSize, onComplete){
        if(s.orientation == L5.SplitBar.HORIZONTAL){
            if(!s.animate){
                s.resizingEl.setWidth(newSize);
                if(onComplete){
                    onComplete(s, newSize);
                }
            }else{
                s.resizingEl.setWidth(newSize, true, .1, onComplete, 'easeOut');
            }
        }else{
            
            if(!s.animate){
                s.resizingEl.setHeight(newSize);
                if(onComplete){
                    onComplete(s, newSize);
                }
            }else{
                s.resizingEl.setHeight(newSize, true, .1, onComplete, 'easeOut');
            }
        }
    }
};

/** 
 *@class L5.SplitBar.AbsoluteLayoutAdapter
 * @extends L5.SplitBar.BasicLayoutAdapter
 * Adapter that  moves the splitter element to align with the resized sizing element. 
 * Used with an absolute positioned SplitBar.
 * @param {Mixed} container The container that wraps around the absolute positioned content. If it's
 * document.body, make sure you assign an id to the body element.
 */
L5.SplitBar.AbsoluteLayoutAdapter = function(container){
    this.basic = new L5.SplitBar.BasicLayoutAdapter();
    this.container = L5.get(container);
};

L5.SplitBar.AbsoluteLayoutAdapter.prototype = {
    init : function(s){
        this.basic.init(s);
    },
    
    getElementSize : function(s){
        return this.basic.getElementSize(s);
    },
    
    setElementSize : function(s, newSize, onComplete){
        this.basic.setElementSize(s, newSize, this.moveSplitter.createDelegate(this, [s]));
    },
    
    moveSplitter : function(s){
        var yes = L5.SplitBar;
        switch(s.placement){
            case yes.LEFT:
                s.el.setX(s.resizingEl.getRight());
                break;
            case yes.RIGHT:
                s.el.setStyle("right", (this.container.getWidth() - s.resizingEl.getLeft()) + "px");
                break;
            case yes.TOP:
                s.el.setY(s.resizingEl.getBottom());
                break;
            case yes.BOTTOM:
                s.el.setY(s.resizingEl.getTop() - s.el.getHeight());
                break;
        }
    }
};

/**
 * Orientation constant - Create a vertical SplitBar
 * @static
 * @type Number
 */
L5.SplitBar.VERTICAL = 1;

/**
 * Orientation constant - Create a horizontal SplitBar
 * @static
 * @type Number
 */
L5.SplitBar.HORIZONTAL = 2;

/**
 * Placement constant - The resizing element is to the left of the splitter element
 * @static
 * @type Number
 */
L5.SplitBar.LEFT = 1;

/**
 * Placement constant - The resizing element is to the right of the splitter element
 * @static
 * @type Number
 */
L5.SplitBar.RIGHT = 2;

/**
 * Placement constant - The resizing element is positioned above the splitter element
 * @static
 * @type Number
 */
L5.SplitBar.TOP = 3;

/**
 * Placement constant - The resizing element is positioned under splitter element
 * @static
 * @type Number
 */
L5.SplitBar.BOTTOM = 4;
