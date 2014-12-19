/* // Internal developer documentation -- will not show up in API docs
 * @class L5.dd.PanelProxy
 * A custom drag proxy implementation specific to {@link L5.Panel}s. This class is primarily used internally
 * for the Panel's drag drop implementation, and should never need to be created directly.
 * @constructor
 * @param panel The {@link L5.Panel} to proxy for
 * @param config Configuration options
 */
L5.dd.PanelProxy = function(panel, config){
    this.panel = panel;
    this.id = this.panel.id +'-ddproxy';
    L5.apply(this, config);
};

L5.dd.PanelProxy.prototype = {
    /**
     * @cfg {Boolean} insertProxy True to insert a placeholder proxy element while dragging the panel,
      * false to drag with no proxy (defaults to true).
     */
    insertProxy : true,

    // private overrides
    setStatus : L5.emptyFn,
    reset : L5.emptyFn,
    update : L5.emptyFn,
    stop : L5.emptyFn,
    sync: L5.emptyFn,

    /**
     * Gets the proxy's element
     * @return {Element} The proxy's element
     */
    getEl : function(){
        return this.ghost;
    },

    /**
     * Gets the proxy's ghost element
     * @return {Element} The proxy's ghost element
     */
    getGhost : function(){
        return this.ghost;
    },

    /**
     * Gets the proxy's element
     * @return {Element} The proxy's element
     */
    getProxy : function(){
        return this.proxy;
    },

    /**
     * Hides the proxy
     */
    hide : function(){
        if(this.ghost){
            if(this.proxy){
                this.proxy.remove();
                delete this.proxy;
            }
            this.panel.el.dom.style.display = '';
            this.ghost.remove();
            delete this.ghost;
        }
    },

    /**
     * Shows the proxy
     */
    show : function(){
        if(!this.ghost){
            this.ghost = this.panel.createGhost(undefined, undefined, L5.getBody());
            this.ghost.setXY(this.panel.el.getXY())
            if(this.insertProxy){
                this.proxy = this.panel.el.insertSibling({cls:'l-panel-dd-spacer'});
                this.proxy.setSize(this.panel.getSize());
            }
            this.panel.el.dom.style.display = 'none';
        }
    },

    // private
    repair : function(xy, callback, scope){
        this.hide();
        if(typeof callback == "function"){
            callback.call(scope || this);
        }
    },

    /**
     * Moves the proxy to a different position in the DOM.  This is typically called while dragging the Panel
     * to keep the proxy sync'd to the Panel's location.
     * @param {HTMLElement} parentNode The proxy's parent DOM node
     * @param {HTMLElement} before (optional) The sibling node before which the proxy should be inserted (defaults
     * to the parent's last child if not specified)
     */
    moveProxy : function(parentNode, before){
        if(this.proxy){
            parentNode.insertBefore(this.proxy.dom, before);
        }
    }
};

// private - DD implementation for Panels
L5.Panel.DD = function(panel, cfg){
    this.panel = panel;
    this.dragData = {panel: panel};
    this.proxy = new L5.dd.PanelProxy(panel, cfg);
    L5.Panel.DD.superclass.constructor.call(this, panel.el, cfg);
    var h = panel.header;
    if(h){
        this.setHandleElId(h.id);
    }
    (h ? h : this.panel.body).setStyle('cursor', 'move');
    this.scroll = false;
};

L5.extend(L5.Panel.DD, L5.dd.DragSource, {
    showFrame: L5.emptyFn,
    startDrag: L5.emptyFn,
    b4StartDrag: function(x, y) {
        this.proxy.show();
    },
    b4MouseDown: function(e) {
        var x = e.getPageX();
        var y = e.getPageY();
        this.autoOffset(x, y);
    },
    onInitDrag : function(x, y){
        this.onStartDrag(x, y);
        return true;
    },
    createFrame : L5.emptyFn,
    getDragEl : function(e){
        return this.proxy.ghost.dom;
    },
    endDrag : function(e){
        this.proxy.hide();
        this.panel.saveState();
    },

    autoOffset : function(x, y) {
        x -= this.startPageX;
        y -= this.startPageY;
        this.setDelta(x, y);
    }
});