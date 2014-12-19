//doc
/**
 * @class L5.grid.EditorGridPanel
 * @extends L5.grid.GridPanel
 * 该类继承GridPanel类，同时提供了单元格编辑功能，可以编辑的列需要提供一个L5.grid.ColumnModel.editor.
 * 每列是否可编辑可以通过属性动态控制。
 * @constructor
 * @param {Object} config 配置对象
 */

L5.grid.EditorGridPanel = L5.extend(L5.grid.GridPanel, {
    /**
     * @cfg {Number} clicksToEdit
     * <p>点击几下可以编辑单元格(默认是1).</p>
     */
    clicksToEdit: 1,

    /**
     * @private
     */
    isEditor : true,
    /**
     * @private
     */
    detectEdit: false,

	/**
	 * @private
	 * @cfg {Boolean} autoEncode
	 * 如果是true自动的编码和解码HTML代码（默认是false）
	 */
	autoEncode : false,

	/**
	 * @private
	 * @cfg {Boolean} trackMouseOver @hide
	 * 老的firefox版本可能出错
	 */
    trackMouseOver: false, 
    /**
     * 赋值编辑框，保存按钮执行的方法
     */
    assistSave : L5.emptyFn,

    /**
     * @private
     */
    initComponent : function(){
        L5.grid.EditorGridPanel.superclass.initComponent.call(this);

        if(!this.selModel){
            /**
             * @private
             * @cfg {Object} 选择模型，支持AbstractSelectionModel的任意子类。（默认的选择模型是L5.grid.CellSelectionModel）。
             * 注意：选择模型必须支持选择单个单元格的模式，也就是支持getSelectedCell方法，因此L5.grid.RowSelectionModel不兼容，
             * 但是可以正常使用。
             */
            this.selModel = new L5.grid.CellSelectionModel();
        }

        this.activeEditor = null;

	    this.addEvents(
            /**
             * @ignore
             * @event beforeedit
             * 当单元格编辑之前触发，事件对象包含如下属性：
             * <ul style="padding:5px;padding-left:16px;">
             * <li>grid - 当前grid</li>
             * <li>record - 当前被编辑的record</li>
             * <li>field - 当前被编辑的field</li>
             * <li>value - 当前域的值</li>
             * <li>row - 当前行索引</li>
             * <li>column - 当前列索引</li>
             * <li>cancel - 设置参数为true就会取消编辑或者用回调返回false也可以取消</li>
             * </ul>
             * @param {Object} e 编辑事件对象，属性见上
             */
            "beforeedit",
            /**
             * @ignore
             * @event afteredit
             * 当编辑完成后触发，事件对象包含如下属性：
             * <ul style="padding:5px;padding-left:16px;">
             * <li>grid - 当前grid</li>
             * <li>record - 当前被编辑的record</li>
             * <li>field - 当前被编辑的field</li>
             * <li>value - 当前域的值</li>
             * <li>row - 当前行索引</li>
             * <li>originalValue - 编辑之前的值.</li>
             * <li>column - 当前列索引</li>
             * </ul>
             * @param {Object} e 编辑事件对象，属性见上
             */
            "afteredit",
            /**
             * @ignore
             * @event validateedit
             * 当编辑完成后，但是还没将值设置到record中的时候触发。如果返回false就取消编辑结果。，事件对象包含如下属性：
             * <ul style="padding:5px;padding-left:16px;">
             * <li>grid - 当前grid</li>
             * <li>record - 当前被编辑的record</li>
             * <li>field - 当前被编辑的field</li>
             * <li>value - 当前域的值</li>
             * <li>row - 当前行索引</li>
             * <li>originalValue - 编辑之前的值.</li>
             * <li>column - 当前列索引</li>
             * <li>cancel - 设置参数为true就会取消编辑或者用回调返回false也可以取消</li>
             * </ul>
             * @param {Object} e 编辑事件对象，属性见上
             */
            "validateedit"
        );
    },
	
    // private
    initEvents : function(){
        L5.grid.EditorGridPanel.superclass.initEvents.call(this);

        this.on("bodyscroll", this.stopEditing, this, [true]);
        this.on("columnresize", this.stopEditing, this, [true]);

        if(!this.assistWin){
        	if(this.clicksToEdit == 1){
            	this.on("cellclick", this.onCellDblClick, this);
            }else {
            	if(this.clicksToEdit == 'auto' && this.view.mainBody){
                	this.view.mainBody.on("mousedown", this.onAutoEditClick, this);
            	}
            	this.on("celldblclick", this.onCellDblClick, this);
            }
        }
        
    },
    /**
     * @private
     * 初始化辅助窗口
     */
    initShowWin : function () {
    	L5.grid.EditorGridPanel.superclass.initShowWin.call(this);
    	var grid = this;
    	this.assistWindow.addTool({
            id: 'savewin',
            align : 'left',
            handler : function(event, toolEl, win){
    			grid.stopEditing();
    			win.hide();
    			if(grid.assistSave) {
    				grid.assistSave.call(grid);
    			}
    		}
        });
    	this.assistWindow.on("resize",this.stopEditing,this);
    	this.assistWindow.on("move",this.stopEditing,this);
    },
    /**
     * @private
     * 显示辅助窗口
     */
    ShowWin : function(grid,rowIndex,e){
    	L5.grid.EditorGridPanel.superclass.ShowWin.call(this,grid,rowIndex,e);
    	var win = this.assistWindow;
    	if(win){
    		var celldetails = L5.DomQuery.select("*[@celldetail]", win.body.dom);
    		
    		for(var k=0,l=celldetails.length;k<l;k++){
    			var ele = celldetails[k];
    			var colrow = ele.getAttribute("celldetail");
    			var params = colrow.split(",");
    			params[params.length] = ele;
    			params[params.length] = this.el.dom;
    			if(ele.nodeName.toLowerCase()!="label"){
    				L5.get(ele).on("click",this.startEditing.createDelegate(this,params));
    			}
    			if(ele.getAttribute("render4win")){
    				ele.setAttribute("renderer",this.renderEl4Win.createDelegate(this,params));
    			}
    		}
    		L5.bindingdata(win.body.dom);
    		for(var k=0,l=celldetails.length;k<l;k++){
    			var ele = celldetails[k];
    			if(ele.getAttribute("render4win")){
    				var colrow = ele.getAttribute("celldetail");
        			var params = colrow.split(",");
        			params[params.length] = ele;
        			params[params.length] = this.el.dom;
        			if(ele.nodeName.toLowerCase()!="label"){
        				L5.get(ele.parentNode.firstChild).on("blur",this.startEditing.createDelegate(this,params));
        			}
	    			try{
	    				L5.fireEvent(ele,"blur");
	        			L5.fireEvent(ele,"change");
	    			} catch(e){
	    			}
	    			ele.removeAttribute("render4win");
	    		}
    		}
    	}
    },
	/**
	 * @private
	 * 创建每个单元格中的具体元素
	 */
	createEl4Win : function (cfg,row,col) {
		var editable = this.colModel.isCellEditable(col,row);
		if(cfg.editor && editable){
			str = '<input style="width:80%;height:20px;align:center;" celldetail="'
				+ row + ',' + col + '"  field="'
				+ cfg.field +'"'+(cfg.renderer ? (' render4win="true"'):'')+'></input>';
		} else {
			str = '<label  celldetail="'
				+ row + ',' + col + '"  field="'
				+ cfg.field +'"'+(cfg.renderer ? (' render4win="true"'):'')+'></label>';
		}
		return str;
	},
	/**
     * @private
     * 为win的编辑显示元素增加renderer转换
     */
	renderEl4Win : function (row,col,ele,value){
		value = ele?ele.value:value;
		var rec =  this.dataset.getAt(row);
		var cfg = this.colModel.config[col];
		var renderRes = cfg.renderer(value,null,rec,row,col,this.dataset,cfg.field,this);
		return renderRes;
	},
    
    /**
     * @private
     */
    onCellDblClick : function(g, row, col){
        this.startEditing(row, col);
    },

    /**
     * @private
     */
    onAutoEditClick : function(e, t){
        if(e.button !== 0){
            return;
        }
        var row = this.view.findRowIndex(t);
        var col = this.view.findCellIndex(t);
        if(row !== false && col !== false){
            this.stopEditing();
            if(this.selModel.getSelectedCell){ // cell sm
                var sc = this.selModel.getSelectedCell();
                if(sc && sc.cell[0] === row && sc.cell[1] === col){
                    this.startEditing(row, col);
                }
            }else{
                if(this.selModel.isSelected(row)){
                    this.startEditing(row, col);
                }
            }
        }
    },

    /**
     * @private
     */
    onEditComplete : function(ed, value, startValue){
        this.editing = false;
        this.activeEditor = null;
        ed.un("specialkey", this.selModel.onEditorKey, this.selModel);
		var r = ed.record;
        var field = this.colModel.getDataIndex(ed.col);
        value = this.postEditValue(value, startValue, r, field);
        var changed=false;
        if(value&&startValue&&value.getTime&&startValue.getTime){
        	changed=(value.getTime()!==startValue.getTime());
        } else {
        	changed=(String(value) !== String(startValue));
        }
        if(changed){
            var e = {
                grid: this,
                record: r,
                field: field,
                originalValue: startValue,
                value: value,
                row: ed.row,
                column: ed.col,
                cancel:false
            };
            if(this.fireEvent("validateedit", e) !== false && !e.cancel){
                r.set(field, e.value);
                delete e.cancel;
                this.fireEvent("afteredit", e);
            }
        }
        //this.view.focusCell(ed.row, ed.col);
    },

    /**
     * @private
     * 开始编辑
     * @param {Number} rowIndex
     * @param {Number} colIndex
     */
    startEditing : function(row, col,ele,parentDom){
        this.stopEditing();        
        if(this.colModel.isCellEditable(col, row)){
            this.view.ensureVisible(row, col, true);
            var r = this.dataset.getAt(row);
            var field = this.colModel.getDataIndex(col);
            var e = {
                grid: this,
                record: r,
                field: field,
                value: r.data[field],
                row: row,
                column: col,
                cancel:false
            };
            
            if(this.fireEvent("beforeedit", e) !== false && !e.cancel){
            	var ed = this.colModel.getCellEditor(col, row);    
            	//check if can edit
            	if(typeof ed.field.editable=='function'){
            		var result=ed.field.editable.call(this);
            		if(!result)
            			return;
            	}else if(!ed.field.editable)
                	return;
                
                this.editing = true;                
                if(!ed.rendered){
                	parentDom = parentDom ? parentDom : this.view.getEditorParent(ed);
                    ed.render(parentDom);
                }
                (function(){ // complex but required for focus issues in safari, ie and opera
                    ed.row = row;
                    ed.col = col;
                    ed.record = r;
                    ed.on("complete", this.onEditComplete, this, {single: true});
                    ed.on("specialkey", this.selModel.onEditorKey, this.selModel);
                    /**
                      * @ignore
                      * The currently active editor or null
                      * @type L5.Editor
                     */
                    this.activeEditor = ed;
                    var v = this.preEditValue(r, field);
                    ele = ele ? ele : this.view.getCell(row, col).firstChild;
                    ed.startEdit(ele , v === undefined ? '' : v);
                }).defer(50, this);
            }
        }
    },

    /**
     * @private
     */
	preEditValue : function(r, field){
        var value = r.data[field];
		return this.autoEncode && typeof value == 'string' ? L5.util.Format.htmlDecode(value) : value;
	},

	/**
     * @private
     */
	postEditValue : function(value, originalValue, r, field){
		return this.autoEncode && typeof value == 'string' ? L5.util.Format.htmlEncode(value) : value;
	},

    /**
     * @private
     * 停止编辑
     * @param {Boolean} cancel (可选) 如果是true就会取消任何的改变
     */
    stopEditing : function(cancel){
        if(this.activeEditor){
            this.activeEditor[cancel === true ? 'cancelEdit' : 'completeEdit']();
        }
        this.activeEditor = null;
    },

    /**
     * @private
     */
    onDestroy: function() {
        if(this.rendered){
            var cols = this.colModel.config;
            for(var i = 0, len = cols.length; i < len; i++){
                var c = cols[i];
                L5.destroy(c.editor);
            }
        }
        L5.grid.EditorGridPanel.superclass.onDestroy.call(this);
    }
});
L5.reg('editorgrid', L5.grid.EditorGridPanel);