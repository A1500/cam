//doc
/**
 * @class L5.tree.TreeNodeUI 
 * TreeNodeUI类为TreeNodes提供了默认的视图实现。
 * TreeNode视图实现和Tree的实现是分离的，并且允许自定义TreeNodes的外观。<br>
 * <p>
 * 如果要定义Tree的视图，可能需要继承TreeNodeUI类，但是应该永远不需要实例化这个类。<br>
 * <p>
 * TreeNodeUI类提供了一个访问TreeNode视图的组件，通过
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
            //this.focus();
        	if(L5.fly(this.anchor))//修复setRoot之后，节点丢失导致的this.anchor为null的bug
        		L5.fly(this.anchor).addClass("l-tree-selected");
        }else{
            //this.blur();
        	if(L5.fly(this.anchor))//修复setRoot之后，节点丢失导致的this.anchor为null的bug
        		L5.fly(this.anchor).removeClass("l-tree-selected");
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
 * 为节点视图增加一个或多个CSS类，重复的类会被自动过滤掉。
 * @param {String/Array} className 要增加的CSS类，或类的数组
 */
    addClass : function(cls){
        if(this.elNode){
            L5.fly(this.elNode).addClass(cls);
        }
    },

/**
 * 为节点视图删除一个或多个CSS类。 
 * @param {String/Array} className 要删除的CSS类，或类的数组
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
 * 隐藏这个节点.
 */
    hide : function(){
        this.node.hidden = true;
        if(this.wrap){
            this.wrap.style.display = "none";
        }
    },

/**
 * 显示这个节点.
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
            var href = this.node.attributes.href;
            if(!this.disabled && href && href != '#' && a){
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
        if(this.checkedOnDblClick&&this.checkbox){
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
    
    changeParentNode : function(node,checked,init){
//    	var olds = node.ownerTree.checks;
//    	var index = olds.indexOf(node.record);
    	var cb = node.ui.checkbox;
    	var cn=node.childNodes;//父节点的子节点数组，即兄弟节点数组
    	var hasChecked=false;//是否有被选中的
		var checkedAll=true;//是否全部选中
		var nodeState =  node.ui.checkbox.checked;
    	if(checked){	//判断父节点下的所有节点是否都选中
    		for(var i=0;i<cn.length;i++){
				if(!checkedAll)
					break;
				if(checkedAll)
					checkedAll=cn[i].ui.checkbox ? cn[i].ui.checkbox.checked : false;
			}
    		if(checkedAll){
    			if(cb!=null&&cb!=undefined){
    				cb.indeterminate = false;
    				cb.checked = true;
    				cb.defaultChecked = true;
    				node.attributes.checked = true;
//    				if(index==-1){
//    					olds.push(node.record)
//    				}
    			}
    		}else{
    			if(cb!=null&&cb!=undefined){
    				cb.checked = false;
    				cb.defaultChecked = false;
    				node.attributes.checked = false;
//    				if(index!=-1){
//    					olds.splice(index, 1);//移除
//    				}
    				cb.indeterminate =true;
    			}
    		}//循环更改父节点的状态
    		if(init!=true&&(nodeState!=node.ui.checkbox.checked)){
    			this.fireEvent('checkchange', node, checked);
    		}
    		if(!node.isRoot&&node.changeParent&&node.ui.showType === 'checkbox'&&node.parentNode.ui.checkbox!=null&&node.parentNode.ui.checkbox!=undefined)// 假如父节点的checkbox存在就可以对父节点操作
        		this.changeParentNode(node.parentNode,checked,init);
    	}else{//判断父节点下的子节点有没有选中的
    		for(var i=0;i<cn.length;i++){
				if(hasChecked)
					break;
				if(!hasChecked)
					hasChecked=cn[i].ui.checkbox ? (cn[i].ui.checkbox.checked||cn[i].ui.checkbox.indeterminate) : false;
			}
    		if(hasChecked){
    			if(cb!=null&&cb!=undefined){
    				cb.checked = false;
    				cb.defaultChecked = false;
    				node.attributes.checked = false;
//    				if(index!=-1){
//    					olds.splice(index, 1);//移除
//    				}
    				cb.indeterminate =true;
    			}
    		}else{
    			if(cb!=null&&cb!=undefined){
    				cb.checked = false;
    				cb.defaultChecked = false;
    				node.attributes.checked = false;
//    				if(index!=-1){
//    					olds.splice(index, 1);//移除
//    				}
    				cb.indeterminate = false;
    			}
    		}//循环更改父节点的状态
    		if(init!=true&&(nodeState!=node.ui.checkbox.checked)){
    			this.fireEvent('checkchange', node, checked);
    		}
    		if(!node.isRoot&&node.changeParent&&node.ui.showType === 'checkbox'&&node.parentNode.ui.checkbox!=null&&node.parentNode.ui.checkbox!=undefined)// 假如父节点的checkbox存在就可以对父节点操作
        		this.changeParentNode(node.parentNode,checked,init);
    	}
    },
    // private
    onCheckChange : function(init){
    	var checked = this.checkbox.checked;
    	if(this.node.changeParent&&this.showType === 'checkbox'&&!this.node.isRoot&&this.node.parentNode.ui.checkbox!=null&&this.node.parentNode.ui.checkbox!=undefined)// 假如父节点的checkbox存在就可以对父节点操作
    		this.changeParentNode(this.node.parentNode,checked,init);
		// fix for IE6
//		var olds = this.node.ownerTree.checks;
		if(this.showType === 'checkbox'){
			this.checkbox.defaultChecked = checked;
			this.checkbox.checked = checked;
		    this.node.attributes.checked = checked;
//			var index = olds.indexOf(this.node.record);
//			if(checked){//选中
//				if(index==-1){
//					olds.push(this.node.record);//增加,
//										//注意:一般这种多选、单选框的树都是只读的，
//										//因此,删除节点时就不同步this.node.ownerTree.checks了
//				}
//			} else {//没选中
//				if(index!=-1){
//					olds.splice(index, 1);//移除
//				}
//			}
		}
		if(this.showType === 'radiobox'){//radio是单选,以前选中的要排除掉
//			var curmodel = this.node.nodeModel;
//			var isupdate;//undefined
//			for(var i=0,len=olds.length;i<len;i++){
//				var oldnode = this.node.ownerTree.getNodeByRecordId(olds[i].id);
//				if(oldnode == undefined || oldnode == null){
//					isupdate = true;
//					olds.splice(i, 1);
//					continue;
//				}
//				var oldmodel = oldnode.nodeModel;
//				if(curmodel==oldmodel){
//					if(oldnode !== this.node){
//						oldnode.ui.checkbox.checked = false;
//						oldnode.ui.checkbox.defaultChecked = false;
//	       				oldnode.ui.node.attributes.checked = false;
//						olds.splice(i, 1);
//						isupdate = true;
//					} else {
//						isupdate = false;
//					}
//					break;
//				}
//			}
//			if(isupdate!==false)
//				olds.push(this.node.record);//添加新选中
			if(checked){
				var oldnode = this.node.ownerTree.radioboxChecked;
				if(oldnode==null && oldnode==undefined){
					this.node.ownerTree.radioboxChecked = this.node;
				} else {
					oldnode = this.node.ownerTree.getNodeById(oldnode.id);
					if(oldnode.ui && oldnode.ui.checkbox){
						oldnode.ui.checkbox.checked = false;
						oldnode.ui.checkbox.defaultChecked = false;
					}
					if(oldnode.attributes){
						oldnode.attributes.checked = false;
					}
					this.node.ownerTree.radioboxChecked = this.node;
				}
				
				this.checkbox.checked = true;
				this.checkbox.defaultChecked = true;
		        this.node.attributes.checked = true;
			}
			
		}
		//第一次初始化时(TreePanel的afterRender)和选中某个多选单选框时(TreeEventModel的onCheckboxClick)都会触发onCheckChange方法；
		//要处理：如果不是第一次初始化时change的，才触发checkchange事件。
		if(init!=true){
			this.fireEvent('checkchange', this.node, checked);
		}
		if(this.showType === 'radiobox' || this.cascadeChecked === false){
			return ;
		}
		this.node.eachChild(function(child){//限定节点模型一样的才能级联选中
										//如果遇到了某种需求,比如选中机构,然后下级所有用户选中,那可以通过监听
										//checkchange事件完成功能
			//通过treePanel的allowCheckAll判断是否选中所有子节点
			var allowCheck=child.ownerTree.allowCheck;
			var nodemodel = child.nodeModel;
			var pnodemodel = child.parentNode.nodeModel;
			if(L5.type(allowCheck)=="function")//如果是函数就取返回值，参数是当前子节点和当前节点
				allowCheck=allowCheck(child,child.parentNode);
			if(allowCheck===undefined){//默认是只选择同一种类型的
				allowCheck=(nodemodel==pnodemodel);
			}
			if(!allowCheck){
				return
			}
			child.ui.toggleCheck(checked);
        });
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
 * 通过传递的参数设置树节点的选中状态，如果没有值传递则切换选中状态。
 * 如果节点没有checkbox，该方法不会有影响。
 * @param {Boolean} (可选) 新的选中状态。
 */
    toggleCheck : function(value,init){
        var cb = this.checkbox;
        if(cb){
        	cb.checked = (value === undefined ? !cb.checked : value);
        	this.onCheckChange(init);
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

		var shtype = a.showType;//节点展现类型
        var cb = typeof a.checked == 'boolean';
		if(cb){
			shtype = shtype || 'checkbox';
		}
		var showHtml = "";
		if(shtype === 'checkbox'){
				cb = true;
				this.cascadeChecked = a.cascadeChecked;
				if(this.cascadeChecked == undefined){
					this.cascadeChecked = true;
				}
				showHtml = '<input class="l-tree-node-cb" type="checkbox" name="'+n.ownerTree.id+'_checkbox"'+(a.checked ? 'checked="checked" />' : '/>') ;
		} else if( shtype === "radiobox" ){
				cb = true;
				showHtml = '<input class="l-tree-node-cb" type="radio"  name="'+n.ownerTree.id+'_radiobox"'+(a.checked ? 'checked="checked" />' : '/>') ;
		} else {
				showHtml = "" ;
		}
		this.showType = shtype;
		this.checkedOnDblClick = a.checkedOnDblClick || false;
		
        var href = a.href ? a.href : L5.isGecko ? "" : "#";
        //包含html代码数据进行转换
        var htmlValue = /\<|\>/;
		if(htmlValue.test(n.text)) {
			n.text = L5.util.Format.htmlEncode(n.text);
		}
        var buf = ['<li class="l-tree-node"><div L5:tree-node-id="',n.id,'" class="l-tree-node-el l-tree-node-leaf l-unselectable ', a.cls,'" unselectable="on">',
            '<span class="l-tree-node-indent">',this.indentMarkup,"</span>",
            '<img src="', this.emptyIcon, '" class="l-tree-ec-icon l-tree-elbow" />',
            '<img src="', a.icon || this.emptyIcon, '" class="l-tree-node-icon',(a.icon ? " l-tree-node-inline-icon" : ""),(a.iconCls ? " "+a.iconCls : ""),'" unselectable="on" />',
            showHtml,
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
            var checkedValue=a.checked;
            if(checkedValue===true||checkedValue===false){
            	/*this.checkbox.indeterminate = false;
            	this.checkbox.defaultChecked = this.checkbox.checked;
            	this.checkbox.checked = this.checkbox.checked;
            	this.node.attributes.checked = this.checkbox.checked;*/
            	this.toggleCheck(this.checkbox.checked,true);
            }else if(checkedValue==='-1'){
            	/*this.checkbox.indeterminate = false;
            	this.checkbox.defaultChecked = false;
            	this.checkbox.checked = false;*/
            	this.node.attributes.checked = false;
            	this.toggleCheck(false,true);
            }else if(checkedValue==='0'&&!this.node.isLeaf()){
            	/*this.checkbox.checked=false;
            	this.checkbox.defaultChecked=false;*/
            	this.checkbox.indeterminate = true;
            	this.node.attributes.checked=false;
            	this.toggleCheck(false,true);
            }else if(checkedValue==='0'&&this.node.isLeaf()){
            	/*this.checkbox.indeterminate = false;
            	this.checkbox.defaultChecked = false;
            	this.checkbox.checked=false;*/
            	this.node.attributes.checked=false;
            	this.toggleCheck(false,true);
            }else if(checkedValue==='1'){
            	/*this.checkbox.indeterminate = false;
            	this.checkbox.checked = true;
            	this.checkbox.defaultChecked = true;*/
            	this.node.attributes.checked=true;
            	this.toggleCheck(true,true);
            }
            index++;
        }
        this.anchor = cs[index];
        this.textNode = cs[index].firstChild;
    },

/**
 * 返回 &lt;a> 元素，它提供了节点视图的焦点.
 * @return {HtmlElement} DOM anchor元素。
 */
    getAnchor : function(){
        return this.anchor;
    },
    
/**
 * 返回文本节点。
 * @return {HtmlNode} DOM文本节点.
 */
    getTextEl : function(){
        return this.textNode;
    },
    
/**
 * 返回图标&lt;img> 元素。
 * @return {HtmlElement} DOM image元素.
 */
    getIconEl : function(){
        return this.iconNode;
    },

/**
 * 返回节点的选中状态。如果节点没有checkbox，返回false。
 * @return {Boolean} 选中标识。
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
 * @ignore
 * @class L5.tree.RootTreeNodeUI
 * RootTreeNodeUI类为<b>root</b> TreeNodes提供默认的视图实现。
 * RootTreeNodeUI允许自定义树根节点的外观视图<br>
 * <p>
 * 如果要定义树的视图，可能需要继承该类，但是应该永远不需要实例化该类。<br>
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