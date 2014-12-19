/**
 * 一个自定义的选择模型，将渲染一列radioBox，支持单选一行
 * @class L5.grid.RadioboxSelectionModel
 * @extends L5.grid.RowSelectionModel
 * @constructor
 * @param {Object} config 配置对象
 */
L5.grid.RadioboxSelectionModel = L5.extend(L5.grid.RowSelectionModel, {
    /**
     * @cfg {String} header 
     * 任何合理的HTML片段(默认是 '&lt;div class="l-grid3-hd-checker">&#160;&lt;/div>').
     */
    header: "",
    /**
     * @cfg {Number} 单选框列的宽度 (默认是 20).
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
    singleSelect:true,
    fixed:true,
    field: '',
    id: 'radio',

    /**
     * @private
     */
    initEvents : function(){
        L5.grid.RadioboxSelectionModel.superclass.initEvents.call(this);
        this.grid.on('render', function(){
            var view = this.grid.getView();
            view.mainBody.on('mousedown', this.onMouseDown, this);
        }, this);
    },
    selectFirstRow:function(){
    	var row=this.grid.getView().getRow(0);
		if(row){
			var radio=L5.fly(row).child(".l-grid3-row-radio",true);
			if(radio&&!radio.checked)
				radio.checked=true;
		}
		 L5.grid.RadioboxSelectionModel.superclass.selectFirstRow.call(this);
    },
	
    /**
     * @private
     */
    onMouseDown : function(e, t){
		//获取到radio,选中
		var row = e.getTarget('.l-grid3-row');
		if(!row)//如果找不到当前行row，返回
			return;
        if(e.button === 0 && t.className == 'l-grid3-row-radio'){ // Only fire if left-click
            e.stopEvent();
            if(row){
                var index = row.rowIndex;
                this.clearSelections();
                this.selectRow(index, true);
            }
        }
    },

    /**
     * @private
     */
    renderer : function(v, p, record){
        return '<input type="radio" name="radioboxcolumn'+arguments[7].getId()+'" class="l-grid3-row-radio" />';
    }
});