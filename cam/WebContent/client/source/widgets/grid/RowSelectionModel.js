/**
 * @class L5.grid.RowSelectionModel
 * @extends L5.grid.AbstractSelectionModel
 * L5.grid.GridPanel的默认的选择模型，行选择模型支持多选以及使用键盘按键选择，选择的结果保存在selections对象里面。
 * 可以通过getSelected获取选中的第一条记录，getSelections获取选择行对象的record数组
 * @constructor
 * @param {Object} config
 */
L5.grid.RowSelectionModel = function(config){
    L5.apply(this, config);
    this.selections = new L5.util.MixedCollection(false, function(o){
        return o.id;
    });

    this.last = false;
    this.lastActive = false;

    this.addEvents(
        /**
	     * @event selectionchange
	     * 当选择的行发生改变的时候触发事件
	     * @param {SelectionModel} this
	     */
	    "selectionchange",
        /**
         * @ignore
	     * @event beforerowselect
	     * 当某一行被选中之前触发，如果返回false取消选中
	     * @param {SelectionModel} this
	     * @param {Number} rowIndex 被选择的行索引
	     * @param {Boolean} keepExisting 是否保留已经选择的记录
	     * @param {Record} record 被选择的record
	     */
	    "beforerowselect",
        /**
	     * @event rowselect
	     * 当行被选择的时候触发事件.
	     * @param {SelectionModel} this
	     * @param {Number} rowIndex 行号
	     * @param {L5.model.Record} r 被选中的行对应的record
	     */
	    "rowselect",
        /**
	     * @event rowdeselect
	     * 当行被取消选中的时候触发事件.
	     * @param {SelectionModel} this
	     * @param {Number} rowIndex
	     * @param {Record} record
	     */
	    "rowdeselect"
    );

    L5.grid.RowSelectionModel.superclass.constructor.call(this);
};

L5.extend(L5.grid.RowSelectionModel, L5.grid.AbstractSelectionModel,  {
    /**
     * @cfg {Boolean} singleSelect
     * 设置true只允许一次选择一行，不允许多选(默认是false)
     */
    singleSelect : false,

	/**
	 * @private
	 * @cfg {Boolean} moveEditorOnEnter
	 * 假如是true，当按下enter键的时候将编辑器移动到下一个单元格，如果是false关闭该功能，默认该功能打开
	 */


    /**
     * @ignore
     * @private
     * 初始化行选择模型要用到的事件，行选择模型主要用到了grid的rowmousedown，rowclick事件，通过事件，
     * 行选择模型会维护一个保存当前选择结果的对象，多选和单选可以配置。
     */
    initEvents : function(){

        if(!this.grid.enableDragDrop && !this.grid.enableDrag){
            this.grid.on("rowmousedown", this.handleMouseDown, this);
        }else{ // allow click to work like normal
            this.grid.on("rowclick", function(grid, rowIndex, e) {
                if(e.button === 0 && !e.shiftKey && !e.ctrlKey) {
                    this.selectRow(rowIndex, false);
                    //grid.view.focusRow(rowIndex);
                }
            }, this);
        }

        this.rowNav = new L5.KeyNav(this.grid.getGridEl(), {
            "up" : function(e){
                if(!e.shiftKey || this.singleSelect){
                    this.selectPrevious(false);
                }else if(this.last !== false && this.lastActive !== false){
                    var last = this.last;
                    this.selectRange(this.last,  this.lastActive-1);
                    //this.grid.getView().focusRow(this.lastActive);
                    if(last !== false){
                        this.last = last;
                    }
                }else{
                    this.selectFirstRow();
                }
            },
            "down" : function(e){
                if(!e.shiftKey || this.singleSelect){
                    this.selectNext(false);
                }else if(this.last !== false && this.lastActive !== false){
                    var last = this.last;
                    this.selectRange(this.last,  this.lastActive+1);
                    //this.grid.getView().focusRow(this.lastActive);
                    if(last !== false){
                        this.last = last;
                    }
                }else{
                    this.selectFirstRow();
                }
            },
            scope: this
        });

        var view = this.grid.view;
        //view.on("refresh", this.onRefresh, this);
        view.on("rowupdated", this.onRowUpdated, this);
        view.on("rowremoved", this.onRemove, this);
        this.grid.dataset.on("move",this.onSelectedChange,this);//L5 add it
    },
    
    /**
     * @private
     * L5增加的方法
     */
    onSelectedChange : function(ds,rowIndex){
    	if(this.last===rowIndex) return;//
        this.selectRow(rowIndex);
    },

    /**
     * @private
     */
    onRefresh : function(){
        var ds = this.grid.dataset, index;
        var s = this.getSelections();
        this.clearSelections(true);
        for(var i = 0, len = s.length; i < len; i++){
            var r = s[i];
            if((index = ds.indexOfId(r.id)) != -1){
                this.selectRow(index, true);
            }
        }
        if(s.length != this.selections.getCount()){
            this.fireEvent("selectionchange", this);
        }
    },

    /**
     * @private
     */
    onRemove : function(v, index, r){
        if(this.selections.remove(r) !== false){
            this.fireEvent('selectionchange', this);
        }
    },

    /**
     * @private
     */
    onRowUpdated : function(v, index, r){
        if(this.isSelected(r)){
            v.onRowSelect(index);
        }
    },

    /**
     * 根据records选择行
     * @param {Array} records 要选择的record数组
     * @param {Boolean} keepExisting (可选) 如果是true，保持已经选择的行不变
     */
    selectRecords : function(records, keepExisting){
        if(!keepExisting){
            this.clearSelections();
        }
        var ds = this.grid.dataset;
        for(var i = 0, len = records.length; i < len; i++){
            this.selectRow(ds.indexOf(records[i]), true);
        }
    },

    /**
     * 获取选择了几行.
     * @return {Number}
     */
    getCount : function(){
        return this.selections.length;
    },

    /**
     * 选择第一行.
     */
    selectFirstRow : function(){
        this.selectRow(0);
    },

    /**
     * 选择最后一行.
     * @param {Boolean} keepExisting (可选)设置true保持已经选择的行
     */
    selectLastRow : function(keepExisting){
        this.selectRow(this.grid.dataset.getCount() - 1, keepExisting);
    },

    /**
     * 选择下一行.
     * @param {Boolean} keepExisting (可选) 设置true保持已经选择的
     * @return {Boolean} 如果有下一行返回true，否则返回false
     */
    selectNext : function(keepExisting){
        if(this.hasNext()){
            this.selectRow(this.last+1, keepExisting);
            this.grid.getView().focusRow(this.last);
			return true;
        }
		return false;
    },

    /**
     * 选择上一行.
     * @param {Boolean} keepExisting (可选) 设置true保持已经选择的
     * @return {Boolean} 如果有上一行返回true，否则返回false
     */
    selectPrevious : function(keepExisting){
        if(this.hasPrevious()){
            this.selectRow(this.last-1, keepExisting);
            this.grid.getView().focusRow(this.last);
			return true;
        }
		return false;
    },

    /**
     * 如果有下一行，返回true，否则返回false
     * @return {Boolean}
     */
    hasNext : function(){
        return this.last !== false && (this.last+1) < this.grid.dataset.getCount();
    },

    /**
     *如果有上一行则返回true，否则返回false
     * @return {Boolean}
     */
    hasPrevious : function(){
        return !!this.last;
    },


    /**
     * 返回选择的行对应的records
     * @return {Array} 选择的行对应的record数组
     */
    getSelections : function(){
        return [].concat(this.selections.items);
    },

    /**
     * 返回选择的行对应的第一个record.
     * @return {Record}
     */
    getSelected : function(){
        return this.selections.itemAt(0);
    },

    /**
     * @private
     * 遍历每一个选择结果并对每个结果调用一个方法，假如该方法返回false，终止遍历并且这个each也返回fasle，
     * 否则返回true
     * @param {Function} fn 为每个选择结果调用的方法
     * @param {Object} scope (可选)  作用域
     * @return {Boolean} 假如所有的结果调用方法的时候都返回true，这个方法也返回true
     */
    each : function(fn, scope){
        var s = this.getSelections();
        for(var i = 0, len = s.length; i < len; i++){
            if(fn.call(scope || this, s[i], i) === false){
                return false;
            }
        }
        return true;
    },

    /**
     * 清除所有选择的行.
     */
    clearSelections : function(fast){
        if(this.isLocked()) return;
        if(fast !== true){
            var ds = this.grid.dataset;
            var s = this.selections;
            s.each(function(r){
                this.deselectRow(ds.indexOfId(r.id));
            }, this);
            s.clear();
        }else{
            this.selections.clear();
        }
        this.last = false;
    },


    /**
     * 选中所有行.
     */
    selectAll : function(){
        if(this.isLocked()) return;
        this.selections.clear();
        for(var i = 0, len = this.grid.dataset.getCount(); i < len; i++){
            this.selectRow(i, true);
        }
    },

    /**
     * @private
     * 假如有被选择的行返回true
     * @return {Boolean}
     */
    hasSelection : function(){
        return this.selections.length > 0;
    },

    /**
     * 某行是否被选中.
     * @param {Number/Record} record record或者record的序列号
     * @return {Boolean} 如果改行被选择就返回true
     */
    isSelected : function(index){
        var r = typeof index == "number" ? this.grid.dataset.getAt(index) : index;
        return (r && this.selections.key(r.id) ? true : false);
    },

    /**
     * @private
     * 通过record的id判断是否被选择
     * @param {String} id 被检测的record的id
     * @return {Boolean}
     */
    isIdSelected : function(id){
        return (this.selections.key(id) ? true : false);
    },

    /**
     * @private
     */
    handleMouseDown : function(g, rowIndex, e){
        if(e.button !== 0 || this.isLocked()){
            return;
        };
        var view = this.grid.getView();
        if(e.shiftKey && !this.singleSelect && this.last !== false){
            var last = this.last;
            this.selectRange(last, rowIndex, e.ctrlKey);
            this.last = last; // reset the last
            //view.focusRow(rowIndex);
        }else{
            var isSelected = this.isSelected(rowIndex);
            if(e.ctrlKey && isSelected){
                this.deselectRow(rowIndex);
            }else if(!isSelected || this.getCount() > 1){
            	this.selectRow(rowIndex, e.ctrlKey || e.shiftKey);
               // view.focusRow(rowIndex);
            }
        }
    },

    /**
     * 选择多行.
     * @param {Array} rows 需要选择的行号
     * @param {Boolean} keepExisting (可选) 是否保持已经选择的(默认是false)
     */
    selectRows : function(rows, keepExisting){
        if(!keepExisting){
            this.clearSelections();
        }
        for(var i = 0, len = rows.length; i < len; i++){
            this.selectRow(rows[i], true);
        }
    },

    /**
     * 选择连续的几行.
     * @param {Number} startRow 开始选择的行号
     * @param {Number} endRow 停止选择的行号
     * @param {Boolean} keepExisting (可选) 是否保持已经选择的
     */
    selectRange : function(startRow, endRow, keepExisting){
        if(this.isLocked()) return;
        if(!keepExisting){
            this.clearSelections();
        }
        if(startRow <= endRow){
            for(var i = startRow; i <= endRow; i++){
                this.selectRow(i, true);
            }
        }else{
            for(var i = startRow; i >= endRow; i--){
                this.selectRow(i, true);
            }
        }
    },

    /**
     * 取消选择连续的几行. 
     * @param {Number} startRow 开始取消选择的行号
     * @param {Number} endRow 停止取消选择的行号
     */
    deselectRange : function(startRow, endRow, preventViewNotify){
        if(this.isLocked()) return;
        for(var i = startRow; i <= endRow; i++){
            this.deselectRow(i, preventViewNotify);
        }
    },

    /**
     * 选择一行
     * @param {Number} row 需要选择的行号
     * @param {Boolean} keepExisting (可选) 是否保持已经选择的
     */
    selectRow : function(index, keepExisting, preventViewNotify){
        if(this.isLocked() || (index < 0 || index >= this.grid.dataset.getCount()) || this.isSelected(index)) return;
        var r = this.grid.dataset.getAt(index);
        if(r && this.fireEvent("beforerowselect", this, index, keepExisting, r) !== false){        	
            if(!keepExisting || this.singleSelect){
            	if(this.singleSelect){
            		var radio=L5.fly(this.grid.getView().getRow(index)).child(".l-grid3-row-radio",true);
            		if(radio&&!radio.checked)
            			radio.checked=true;
            	}
                this.clearSelections();
            }
            this.selections.add(r);
            this.last = this.lastActive = index;
            if(!preventViewNotify){
                this.grid.getView().onRowSelect(index);
            }
            this.fireEvent("rowselect", this, index, r);
            this.fireEvent("selectionchange", this);
            this.grid.dataset.moveTo(index);//L5 add it
        }
    },

    /**
     * 取消选择一行.
     * @param {Number} row 需要取消选择的行号
     */
    deselectRow : function(index, preventViewNotify){
        if(this.isLocked()) return;
        if(this.last == index){
            this.last = false;
        }
        if(this.lastActive == index){
            this.lastActive = false;
        }
        var r = this.grid.dataset.getAt(index);
        if(r){
            this.selections.remove(r);
            if(!preventViewNotify){
                this.grid.getView().onRowDeselect(index);
            }
            this.fireEvent("rowdeselect", this, index, r);
            this.fireEvent("selectionchange", this);
        }
    },

    /**
     * @private
     */
    restoreLast : function(){
        if(this._last){
            this.last = this._last;
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
        var shift = e.shiftKey;
        if(k == e.TAB){
            e.stopEvent();
            ed.completeEdit();
            if(shift){
                newCell = g.walkCells(ed.row, ed.col-1, -1, this.acceptsNav, this);
            }else{
                newCell = g.walkCells(ed.row, ed.col+1, 1, this.acceptsNav, this);
            }
        }else if(k == e.ENTER){
            e.stopEvent();
            ed.completeEdit();
			if(this.moveEditorOnEnter !== false){
				if(shift){
					newCell = g.walkCells(ed.row - 1, ed.col, -1, this.acceptsNav, this);
				}else{
					newCell = g.walkCells(ed.row + 1, ed.col, 1, this.acceptsNav, this);
				}
			}
        }else if(k == e.ESC){
            ed.cancelEdit();
        }
        if(newCell){
            g.startEditing(newCell[0], newCell[1]);
        }
    }
});