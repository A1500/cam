L5.tree.TreeEventModel = function(tree){
    this.tree = tree;
    this.tree.on('render', this.initEvents, this);
}

L5.tree.TreeEventModel.prototype = {
    initEvents : function(){
        var el = this.tree.getTreeEl();
        el.on('click', this.delegateClick, this);
        if(this.tree.trackMouseOver !== false){
            el.on('mouseover', this.delegateOver, this);
            el.on('mouseout', this.delegateOut, this);
        }
        el.on('dblclick', this.delegateDblClick, this);
        el.on('contextmenu', this.delegateContextMenu, this);
    },

    getNode : function(e){
        var t;
        if(t = e.getTarget('.l-tree-node-el', 10)){
            var id = L5.fly(t, '_treeEvents').getAttributeNS('L5', 'tree-node-id');
            if(id){
                return this.tree.getNodeById(id);
            }
        }
        return null;
    },

    getNodeTarget : function(e){
        var t = e.getTarget('.l-tree-node-icon', 1);
        if(!t){
            t = e.getTarget('.l-tree-node-el', 6);
        }
        return t;
    },

    delegateOut : function(e, t){
        if(!this.beforeEvent(e)){
            return;
        }
        if(e.getTarget('.l-tree-ec-icon', 1)){
            var n = this.getNode(e);
            this.onIconOut(e, n);
            if(n == this.lastEcOver){
                delete this.lastEcOver;
            }
        }
        if((t = this.getNodeTarget(e)) && !e.within(t, true)){
            this.onNodeOut(e, this.getNode(e));
        }
    },

    delegateOver : function(e, t){
        if(!this.beforeEvent(e)){
            return;
        }
        if(this.lastEcOver){ // prevent hung highlight
            this.onIconOut(e, this.lastEcOver);
            delete this.lastEcOver;
        }
        if(e.getTarget('.l-tree-ec-icon', 1)){
            this.lastEcOver = this.getNode(e);
            this.onIconOver(e, this.lastEcOver);
        }
        if(t = this.getNodeTarget(e)){
            this.onNodeOver(e, this.getNode(e));
        }
    },

    delegateClick : function(e, t){
        if(!this.beforeEvent(e)){
            return;
        }

        if(e.getTarget('input[type=checkbox]', 1)){
            this.onCheckboxClick(e, this.getNode(e));
        }
        else if(e.getTarget('.l-tree-ec-icon', 1)){
            this.onIconClick(e, this.getNode(e));
        }
        else if(this.getNodeTarget(e)){
            this.onNodeClick(e, this.getNode(e));
        }
    },

    delegateDblClick : function(e, t){
        if(this.beforeEvent(e) && this.getNodeTarget(e)){
            this.onNodeDblClick(e, this.getNode(e));
        }
    },

    delegateContextMenu : function(e, t){
        if(this.beforeEvent(e) && this.getNodeTarget(e)){
            this.onNodeContextMenu(e, this.getNode(e));
        }
    },

    onNodeClick : function(e, node){
        node.ui.onClick(e);
    },

    onNodeOver : function(e, node){
        node.ui.onOver(e);
    },

    onNodeOut : function(e, node){
        node.ui.onOut(e);
    },

    onIconOver : function(e, node){
        node.ui.addClass('l-tree-ec-over');
    },

    onIconOut : function(e, node){
        node.ui.removeClass('l-tree-ec-over');
    },

    onIconClick : function(e, node){
        node.ui.ecClick(e);
    },

    onCheckboxClick : function(e, node){
        node.ui.onCheckChange(e);
    },

    onNodeDblClick : function(e, node){
        node.ui.onDblClick(e);
    },

    onNodeContextMenu : function(e, node){
        node.ui.onContextMenu(e);
    },

    beforeEvent : function(e){
        if(this.disabled){
            e.stopEvent();
            return false;
        }
        return true;
    },

    disable: function(){
        this.disabled = true;
    },

    enable: function(){
        this.disabled = false;
    }
};