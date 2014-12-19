/**
 * 一个自定义的多行选择模式，可以选择某行反选某行
 * @class L5.grid.CheckboxSelectionModel
 * @extends L5.grid.RowSelectionModel
 * @constructor
 * @param {Object} config 配置对象
 */
L5.grid.CheckboxSelectionModel = L5.extend(L5.grid.RowSelectionModel, {
    /**
     * @cfg {String} header 
     * 任何合理的HTML片段(默认是 '&lt;div class="l-grid3-hd-checker">&#160;&lt;/div>').
     */
    header: '<div class="l-grid3-hd-checker"></div>',
    /**
     * @cfg {Number} width  多选框列的宽度 (默认是 20).
     */
    width: 20,
    /**
     * @cfg {Boolean} sortable 是否可排序 (默认 false，不可排序).
     */
    sortable: false,

    /**
     * @private
     */
    menuDisabled:true,
    fixed:true,
    field: '',
    id: 'checker',

    /**
     * @private
     */
	initEvents : function() {
		if (!this.grid.enableDragDrop && !this.grid.enableDrag) {
			this.grid.on("rowmousedown", this.handleMouseDown, this);
		} else { // allow click to work like normal
			this.grid.on("rowclick", function(grid, rowIndex, e) {
				if (e.button === 0 && !e.shiftKey && !e.ctrlKey) {
					this.selectRow(rowIndex, false);
				}
			}, this);
		}

		this.rowNav = new L5.KeyNav(this.grid.getGridEl(), {
			"up" : function(e) {
				if (!e.shiftKey || this.singleSelect) {
					this.selectPrevious(false);
				} else if (this.last !== false && this.lastActive !== false) {
					var last = this.last;
					this.selectRange(this.last, this.lastActive - 1);
					// this.grid.getView().focusRow(this.lastActive);
					if (last !== false) {
						this.last = last;
					}
				} else {
					this.selectFirstRow();
				}
			},
			"down" : function(e) {
				if (!e.shiftKey || this.singleSelect) {
					this.selectNext(false);
				} else if (this.last !== false && this.lastActive !== false) {
					var last = this.last;
					this.selectRange(this.last, this.lastActive + 1);
					// this.grid.getView().focusRow(this.lastActive);
					if (last !== false) {
						this.last = last;
					}
				} else {
					this.selectFirstRow();
				}
			},
			scope : this
		});

		var view = this.grid.view;
		view.on("rowupdated", this.onRowUpdated, this);
		view.on("rowremoved", this.onRemove, this);
		/**
		 * L5.clickToSelectedForChkSM是一个全局配置参数，有项目人员配置，放在skins/js/public下面的任意一个文件内(建议统一文件名称好维护L5-global.js)使用方式：
		 * L5.clickToSelectedForChkSM = true 或者 L5.clickToSelectedForChkSM=false 默认是false
		 * grid级别参数在grid标签配置属性clickToSelectedForChkSM与系统级别参数作用相同，但是优先级比较高
		 */
		if((this.grid.clickToSelectedForChkSM==true) || (this.grid.clickToSelectedForChkSM==undefined&&L5.clickToSelectedForChkSM==true)){
			this.grid.dataset.on("move", this.onSelectedChange, this);// L5 add it
		}
		this.grid.on('render', function() {
			var view = this.grid.getView();
			var dataset = this.grid.getDataset();
			dataset.on("turnPage", this.onTurnPage, this);
			view.mainBody.on('mousedown', this.onMouseDown, this);
			L5.fly(view.innerHd).on('mousedown', this.onHdMouseDown, this);

		}, this);
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
        }else{
            var isSelected = this.isSelected(rowIndex);
            if(e.ctrlKey && isSelected){
                this.deselectRow(rowIndex);
            }else if(!isSelected || this.getCount() > 1){
            	if((this.grid.clickToSelectedForChkSM==true) || (this.grid.clickToSelectedForChkSM==undefined&&L5.clickToSelectedForChkSM==true)){
            		this.selectRow(rowIndex, e.ctrlKey || e.shiftKey);
        		} else {
        			if(e.ctrlKey || e.shiftKey){
                		this.selectRow(rowIndex, true);
                	} else {
                		view.toggleRowClass(rowIndex,"l-grid3-row-selected2");
                	}
        		}
            }
        }
    },
    /**
     * @private
     */
	onTurnPage : function() {
		var t = L5.fly(this.grid.getView().innerHd).child('.l-grid3-hd-checker-on');
		if (t) {
			t.removeClass('l-grid3-hd-checker-on');
			this.clearSelections();
		}
	},
	
	 /**
     * @private
     */
    onMouseDown : function(e, t){
        if(e.button === 0 && t.className == 'l-grid3-row-checker'){ // Only fire if left-click
            e.stopEvent();
            var row = e.getTarget('.l-grid3-row');
            if(row){
                var index = row.rowIndex;
                var view = this.grid.view;
                view.removeRowClass(view.lastToggleRow,"l-grid3-row-selected2")
                if(this.isSelected(index)){
                    this.deselectRow(index);
                    var t = L5.fly(this.grid.getView().innerHd).child('.l-grid3-hd-checker-on');
            		if (t) {
            			t.removeClass('l-grid3-hd-checker-on');
            		}
                }else{
                    this.selectRow(index, true);
                }
            }
        }
    },

    /**
     * @private
     */
    onHdMouseDown : function(e, t){
        if(t.className == 'l-grid3-hd-checker'){
            e.stopEvent();
            var hd = L5.fly(t.parentNode);
            var isChecked = hd.hasClass('l-grid3-hd-checker-on');
            if(isChecked){
                hd.removeClass('l-grid3-hd-checker-on');
                this.clearSelections();
            }else{
                hd.addClass('l-grid3-hd-checker-on');
                this.selectAll();
            }
        }
    },

    /**
     * @private
     */
    renderer : function(v, p, record){
        return '<div class="l-grid3-row-checker"></div>';
    }
});