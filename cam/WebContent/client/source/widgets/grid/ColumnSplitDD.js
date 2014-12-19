// private
// This is a support class used internally by the Grid components
L5.grid.SplitDragZone = function(grid, hd, hd2){
    this.grid = grid;
    this.view = grid.getView();
    this.proxy = this.view.resizeProxy;
    L5.grid.SplitDragZone.superclass.constructor.call(this, hd,
        "gridSplitters" + this.grid.getGridEl().id, {
        dragElId : L5.id(this.proxy.dom), resizeFrame:false
    });
    this.setHandleElId(L5.id(hd));
    this.setOuterHandleElId(L5.id(hd2));
    this.scroll = false;
};
L5.extend(L5.grid.SplitDragZone, L5.dd.DDProxy, {
    fly: L5.Element.fly,

    b4StartDrag : function(x, y){
        this.view.headersDisabled = true;
        this.proxy.setHeight(this.view.mainWrap.getHeight());
        var w = this.cm.getColumnWidth(this.cellIndex);
        var minw = Math.max(w-this.grid.minColumnWidth, 0);
        this.resetConstraints();
        this.setXConstraint(minw, 1000);
        this.setYConstraint(0, 0);
        this.minX = x - minw;
        this.maxX = x + 1000;
        this.startPos = x;
        L5.dd.DDProxy.prototype.b4StartDrag.call(this, x, y);
    },


    handleMouseDown : function(e){
        ev = L5.EventObject.setEvent(e);
        var t = this.fly(ev.getTarget());
        if(t.hasClass("l-grid-split")){
            this.cellIndex = this.view.getCellIndex(t.dom);
            this.split = t.dom;
            this.cm = this.grid.colModel;
            if(this.cm.isResizable(this.cellIndex) && !this.cm.isFixed(this.cellIndex)){
                L5.grid.SplitDragZone.superclass.handleMouseDown.apply(this, arguments);
            }
        }
    },

    endDrag : function(e){
        this.view.headersDisabled = false;
        var endX = Math.max(this.minX, L5.lib.Event.getPageX(e));
        var diff = endX - this.startPos;
        this.view.onColumnSplitterMoved(this.cellIndex, this.cm.getColumnWidth(this.cellIndex)+diff);
    },

    autoOffset : function(){
        this.setDelta(0,0);
    }
});