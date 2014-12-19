/**
 * @class L5.grid.CellSelectionModel
 * @extends L5.grid.AbstractSelectionModel
 * @constructor
 * @param {Object} config 配置信息.
 * 通过各种事件维护一个当前选择结果的对象
 */
L5.grid.CellSelectionModel = function(config){
    L5.apply(this, config);

    this.selection = null;

    this.addEvents(
        /**
	     * @event beforecellselect
	     * 在cell单元格被选中前触发事件.
	     * @param {SelectionModel} this
	     * @param {Number} rowIndex 行号
	     * @param {Number} colIndex 列号
	     */
	    "beforecellselect",
        /**
	     * @event cellselect
	     * 在cell单元格被选中的时候触发事件.
	     * @param {SelectionModel} this
	     * @param {Number} rowIndex 被选中单元格所在的行
	     * @param {Number} colIndex 被选中单元格所在的列
	     */
	    "cellselect",
        /**
         * @ignore
	     * @event selectionchange
	     * 当前选择的记录发生改变的时候
	     * @param {SelectionModel} this
	     * @param {Object} selection 如果没有选择就是null，如果有选择就是一个普通对象，该对象包含两个属性：
	        <ul>
	        <li>o.record: 当前选中行对应的Record</li>
	        <li>o.cell: 一个数组数组里面有两个数值,[rowIndex, columnIndex]</li>
	        </ul>
	     */
	    "selectionchange"
    );

    L5.grid.CellSelectionModel.superclass.constructor.call(this);
};

L5.extend(L5.grid.CellSelectionModel, L5.grid.AbstractSelectionModel,  {

    /**
     * @ignore
     * @private
     * 初始化单元格选择模型要用到的事件，单元格选择模型主要用到了grid的cellmousedown，keydown，keypress事件，通过事件，
     * 单元格选择模型会维护一个保存当前选择结果的对象。
     */
    initEvents : function(){
        this.grid.on("cellmousedown", this.handleMouseDown, this);
        this.grid.getGridEl().on(L5.isIE || L5.isSafari3 ? "keydown" : "keypress", this.handleKeyDown, this);
        var view = this.grid.view;
        view.on("refresh", this.onViewChange, this);
        view.on("rowupdated", this.onRowUpdated, this);
        view.on("beforerowremoved", this.clearSelections, this);
        view.on("beforerowsinserted", this.clearSelections, this);
        if(this.grid.isEditor){
            this.grid.on("beforeedit", this.beforeEdit,  this);
        }
        this.grid.dataset.on("move",this.onSelectedChange,this);//L5 add it
    },
	/**
	 * @ignore
	 * @private
	 * L5增加的方法，当当前条记录移动的时候选择的记录也移动
	 * @param {L5.model.DataSet} ds 当前grid绑定的dataset
	 * @param {Number} rowIndex 将要移动到的行索引
	 */
    onSelectedChange : function(ds,rowIndex){
    	if(this.selection){
    		if(this.selection.cell[0]==rowIndex){
    			return;
    		}else{
    		    this.select(rowIndex,this.selection.cell[1]);		
    		}    	
    	}else{
    		this.select(rowIndex,0);
    	}
    },
    
	/**
	 * @private
	 */
    beforeEdit : function(e){
        this.select(e.row, e.column, false, true, e.record);
    },

    /**
	 * @private
	 * 当行更新的时候调用
	 * @param {L5.grid.GridView} v grid的视图
	 * @param {Number} index 当前行索引
	 * @param {L5.model.Record} r 当前行对应的record
	 */
    onRowUpdated : function(v, index, r){
        if(this.selection && this.selection.record == r){
            v.onCellSelect(index, this.selection.cell[1]);
        }
    },

	/**
	 * @private
	 * 当视图发生变化的时候清空选择结果
	 */
    onViewChange : function(){
        this.clearSelections(true);
    },

	/**
	 * 返回选中的cell单元格的行和列信息格式如：[0(行号), 0(列号)].
	 * @return {Array} 选中的cell单元格的行号和列号，如果没有选择cell单元格，则返回null.
	 */
    getSelectedCell : function(){
        return this.selection ? this.selection.cell : null;
    },

    /**
     * 清空所有选择的cell单元格.
     * @param {Boolean} 设置true防止通知视图同步改变.
     */
    clearSelections : function(preventNotify){
        var s = this.selection;
        if(s){
            if(preventNotify !== true){
                this.grid.view.onCellDeselect(s.cell[0], s.cell[1]);
            }
            this.selection = null;
            this.fireEvent("selectionchange", this, null);
        }
    },

    /**
     * @private
     * 判断是否有被选择的单元格
     * @return {Boolean}
     */
    hasSelection : function(){
        return this.selection ? true : false;
    },

    /** 
     * @private
     * @ignore
     * 当鼠标单击的时候触发
     * @param {L5.grid} g 当前grid对象
     * @param {Number} row 鼠标单击的行索引
     * @param {Number} cell  鼠标单击的列索引
     * @param {L5.EventObject} e 触发的事件
     */
    handleMouseDown : function(g, row, cell, e){
        if(e.button !== 0 || this.isLocked()){
            return;
        };
        this.select(row, cell);
    },

    /**
     * 选择一个cell单元格.
     * @param {Number} rowIndex
     * @param {Number} collIndex
     */
    select : function(rowIndex, colIndex, preventViewNotify, preventFocus, /*internal*/ r){
        if(this.fireEvent("beforecellselect", this, rowIndex, colIndex) !== false){
            this.clearSelections();            
            r = r || this.grid.dataset.getAt(rowIndex);
            this.selection = {
                record : r,
                cell : [rowIndex, colIndex]
            };
            if(!preventViewNotify){
                var v = this.grid.getView();
                v.onCellSelect(rowIndex, colIndex);
                if(preventFocus !== true){
                    //v.focusCell(rowIndex, colIndex);
                }
            }
            this.fireEvent("cellselect", this, rowIndex, colIndex);
            this.fireEvent("selectionchange", this, this.selection);
            this.grid.dataset.moveTo(rowIndex);//L5 add it
        }
    },

    /**
     * @private
     * 判断某列是否可悲选择，如果是隐藏列就不能被选择，不是隐藏的就可以被选择
     */
    isSelectable : function(rowIndex, colIndex, cm){
        return !cm.isHidden(colIndex);
    },

    /** 
     * @ignore 
     * 当有按键事件触发的时候调用该方法
     * @param {L5.EventObject} e 触发的事件
     */
    handleKeyDown : function(e){
        if(!e.isNavKeyPress()){
            return;
        }
        var g = this.grid, s = this.selection;
        if(!s){
            e.stopEvent();
            var cell = g.walkCells(0, 0, 1, this.isSelectable,  this);
            if(cell){
                this.select(cell[0], cell[1]);
            }
            return;
        }
        var sm = this;
        var walk = function(row, col, step){
            return g.walkCells(row, col, step, sm.isSelectable,  sm);
        };
        var k = e.getKey(), r = s.cell[0], c = s.cell[1];
        var newCell;

        switch(k){
             case e.TAB:
                 if(e.shiftKey){
                     newCell = walk(r, c-1, -1);
                 }else{
                     newCell = walk(r, c+1, 1);
                 }
             break;
             case e.DOWN:
                 newCell = walk(r+1, c, 1);
             break;
             case e.UP:
                 newCell = walk(r-1, c, -1);
             break;
             case e.RIGHT:
                 newCell = walk(r, c+1, 1);
             break;
             case e.LEFT:
                 newCell = walk(r, c-1, -1);
             break;
             case e.ENTER:
                 if(g.isEditor && !g.editing){
                    g.startEditing(r, c);
                    e.stopEvent();
                    return;
                }
             break;
        };
        if(newCell){
            this.select(newCell[0], newCell[1]);
            e.stopEvent();
        }
    },
    /**
     * @private
     */
    acceptsNav : function(row, col, cm){
        return !cm.isHidden(col) && cm.isCellEditable(col, row);
    },
    /**
     * @private
     */
    onEditorKey : function(field, e){
        var k = e.getKey(), newCell, g = this.grid, ed = g.activeEditor;
        if(k == e.TAB){
            if(e.shiftKey){
                newCell = g.walkCells(ed.row, ed.col-1, -1, this.acceptsNav, this);
            }else{
                newCell = g.walkCells(ed.row, ed.col+1, 1, this.acceptsNav, this);
            }
            e.stopEvent();
        }else if(k == e.ENTER){
            ed.completeEdit();
            e.stopEvent();
        }else if(k == e.ESC){
        	e.stopEvent();
            ed.cancelEdit();
        }
        if(newCell){
            g.startEditing(newCell[0], newCell[1]);
        }
    }
});