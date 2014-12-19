/**
 * @class L5.tree.TreeNodeUI
 * This class provides the default UI implementation for L5 TreeNodes.
 * The TreeNode UI implementation is separate from the
 * tree implementation, and allows customizing of the appearance of
 * tree nodes.<br>
 * <p>
 * If you are customizing the Tree's user interface, you
 * may need to extend this class, but you should never need to instantiate this class.<br>
 * <p>
 * This class provides access to the user interface components of an L5 TreeNode, through
 * {@link L5.tree.TreeNode#getUI}
 */
L5.tree.TreeNodeUI = function(node){
    this.node = node;
    this.rendered = false;
    this.animating = false;
    this.wasLeaf = true;
    this.ecc = 'l-tree-ec-icon l-tree-elbow';
    this.emptyIcon = L5.BLANK_IMAGE_URL;
};

L5.tree.TreeNodeUI.prototype = {
    // private
    removeChild : function(node){
        if(this.rendered){
            this.ctNode.removeChild(node.ui.getEl());
        } 
    },

    // private
    beforeLoad : function(){
         this.addClass("l-tree-node-loading");
    },

    // private
    afterLoad : function(){
         this.removeClass("l-tree-node-loading");
    },

    // private
    onTextChange : function(node, text, oldText){
        if(this.rendered){
            this.textNode.innerHTML = text;
        }
    },

    // private
    onDisableChange : function(node, state){
        this.disabled = state;
		if (this.checkbox) {
			this.checkbox.disabled = state;
		}        
        if(state){
            this.addClass("l-tree-node-disabled");
        }else{
            this.removeClass("l-tree-node-disabled");
        } 
    },

    // private
    onSelectedChange : function(state){
        if(state){
            this.focus();
            this.addClass("l-tree-selected");
        }else{
            //this.blur();
            this.removeClass("l-tree-selected");
        }
    },

    // private
    onMove : function(tree, node, oldParent, newParent, index, refNode){
        this.childIndent = null;
        if(this.rendered){
            var targetNode = newParent.ui.getContainer();
            if(!targetNode){//target not rendered
                this.holder = document.createElement("div");
                this.holder.appendChild(this.wrap);
                return;
            }
            var insertBefore = refNode ? refNode.ui.getEl() : null;
            if(insertBefore){
                targetNode.insertBefore(this.wrap, insertBefore);
            }else{
                targetNode.appendChild(this.wrap);
            }
            this.node.renderIndent(true);
        }
    },

/**
 * Adds one or more CSS classes to the node's UI element.
 * Duplicate classes are automatically filtered out.
 * @param {String/Array} className The CSS class to add, or an array of classes
 */
    addClass : function(cls){
        if(this.elNode){
            L5.fly(this.elNode).addClass(cls);
        }
    },

/**
 * Removes one or more CSS classes from the node's UI element.
 * @param {String/Array} className The CSS class to remove, or an array of classes
 */
    removeClass : function(cls){
        if(this.elNode){
            L5.fly(this.elNode).removeClass(cls);  
        }
    },

    // private
    remove : function(){
        if(this.rendered){
            this.holder = document.createElement("div");
            this.holder.appendChild(this.wrap);
        }  
    },

    // private
    fireEvent : function(){
        return this.node.fireEvent.apply(this.node, arguments);  
    },

    // private
    initEvents : function(){
        this.node.on("move", this.onMove, this);

        if(this.node.disabled){
            this.addClass("l-tree-node-disabled");
			if (this.checkbox) {
				this.checkbox.disabled = true;
			}            
        }
        if(this.node.hidden){
            this.hide();
        }
        var ot = this.node.getOwnerTree();
        var dd = ot.enableDD || ot.enableDrag || ot.enableDrop;
        if(dd && (!this.node.isRoot || ot.rootVisible)){
            L5.dd.Registry.register(this.elNode, {
                node: this.node,
                handles: this.getDDHandles(),
                isHandle: false
            });
        }
    },

    // private
    getDDHandles : function(){
        return [this.iconNode, this.textNode, this.elNode];
    },

/**
 * Hides this node.
 */
    hide : function(){
        this.node.hidden = true;
        if(this.wrap){
            this.wrap.style.display = "none";
        }
    },

/**
 * Shows this node.
 */
    show : function(){
        this.node.hidden = false;
        if(this.wrap){
            this.wrap.style.display = "";
        } 
    },

    // private
    onContextMenu : function(e){
        if (this.node.hasListener("contextmenu") || this.node.getOwnerTree().hasListener("contextmenu")) {
            e.preventDefault();
            this.focus();
            this.fireEvent("contextmenu", this.node, e);
        }
    },

    // private
    onClick : function(e){
        if(this.dropping){
            e.stopEvent();
            return;
        }
        if(this.fireEvent("beforeclick", this.node, e) !== false){
            var a = e.getTarget('a');
            if(!this.disabled && this.node.attributes.href && a){
                this.fireEvent("click", this.node, e);
                return;
            }else if(a && e.ctrlKey){
                e.stopEvent();
            }
            e.preventDefault();
            if(this.disabled){
                return;
            }

            if(this.node.attributes.singleClickExpand && !this.animating && this.node.isExpandable()){
                this.node.toggle();
            }

            this.fireEvent("click", this.node, e);
        }else{
            e.stopEvent();
        }
    },

    // private
    onDblClick : function(e){
        e.preventDefault();
        if(this.disabled){
            return;
        }
        if(this.checkbox){
            this.toggleCheck();
        }
        if(!this.animating && this.node.isExpandable()){
            this.node.toggle();
        }
        this.fireEvent("dblclick", this.node, e);
    },

    onOver : function(e){
        this.addClass('l-tree-node-over');
    },

    onOut : function(e){
        this.removeClass('l-tree-node-over');
    },

    // private
    onCheckChange : function(){
        var checked = this.checkbox.checked;
		// fix for IE6
		this.checkbox.defaultChecked = checked;
        this.node.attributes.checked = checked;
        this.fireEvent('checkchange', this.node, checked);
    },

    // private
    ecClick : function(e){
        if(!this.animating && this.node.isExpandable()){
            this.node.toggle();
        }
    },

    // private
    startDrop : function(){
        this.dropping = true;
    },
    
    // delayed drop so the click event doesn't get fired on a drop
    endDrop : function(){ 
       setTimeout(function(){
           this.dropping = false;
       }.createDelegate(this), 50); 
    },

    // private
    expand : function(){
        this.updateExpandIcon();
        this.ctNode.style.display = "";
    },

    // private
    focus : function(){
        if(!this.node.preventHScroll){
            try{this.anchor.focus();
            }catch(e){}
        }else{
            try{
                var noscroll = this.node.getOwnerTree().getTreeEl().dom;
                var l = noscroll.scrollLeft;
                this.anchor.focus();
                noscroll.scrollLeft = l;
            }catch(e){}
        }
    },

/**
 * Sets the checked status of the tree node to the passed value, or, if no value was passed,
 * toggles the checked status. If the node was rendered with no checkbox, this has no effect.
 * @param {Boolean} (optional) The new checked status.
 */
    toggleCheck : function(value){
        var cb = this.checkbox;
        if(cb){
            cb.checked = (value === undefined ? !cb.checked : value);
            this.onCheckChange();
        }
    },

    // private
    blur : function(){
        try{
            this.anchor.blur();
        }catch(e){} 
    },

    // private
    animExpand : function(callback){
        var ct = L5.get(this.ctNode);
        ct.stopFx();
        if(!this.node.isExpandable()){
            this.updateExpandIcon();
            this.ctNode.style.display = "";
            L5.callback(callback);
            return;
        }
        this.animating = true;
        this.updateExpandIcon();
        
        ct.slideIn('t', {
           callback : function(){
               this.animating = false;
               L5.callback(callback);
            },
            scope: this,
            duration: this.node.ownerTree.duration || .25
        });
    },

    // private
    highlight : function(){
        var tree = this.node.getOwnerTree();
        L5.fly(this.wrap).highlight(
            tree.hlColor || "C3DAF9",
            {endColor: tree.hlBaseColor}
        );
    },

    // private
    collapse : function(){
        this.updateExpandIcon();
        this.ctNode.style.display = "none";
    },

    // private
    animCollapse : function(callback){
        var ct = L5.get(this.ctNode);
        ct.enableDisplayMode('block');
        ct.stopFx();

        this.animating = true;
        this.updateExpandIcon();

        ct.slideOut('t', {
            callback : function(){
               this.animating = false;
               L5.callback(callback);
            },
            scope: this,
            duration: this.node.ownerTree.duration || .25
        });
    },

    // private
    getContainer : function(){
        return this.ctNode;  
    },

    // private
    getEl : function(){
        return this.wrap;  
    },

    // private
    appendDDGhost : function(ghostNode){
        ghostNode.appendChild(this.elNode.cloneNode(true));
    },

    // private
    getDDRepairXY : function(){
        return L5.lib.Dom.getXY(this.iconNode);
    },

    // private
    onRender : function(){
        this.render();    
    },

    // private
    render : function(bulkRender){
        var n = this.node, a = n.attributes;
        var targetNode = n.parentNode ? 
              n.parentNode.ui.getContainer() : n.ownerTree.innerCt.dom;
        
        if(!this.rendered){
            this.rendered = true;

            this.renderElements(n, a, targetNode, bulkRender);

            if(a.qtip){
               if(this.textNode.setAttributeNS){
                   this.textNode.setAttributeNS("L5", "qtip", a.qtip);
                   if(a.qtipTitle){
                       this.textNode.setAttributeNS("L5", "qtitle", a.qtipTitle);
                   }
               }else{
                   this.textNode.setAttribute("L5:qtip", a.qtip);
                   if(a.qtipTitle){
                       this.textNode.setAttribute("L5:qtitle", a.qtipTitle);
                   }
               } 
            }else if(a.qtipCfg){
                a.qtipCfg.target = L5.id(this.textNode);
                L5.QuickTips.register(a.qtipCfg);
            }
            this.initEvents();
            if(!this.node.expanded){
                this.updateExpandIcon(true);
            }
        }else{
            if(bulkRender === true) {
                targetNode.appendChild(this.wrap);
            }
        }
    },

    // private
    renderElements : function(n, a, targetNode, bulkRender){
        // add some indent caching, this helps performance when rendering a large tree
        this.indentMarkup = n.parentNode ? n.parentNode.ui.getChildIndent() : '';

        var cb = typeof a.checked == 'boolean';

        var href = a.href ? a.href : L5.isGecko ? "" : "#";
        var buf = ['<li class="l-tree-node"><div L5:tree-node-id="',n.id,'" class="l-tree-node-el l-tree-node-leaf l-unselectable ', a.cls,'" unselectable="on">',
            '<span class="l-tree-node-indent">',this.indentMarkup,"</span>",
            '<img src="', this.emptyIcon, '" class="l-tree-ec-icon l-tree-elbow" />',
            '<img src="', a.icon || this.emptyIcon, '" class="l-tree-node-icon',(a.icon ? " l-tree-node-inline-icon" : ""),(a.iconCls ? " "+a.iconCls : ""),'" unselectable="on" />',
            cb ? ('<input class="l-tree-node-cb" type="checkbox" ' + (a.checked ? 'checked="checked" />' : '/>')) : '',
            '<a hidefocus="on" class="l-tree-node-anchor" href="',href,'" tabIndex="1" ',
             a.hrefTarget ? ' target="'+a.hrefTarget+'"' : "", '><span unselectable="on">',n.text,"</span></a></div>",
            '<ul class="l-tree-node-ct" style="display:none;"></ul>',
            "</li>"].join('');

        var nel;
        if(bulkRender !== true && n.nextSibling && (nel = n.nextSibling.ui.getEl())){
            this.wrap = L5.DomHelper.insertHtml("beforeBegin", nel, buf);
        }else{
            this.wrap = L5.DomHelper.insertHtml("beforeEnd", targetNode, buf);
        }
        
        this.elNode = this.wrap.childNodes[0];
        this.ctNode = this.wrap.childNodes[1];
        var cs = this.elNode.childNodes;
        this.indentNode = cs[0];
        this.ecNode = cs[1];
        this.iconNode = cs[2];
        var index = 3;
        if(cb){
            this.checkbox = cs[3];
			// fix for IE6
			this.checkbox.defaultChecked = this.checkbox.checked;			
            index++;
        }
        this.anchor = cs[index];
        this.textNode = cs[index].firstChild;
    },

/**
 * Returns the &lt;a> element that provides focus for the node's UI.
 * @return {HtmlElement} The DOM anchor element.
 */
    getAnchor : function(){
        return this.anchor;
    },
    
/**
 * Returns the text node.
 * @return {HtmlNode} The DOM text node.
 */
    getTextEl : function(){
        return this.textNode;
    },
    
/**
 * Returns the icon &lt;img> element.
 * @return {HtmlElement} The DOM image element.
 */
    getIconEl : function(){
        return this.iconNode;
    },

/**
 * Returns the checked status of the node. If the node was rendered with no
 * checkbox, it returns false.
 * @return {Boolean} The checked flag.
 */
    isChecked : function(){
        return this.checkbox ? this.checkbox.checked : false; 
    },

    // private
    updateExpandIcon : function(){
        if(this.rendered){
            var n = this.node, c1, c2;
            var cls = n.isLast() ? "l-tree-elbow-end" : "l-tree-elbow";
            if(n.isExpandable()){
                if(n.expanded){
                    cls += "-minus";
                    c1 = "l-tree-node-collapsed";
                    c2 = "l-tree-node-expanded";
                }else{
                    cls += "-plus";
                    c1 = "l-tree-node-expanded";
                    c2 = "l-tree-node-collapsed";
                }
                if(this.wasLeaf){
                    this.removeClass("l-tree-node-leaf");
                    this.wasLeaf = false;
                }
                if(this.c1 != c1 || this.c2 != c2){
                    L5.fly(this.elNode).replaceClass(c1, c2);
                    this.c1 = c1; this.c2 = c2;
                }
            }else{
                if(!this.wasLeaf){
                    L5.fly(this.elNode).replaceClass("l-tree-node-expanded", "l-tree-node-leaf");
                    delete this.c1;
                    delete this.c2;
                    this.wasLeaf = true;
                }
            }
            var ecc = "l-tree-ec-icon "+cls;
            if(this.ecc != ecc){
                this.ecNode.className = ecc;
                this.ecc = ecc;
            }
        }
    },

    // private
    getChildIndent : function(){
        if(!this.childIndent){
            var buf = [];
            var p = this.node;
            while(p){
                if(!p.isRoot || (p.isRoot && p.ownerTree.rootVisible)){
                    if(!p.isLast()) {
                        buf.unshift('<img src="'+this.emptyIcon+'" class="l-tree-elbow-line" />');
                    } else {
                        buf.unshift('<img src="'+this.emptyIcon+'" class="l-tree-icon" />');
                    }
                }
                p = p.parentNode;
            }
            this.childIndent = buf.join("");
        }
        return this.childIndent;
    },

    // private
    renderIndent : function(){
        if(this.rendered){
            var indent = "";
            var p = this.node.parentNode;
            if(p){
                indent = p.ui.getChildIndent();
            }
            if(this.indentMarkup != indent){ // don't rerender if not required
                this.indentNode.innerHTML = indent;
                this.indentMarkup = indent;
            }
            this.updateExpandIcon();
        }
    },

    destroy : function(){
        if(this.elNode){
            L5.dd.Registry.unregister(this.elNode.id);
        }
        delete this.elNode;
        delete this.ctNode;
        delete this.indentNode;
        delete this.ecNode;
        delete this.iconNode;
        delete this.checkbox;
        delete this.anchor;
        delete this.textNode;
        
        if (this.holder){
             delete this.wrap;
             L5.removeNode(this.holder);
             delete this.holder;
        }else{
            L5.removeNode(this.wrap);
            delete this.wrap;
        }
    }
};

/**
 * @class L5.tree.RootTreeNodeUI
 * This class provides the default UI implementation for <b>root</b> L5 TreeNodes.
 * The RootTreeNode UI implementation allows customizing the appearance of the root tree node.<br>
 * <p>
 * If you are customizing the Tree's user interface, you
 * may need to extend this class, but you should never need to instantiate this class.<br>
 */
L5.tree.RootTreeNodeUI = L5.extend(L5.tree.TreeNodeUI, {
    // private
    render : function(){
        if(!this.rendered){
            var targetNode = this.node.ownerTree.innerCt.dom;
            this.node.expanded = true;
            targetNode.innerHTML = '<div class="l-tree-root-node"></div>';
            this.wrap = this.ctNode = targetNode.firstChild;
        }
    },
    collapse : L5.emptyFn,
    expand : L5.emptyFn
});