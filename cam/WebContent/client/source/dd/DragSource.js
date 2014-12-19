/**
 * @class L5.dd.DragSource
 * @extends L5.dd.DDProxy
 * A simple class that provides the basic implementation needed to make any element draggable.
 * @constructor
 * @param {Mixed} el The container element
 * @param {Object} config
 */
L5.dd.DragSource = function(el, config){
    this.el = L5.get(el);
    if(!this.dragData){
        this.dragData = {};
    }
    
    L5.apply(this, config);
    
    if(!this.proxy){
        this.proxy = new L5.dd.StatusProxy();
    }
    L5.dd.DragSource.superclass.constructor.call(this, this.el.dom, this.ddGroup || this.group, 
          {dragElId : this.proxy.id, resizeFrame: false, isTarget: false, scroll: this.scroll === true});
    
    this.dragging = false;
};

L5.extend(L5.dd.DragSource, L5.dd.DDProxy, {
    /**
     * @cfg {String} ddGroup
     * A named drag drop group to which this object belongs.  If a group is specified, then this object will only
     * interact with other drag drop objects in the same group (defaults to undefined).
     */
    /**
     * @cfg {String} dropAllowed
     * The CSS class returned to the drag source when drop is allowed (defaults to "l-dd-drop-ok").
     */
    dropAllowed : "l-dd-drop-ok",
    /**
     * @cfg {String} dropNotAllowed
     * The CSS class returned to the drag source when drop is not allowed (defaults to "l-dd-drop-nodrop").
     */
    dropNotAllowed : "l-dd-drop-nodrop",

    /**
     * Returns the data object associated with this drag source
     * @return {Object} data An object containing arbitrary data
     */
    getDragData : function(e){
        return this.dragData;
    },

    // private
    onDragEnter : function(e, id){
        var target = L5.dd.DragDropMgr.getDDById(id);
        this.cachedTarget = target;
        if(this.beforeDragEnter(target, e, id) !== false){
            if(target.isNotifyTarget){
                var status = target.notifyEnter(this, e, this.dragData);
                this.proxy.setStatus(status);
            }else{
                this.proxy.setStatus(this.dropAllowed);
            }
            
            if(this.afterDragEnter){
                /**
                 * An empty function by default, but provided so that you can perform a custom action
                 * when the dragged item enters the drop target by providing an implementation.
                 * @param {L5.dd.DragDrop} target The drop target
                 * @param {Event} e The event object
                 * @param {String} id The id of the dragged element
                 * @method afterDragEnter
                 */
                this.afterDragEnter(target, e, id);
            }
        }
    },

    /**
     * An empty function by default, but provided so that you can perform a custom action
     * before the dragged item enters the drop target and optionally cancel the onDragEnter.
     * @param {L5.dd.DragDrop} target The drop target
     * @param {Event} e The event object
     * @param {String} id The id of the dragged element
     * @return {Boolean} isValid True if the drag event is valid, else false to cancel
     */
    beforeDragEnter : function(target, e, id){
        return true;
    },

    // private
    alignElWithMouse: function() {
        L5.dd.DragSource.superclass.alignElWithMouse.apply(this, arguments);
        this.proxy.sync();
    },

    // private
    onDragOver : function(e, id){
        var target = this.cachedTarget || L5.dd.DragDropMgr.getDDById(id);
        if(this.beforeDragOver(target, e, id) !== false){
            if(target.isNotifyTarget){
                var status = target.notifyOver(this, e, this.dragData);
                this.proxy.setStatus(status);
            }

            if(this.afterDragOver){
                /**
                 * An empty function by default, but provided so that you can perform a custom action
                 * while the dragged item is over the drop target by providing an implementation.
                 * @param {L5.dd.DragDrop} target The drop target
                 * @param {Event} e The event object
                 * @param {String} id The id of the dragged element
                 * @method afterDragOver
                 */
                this.afterDragOver(target, e, id);
            }
        }
    },

    /**
     * An empty function by default, but provided so that you can perform a custom action
     * while the dragged item is over the drop target and optionally cancel the onDragOver.
     * @param {L5.dd.DragDrop} target The drop target
     * @param {Event} e The event object
     * @param {String} id The id of the dragged element
     * @return {Boolean} isValid True if the drag event is valid, else false to cancel
     */
    beforeDragOver : function(target, e, id){
        return true;
    },

    // private
    onDragOut : function(e, id){
        var target = this.cachedTarget || L5.dd.DragDropMgr.getDDById(id);
        if(this.beforeDragOut(target, e, id) !== false){
            if(target.isNotifyTarget){
                target.notifyOut(this, e, this.dragData);
            }
            this.proxy.reset();
            if(this.afterDragOut){
                /**
                 * An empty function by default, but provided so that you can perform a custom action
                 * after the dragged item is dragged out of the target without dropping.
                 * @param {L5.dd.DragDrop} target The drop target
                 * @param {Event} e The event object
                 * @param {String} id The id of the dragged element
                 * @method afterDragOut
                 */
                this.afterDragOut(target, e, id);
            }
        }
        this.cachedTarget = null;
    },

    /**
     * An empty function by default, but provided so that you can perform a custom action before the dragged
     * item is dragged out of the target without dropping, and optionally cancel the onDragOut.
     * @param {L5.dd.DragDrop} target The drop target
     * @param {Event} e The event object
     * @param {String} id The id of the dragged element
     * @return {Boolean} isValid True if the drag event is valid, else false to cancel
     */
    beforeDragOut : function(target, e, id){
        return true;
    },
    
    // private
    onDragDrop : function(e, id){
        var target = this.cachedTarget || L5.dd.DragDropMgr.getDDById(id);
        if(this.beforeDragDrop(target, e, id) !== false){
            if(target.isNotifyTarget){
                if(target.notifyDrop(this, e, this.dragData)){ // valid drop?
                    this.onValidDrop(target, e, id);
                }else{
                    this.onInvalidDrop(target, e, id);
                }
            }else{
                this.onValidDrop(target, e, id);
            }
            
            if(this.afterDragDrop){
                /**
                 * An empty function by default, but provided so that you can perform a custom action
                 * after a valid drag drop has occurred by providing an implementation.
                 * @param {L5.dd.DragDrop} target The drop target
                 * @param {Event} e The event object
                 * @param {String} id The id of the dropped element
                 * @method afterDragDrop
                 */
                this.afterDragDrop(target, e, id);
            }
        }
        delete this.cachedTarget;
    },

    /**
     * An empty function by default, but provided so that you can perform a custom action before the dragged
     * item is dropped onto the target and optionally cancel the onDragDrop.
     * @param {L5.dd.DragDrop} target The drop target
     * @param {Event} e The event object
     * @param {String} id The id of the dragged element
     * @return {Boolean} isValid True if the drag drop event is valid, else false to cancel
     */
    beforeDragDrop : function(target, e, id){
        return true;
    },

    // private
    onValidDrop : function(target, e, id){
        this.hideProxy();
        if(this.afterValidDrop){
            /**
             * An empty function by default, but provided so that you can perform a custom action
             * after a valid drop has occurred by providing an implementation.
             * @param {Object} target The target DD 
             * @param {Event} e The event object
             * @param {String} id The id of the dropped element
             * @method afterInvalidDrop
             */
            this.afterValidDrop(target, e, id);
        }
    },

    // private
    getRepairXY : function(e, data){
        return this.el.getXY();  
    },

    // private
    onInvalidDrop : function(target, e, id){
        this.beforeInvalidDrop(target, e, id);
        if(this.cachedTarget){
            if(this.cachedTarget.isNotifyTarget){
                this.cachedTarget.notifyOut(this, e, this.dragData);
            }
            this.cacheTarget = null;
        }
        this.proxy.repair(this.getRepairXY(e, this.dragData), this.afterRepair, this);

        if(this.afterInvalidDrop){
            /**
             * An empty function by default, but provided so that you can perform a custom action
             * after an invalid drop has occurred by providing an implementation.
             * @param {Event} e The event object
             * @param {String} id The id of the dropped element
             * @method afterInvalidDrop
             */
            this.afterInvalidDrop(e, id);
        }
    },

    // private
    afterRepair : function(){
        if(L5.enableFx){
            this.el.highlight(this.hlColor || "c3daf9");
        }
        this.dragging = false;
    },

    /**
     * An empty function by default, but provided so that you can perform a custom action after an invalid
     * drop has occurred.
     * @param {L5.dd.DragDrop} target The drop target
     * @param {Event} e The event object
     * @param {String} id The id of the dragged element
     * @return {Boolean} isValid True if the invalid drop should proceed, else false to cancel
     */
    beforeInvalidDrop : function(target, e, id){
        return true;
    },

    // private
    handleMouseDown : function(e){
        if(this.dragging) {
            return;
        }
        var data = this.getDragData(e);
        if(data && this.onBeforeDrag(data, e) !== false){
            this.dragData = data;
            this.proxy.stop();
            L5.dd.DragSource.superclass.handleMouseDown.apply(this, arguments);
        } 
    },

    /**
     * An empty function by default, but provided so that you can perform a custom action before the initial
     * drag event begins and optionally cancel it.
     * @param {Object} data An object containing arbitrary data to be shared with drop targets
     * @param {Event} e The event object
     * @return {Boolean} isValid True if the drag event is valid, else false to cancel
     */
    onBeforeDrag : function(data, e){
        return true;
    },

    /**
     * An empty function by default, but provided so that you can perform a custom action once the initial
     * drag event has begun.  The drag cannot be canceled from this function.
     * @param {Number} x The x position of the click on the dragged object
     * @param {Number} y The y position of the click on the dragged object
     */
    onStartDrag : L5.emptyFn,

    // private override
    startDrag : function(x, y){
        this.proxy.reset();
        this.dragging = true;
        this.proxy.update("");
        this.onInitDrag(x, y);
        this.proxy.show();
    },

    // private
    onInitDrag : function(x, y){
        var clone = this.el.dom.cloneNode(true);
        clone.id = L5.id(); // prevent duplicate ids
        this.proxy.update(clone);
        this.onStartDrag(x, y);
        return true;
    },

    /**
     * Returns the drag source's underlying {@link L5.dd.StatusProxy}
     * @return {L5.dd.StatusProxy} proxy The StatusProxy
     */
    getProxy : function(){
        return this.proxy;  
    },

    /**
     * Hides the drag source's {@link L5.dd.StatusProxy}
     */
    hideProxy : function(){
        this.proxy.hide();  
        this.proxy.reset(true);
        this.dragging = false;
    },

    // private
    triggerCacheRefresh : function(){
        L5.dd.DDM.refreshCache(this.groups);
    },

    // private - override to prevent hiding
    b4EndDrag: function(e) {
    },

    // private - override to prevent moving
    endDrag : function(e){
        this.onEndDrag(this.dragData, e);
    },

    // private
    onEndDrag : function(data, e){
    },
    
    // private - pin to cursor
    autoOffset : function(x, y) {
        this.setDelta(-12, -20);
    }    
});