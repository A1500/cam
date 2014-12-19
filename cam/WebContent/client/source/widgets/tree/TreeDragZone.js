/**
 * @class L5.tree.TreeDragZone
 * @extends L5.dd.DragZone
 * @constructor
 * @param {String/HTMLElement/Element} tree The {@link L5.tree.TreePanel} for which to enable dragging
 * @param {Object} config
 */
if(L5.dd.DragZone){
L5.tree.TreeDragZone = function(tree, config){
    L5.tree.TreeDragZone.superclass.constructor.call(this, tree.getTreeEl(), config);
    /**
    * The TreePanel for this drag zone
    * @type L5.tree.TreePanel
    * @property
    */
    this.tree = tree;
};

L5.extend(L5.tree.TreeDragZone, L5.dd.DragZone, {
    /**
     * @cfg {String} ddGroup
     * A named drag drop group to which this object belongs.  If a group is specified, then this object will only
     * interact with other drag drop objects in the same group (defaults to 'TreeDD').
     */
    ddGroup : "TreeDD",

    // private
    onBeforeDrag : function(data, e){
        var n = data.node;
        return n && n.draggable && !n.disabled;
    },

    // private
    onInitDrag : function(e){
        var data = this.dragData;
        this.tree.getSelectionModel().select(data.node);
        this.tree.eventModel.disable();
        this.proxy.update("");
        data.node.ui.appendDDGhost(this.proxy.ghost.dom);
        this.tree.fireEvent("startdrag", this.tree, data.node, e);
    },

    // private
    getRepairXY : function(e, data){
        return data.node.ui.getDDRepairXY();
    },

    // private
    onEndDrag : function(data, e){
        this.tree.eventModel.enable.defer(100, this.tree.eventModel);
        this.tree.fireEvent("enddrag", this.tree, data.node, e);
    },

    // private
    onValidDrop : function(dd, e, id){
        this.tree.fireEvent("dragdrop", this.tree, this.dragData.node, dd, e);
        this.hideProxy();
    },

    // private
    beforeInvalidDrop : function(e, id){
        // this scrolls the original position back into view
        var sm = this.tree.getSelectionModel();
        sm.clearSelections();
        sm.select(this.dragData.node);
    },
    
    // private
    afterRepair : function(){
        if (L5.enableFx && this.tree.hlDrop) {
            L5.Element.fly(this.dragData.ddel).highlight(this.hlColor || "c3daf9");
        }
        this.dragging = false;
    }
});
}