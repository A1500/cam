/**
 * @class L5.grid.ColumnModel
 * @extends L5.util.Observable
 * 这是一个为grid提供ColumnModel的实现类，这个类初始化列配置对象数组。
 * 每个列配置对象定义了表头，列对应的record的field，和一个可选的自定义的render方法（该方法可以
 * 按照按照某种方式显示内容），还可以通过配置对象中的属性id来为单元格确定css样式。
 * 示例：
 * var colModel = new L5.grid.ColumnModel([
 *    { header: "Ticker", width: 60, sortable: true},
 *    { header: "Company Name", width: 150, sortable: true},
 *    { header: "Market Cap.", width: 100, sortable: true},
 *    { header: "$ Sales", width: 100, sortable: true, renderer: money},
 *    { header: "Employees", width: 100, sortable: true, resizable: false}
 * ]);
 * @constructor
 * @param {Object} config 一个列配置对象数组
*/
L5.grid.ColumnModel = function(config,grid){
	this.fileColumn=null;
	/**
	 * grid
	 */
	this.grid=grid;
    /**
     * 当没有配置宽度的时候的默认宽度（默认是100）
     * @type Number
     */
    this.defaultWidth = 100;

    /**
     * 当没有配置是否可排序的时候默认不可排序（默认是不可排序）
     * @type Boolean
     */
    this.defaultSortable = false;

    /**
     * 构造方法接收到的参数对象
     * @property {Array} config
     */
    if(config.columns){
        L5.apply(this, config);
        this.setConfig(config.columns, true);
    }else{
        this.setConfig(config, true);
    }
    this.addEvents(
        /**
         * @event widthchange
         * 当列的宽度改变的时候触发
         * @param {ColumnModel} this 列
         * @param {Number} columnIndex 列索引
         * @param {Number} newWidth 列新的宽度
         */
        "widthchange",
        /**
         * @event headerchange
         * 当列表头发生变化的时候触发
         * @param {ColumnModel} 列
         * @param {Number} columnIndex 列索引
         * @param {String} newText 新的列表头
         */
        "headerchange",
        /**
         * @event hiddenchange
         * 当列的隐藏状态发生变化的时候触发
         * @param {ColumnModel} 列
         * @param {Number} columnIndex 列索引
         * @param {Boolean} hidden 列的隐藏状态，是否因藏
         */
        "hiddenchange",
        /**
         * @event columnmoved
         * 当列移动的时候触发
         * @param {ColumnModel} 列
         * @param {Number} 移动之前的索引
         * @param {Number} 移动之后的索引
         */
        "columnmoved",
        /**
         * @ignore
         * @private
         * @deprecated
         * 已废除
         */
        "columnlockchange",
        /**
         * @event configchange
         * 当列的配置对象发生变化的时候触发
         * @param {ColumnModel} this
         */
        "configchange"
    );
    L5.grid.ColumnModel.superclass.constructor.call(this);
};
L5.extend(L5.grid.ColumnModel, L5.util.Observable, {
    /**
     * @cfg {String} id (可选) 将列默认初始化序号当做列的id。列的标识，用这个id组合css然后应用到该列的每个单元格上。CSS组合的
     * 方式为：'l-grid3-td-'  +  id  如果是头部 ：.l-grid3-hd.l-grid3-td-  +  id
     */
    /**
     * @cfg {String} header grid视图的列表头
     */
    /**
     * @cfg {String} field (可选) grid的数据模型record的某个字段field
     */
    /**
     * @cfg {Number} width (可选) 列宽的配置参数，如果gridView的forceFit属性是true，列宽无效，由view安排列宽
     */
    /**
     * @cfg {Boolean} sortable (可选) 假如是true，数据可以按照当前列排序
     */
    /**
     * @cfg {Boolean} fixed (可选) 如果是true列宽度不可改变默认是false
     */
    /**
     * @cfg {Boolean} resizable (可选) 如果是false就不允许改变列宽，默认是true
     */
    /**
     * @cfg {Boolean} menuDisabled (可选) 如果是true就禁用列菜单，默认是false
     */
    /**
     * @cfg {Boolean} hidden (可选) 如果是true就隐藏列，默认是false
     */
    /**
     * @cfg {String} tooltip (可选) 列的悬浮提示信息。如果Quicktips已经初始化就被当做quick tip提示文本信息，否则被设置成
     * HTML的title属性的值。默认是""。
     */
    /**
     * @cfg {Function} renderer (可选) 一个方法，该方法可以为某单元格生成HTML片段或者单元格的显示值。如果没有配置
     * 就会渲染成最原始的数据
     */
    /**
     * @cfg {String} align (可选) 设置列文本对齐模式，默认是undefined
     */
    /**
     * @cfg {String} css (可选) 自定义表格单元格的css样式,默认是undefined.
     */
    /**
     * @cfg {Boolean} hideable (可选) 如果是false就不允许该列隐藏，默认是true。如果想禁用所有列的隐藏功能，可以用过
     * 设置enableColumnHide来实现
     */
    /**
     * @cfg {L5.form.Field} editor (可选) 当编辑单元格的时候所用的编辑器
     */

    /**
     * 通过列索引获取列的id
     * @param {Number} index 列索引
     * @return {String} 返回列的id
     */
    getColumnId : function(index){
        return this.config[index].id;
    },
    /**
     * @ignore
     * @private
     * 当初为了解决列宽拖动包js错误的bug，需要将列宽全都转换成绝对值，才增加的方法。
     * 将列的宽度和高度的百分比值兑换成绝对值（还存在问题，去宽度和高度的方式存在问题，需要进一步改善）
     * @param {String/Number}  value  转换之前的值
     * @param {String} wh 是宽度还是高度，宽度用w高度用h
     * @returns {Number} 返回转换之后的值
     */
    turnWidthHeight : function(value,wh){
    	if(value&&!L5.num(value)){
    		if(value.indexOf("%")>0){
    			var tempWidth=value.substring(0,(value.indexOf("%")))/100;
    			var temp= (wh=="w")?L5.getBody().getWidth()-45:L5.getBody().getHeight(); 
    			return tempWidth*temp;
    		} else{
    			return value;
    		}
    	}else{
    		return value;
    	}
    },
    /**
     * 新配置列配置对象数组，触发configchange事件，GridPanel将会监听改时间然后刷新视图
     * @param {Array} config 列配置对象数组
     */
    setConfig : function(config, initial){
        if(!initial){ // cleanup
            delete this.totalWidth;
            for(var i = 0, len = this.config.length; i < len; i++){
                var c = this.config[i];
                if(c.width){
                	this.config[i].width=c.width=this.turnWidthHeight(c.width, "w");
                }
                if(c.height){
                	this.config[i].height=c.height=this.turnWidthHeight(c.width, "h");
                }
                if(c.editor){
                    c.editor.destroy();
                }
            }
        }
        this.config = config;
        this.lookup = {};
        // if no id, create one
        for(var i = 0, len = config.length; i < len; i++){
            var c = config[i];
            if(c.width){
            	this.config[i].width=c.width=this.turnWidthHeight(c.width, "w");
            }
            if(c.height){
            	this.config[i].height=c.height=this.turnWidthHeight(c.width, "h");
            }
            if(c.isFileColumn){
            	c.id='fileColumn';
            	this.fileColumn=i;//目前只支持单列file
            }
            if(typeof c.renderer == "string"){
                c.renderer = L5.util.Format[c.renderer];
            }
            if(typeof c.id == "undefined"){
                c.id = i;
            }
            if(c.editor && c.editor.isFormField){
                c.editor = new L5.grid.GridEditor(c.editor);
            }
            this.lookup[c.id] = c;
        }
        if(!initial){
            this.fireEvent('configchange', this);
        }
    },

    /**
     * 通过id获取列
     * @param {String} id 列的id
     * @return {Object} 返回满足条件的id
     */
    getColumnById : function(id){
        return this.lookup[id];
    },

    /**
     * 根据id返回列索引，如果没找到返回-1
     * @param {String} id 列的id
     * @return {Number} 列索引，如果没找到返回-1
     */
    getIndexById : function(id){
        for(var i = 0, len = this.config.length; i < len; i++){
            if(this.config[i].id == id){
                return i;
            }
        }
        return -1;
    },

    /**
     * 移动列，从指定所引到新的所引处
     * @param {Number} oldIndex 移动之前的索引.
     * @param {Number} newIndex 移动之后的索引.
     */
    moveColumn : function(oldIndex, newIndex){
        var c = this.config[oldIndex];
        this.config.splice(oldIndex, 1);
        this.config.splice(newIndex, 0, c);
        this.dataMap = null;
        this.fireEvent("columnmoved", this, oldIndex, newIndex);
    },

    /**
     * @private
     * @ignore
     * @author deprecated
     * 已废除
     */
    isLocked : function(colIndex){
        return this.config[colIndex].locked === true;
    },

    /**
     * @private
     * @ignore
     * @author deprecated
     * 已废除
     */
    setLocked : function(colIndex, value, suppressEvent){
        if(this.isLocked(colIndex) == value){
            return;
        }
        this.config[colIndex].locked = value;
        if(!suppressEvent){
            this.fireEvent("columnlockchange", this, colIndex, value);
        }
    },

    /**
     * @private
     * @ignore
     * @author deprecated
     * 已废除
     */
    getTotalLockedWidth : function(){
        var totalWidth = 0;
        for(var i = 0; i < this.config.length; i++){
            if(this.isLocked(i) && !this.isHidden(i)){
                this.totalWidth += this.getColumnWidth(i);
            }
        }
        return totalWidth;
    },

    /**
     * @private
     * @ignore
     * @author deprecated
     * 已废除
     */
    getLockedCount : function(){
        for(var i = 0, len = this.config.length; i < len; i++){
            if(!this.isLocked(i)){
                return i;
            }
        }
    },

    /**
     * 获取列数目
     * Returns the number of columns.
     * @param {Boolean} visibleOnly （可选）是否仅仅包含可见的列
     * @return {Number}
     */
    getColumnCount : function(visibleOnly){
        if(visibleOnly === true){
            var c = 0;
            for(var i = 0, len = this.config.length; i < len; i++){
                if(!this.isHidden(i)){
                    c++;
                }
            }
            return c;
        }
        return this.config.length;
    },

    /**
     * 获取能够经过指定方法验证的列配置对象数组
     * @param {Function} fn 验证方法
     * @param {Object} scope (可选)
     * @return {Array} 返回经过验证的列配置对象数组
     */
    getColumnsBy : function(fn, scope){
        var r = [];
        for(var i = 0, len = this.config.length; i < len; i++){
            var c = this.config[i];
            if(fn.call(scope||this, c, i) === true){
                r[r.length] = c;
            }
        }
        return r;
    },

    /**
     * 获取指定列是否可排序
     * @param {Number} col 列索引
     * @return {Boolean}
     */
    isSortable : function(col){
        if(typeof this.config[col].sortable == "undefined"){
            return this.defaultSortable;
        }
        return this.config[col].sortable;
    },

    /**
     * 假如指定列的菜单可以被禁用返回true，否则返回false
     * @param {Number} col 列索引
     * @return {Boolean}
     */
    isMenuDisabled : function(col){
        return !!this.config[col].menuDisabled;
    },
    /**
     * 判断指定列是否是文件上传列
     * @param {Number} col 列索引
     * @return {Boolean}
     */
    isFileColumn : function(col){
        return this.config[col].isFileColumn;
    },
    /**
     * 获取指定列的renderer方法
     * @param {Number} col 列索引
     * @return {Function} 返回列的renderer方法
     */
    getRenderer : function(col){
        if(!this.config[col].renderer){
        	if(this.isFileColumn(col)){
        		return L5.grid.ColumnModel.fileRenderer;
        	}else
        		return L5.grid.ColumnModel.defaultRenderer;
        }
        return this.config[col].renderer;
    },

    /**
     * 为列设置渲染（格式化数值）方法
     * @param {Number} col 列索引
     * @param {Function} fn 用来处理原始数值的方法，该方法可能返回HTML片段或者格式化后的数据显示到grid视图上
     * renderer方法的参数：<ul>
     * <li><b>value</b> : Object<p class="sub-desc">单元格的值.</p></li>
     * <li><b>metadata</b> : Object<p class="sub-desc">一个配置对象，可以设置如下的属性:<ul>
     * 		<li><b>css</b> : String<p class="sub-desc">A CSS class name to add to the cell's TD element.</p></li>
     * 		<li><b>attr</b> : String<p class="sub-desc">An HTML attribute definition string to apply to the data container element <i>within</i> the table cell
     * (e.g. 'style="color:red;"').</p></li></ul></p></li>
     * <li><b>record</b> : L5.model.record<p class="sub-desc">当前行对应的record</p></li>
     * <li><b>rowIndex</b> : Number<p class="sub-desc">行索引</p></li>
     * <li><b>colIndex</b> : Number<p class="sub-desc">列索引</p></li>
     * <li><b>dataset</b> : L5.model.Dataset<p class="sub-desc">grid对应的dataset</p></li></ul>
     */
    setRenderer : function(col, fn){
        this.config[col].renderer = fn;
    },

    /**
     * 获取列的宽度
     * @param {Number} col 列索引
     * @return {Number}
     */
    getColumnWidth : function(col){
        return this.config[col].width || this.defaultWidth;
    },

    /**
     * 设置列的宽度
     * @param {Number} col 列索引
     * @param {Number} width 新的宽度
     */
    setColumnWidth : function(col, width, suppressEvent){
        this.config[col].width = width;
        this.totalWidth = null;
        if(!suppressEvent){
             this.fireEvent("widthchange", this, col, width);
        }
    },

    /**
     * 获取所有列的总宽度
     * @param {Boolean} includeHidden 如果是true就包含隐藏列的宽度
     * @return {Number}
     */
    getTotalWidth : function(includeHidden){
        if(!this.totalWidth){
            this.totalWidth = 0;
            for(var i = 0, len = this.config.length; i < len; i++){
                if(includeHidden || !this.isHidden(i)){
                    this.totalWidth += this.getColumnWidth(i);
                }
            }
            var width=(this.totalWidth/1);
            if(isNaN(width)){
            	this.totalWidth=this.grid.width;
            }
        }
        return this.totalWidth;
    },

    /**
     * 获取指定列的表头
     * @param {Number} col 列索引
     * @return {String} 返回列表头
     */
    getColumnHeader : function(col){
        return this.config[col].header;
    },

    /**
     * 设置列的表头
     * @param {Number} col 列索引
     * @param {String} header 表头信息
     */
    setColumnHeader : function(col, header){
        this.config[col].header = header;
        this.fireEvent("headerchange", this, col, header);
    },

    /**
     * 获取列的提示（quicktip）信息
     * @param {Number} col 列索引
     * @return {String}
     */
    getColumnTooltip : function(col){
            return this.config[col].tooltip;
    },
    /**
     * 设置列的提示（quicktip）信息
     * @param {Number} col 列索引
     * @param {String} tooltip 新的提示信息
     */
    setColumnTooltip : function(col, tooltip){
            this.config[col].tooltip = tooltip;
    },

    /**
     * 获取列对应的field字段
     * @param {Number} col 列索引
     * @return {String} 
     */
    getDataIndex : function(col){
        return this.config[col].field;
    },

    /**
     * 设置列对应的字段
     * @param {Number} col 列索引
     * @param {String} field field索引
     */
    setDataIndex : function(col, field){
        this.config[col].field = field;
    },

    /**
     * 通过field获取列对应的索引号，如果为找到返回-1
     * @param {String} col 列对应的field
     * @return {Number} 列索引，如果为找到返回-1
     */
    findColumnIndex : function(field){
        var c = this.config;
        for(var i = 0, len = c.length; i < len; i++){
            if(c[i].field == field){
                return i;
            }
        }
        return -1;
    },

    /**
     * 判断指定单元格是否可以编辑
     * @param {Number} colIndex 列索引
     * @param {Number} rowIndex 行索引
     * @return {Boolean}
     */
    isCellEditable : function(colIndex, rowIndex){
    	if(L5.type(this.config[colIndex].editable)=='function')
    		return this.config[colIndex].editable(colIndex,rowIndex);
        return (this.config[colIndex].editable || (typeof this.config[colIndex].editable == "undefined" && this.config[colIndex].editor)) ? true : false;
    },

    /**
     * 获取单元格/列的编辑器
     * @param {Number} colIndex 列索引
     * @param {Number} rowIndex 行索引
     * @return {L5.Editor} 列的编辑器
     */
    getCellEditor : function(colIndex, rowIndex){
        return this.config[colIndex].editor;
    },

    /**
     * 设置列可编辑
     * @param {Number} col 列索引
     * @param {Boolean} editable 如果是true，列可编辑
     */
    setEditable : function(col, editable){
        this.config[col].editable = editable;
    },


    /**
     * 判断列是否是隐藏状态
     * @param {Number} colIndex 列索引
     * @return {Boolean}
     */
    isHidden : function(colIndex){
        return this.config[colIndex].hidden;
    },


    /**
     * 判断列宽是否可改变
     * @param {Number} 列索引
     * @return {Boolean}
     */
    isFixed : function(colIndex){
        return this.config[colIndex].fixed;
    },
    /**
     * 设置列宽可编辑
     * @param {Number} 列索引
     */
    setFixed : function(colIndex){
        return this.config[colIndex].fixed=true;
    },
    /**
     * 判断列是否可改变大小
     * @param {Number} 列索引
     * @return {Boolean}
     */
    isResizable : function(colIndex){
        return colIndex >= 0 && this.config[colIndex].resizable !== false && this.config[colIndex].fixed !== true;
    },
    /**
     * 设置列的可见状态
     * @param {Number} colIndex 列索引
     * @param {Boolean} hidden 如果是true，列隐藏
     */
    setHidden : function(colIndex, hidden){
        var c = this.config[colIndex];
        if(c.hidden !== hidden){
            c.hidden = hidden;
            this.totalWidth = null;
            this.fireEvent("hiddenchange", this, colIndex, hidden);
        }
    },

    /**
     * 为某一列设置编辑器
     * @param {Number} col 列索引
     * @param {Object} editor 编辑器
     */
    setEditor : function(col, editor){
        this.config[col].editor = editor;
    }
});

/**
 * @private
 * 默认列的的渲染方法，默认将原来的数据显示到单元格
 */
L5.grid.ColumnModel.defaultRenderer = function(value){
    if(typeof value == "string" && value.length < 1){
        return "&#160;";
    }
    if(value&&value.constructor==Date){
    	return String(value);
    }
    return L5.util.Format.htmlEncode(value);
//    return value;
};
/**
 * @private
 * 文件渲染方法，适用于grid中文件上传列（一个grid只能有一个文件上床列），用的是原始的HTML的fiel选择控件
 */
L5.grid.ColumnModel.fileRenderer = function(file,p,record,rowIndex,colIndex,dataset,name){
		var filename=name+'['+rowIndex+']';
		if(record.state===L5.model.Record.STATE_NEW)
			return "<input type='file' size='16' class='l-form-file' name='"+filename+"'/>";
		else{
			return "<input type='button' dataset='"+dataset.id+"' class='l-form-file-button' onclick='L5.grid.ColumnModel.onEditClick(this)' name='"+filename+"' value='修改'/>"+file.filename;
		}
};
/**
 * @private
 * 当文件单元格被点击的时候触发的。为文件上传控件设置对应单元格文件信息
 */
L5.grid.ColumnModel.onEditClick=function(b){
	var dataset=L5.DatasetMgr.lookup(b.getAttribute('dataset'));
	var filename=b.name;
	var fieldname=filename.substring(0,filename.indexOf('['));
	var index=filename.substring(filename.indexOf('[')+1,filename.indexOf('[')+2);
	var record=dataset.getAt(index);
	record.set(fieldname,filename);
   b.parentNode.innerHTML="<input type='file' size='16' class='l-form-file' name='"+b.name+"'/>";
};
// Alias for backwards compatibility
L5.grid.DefaultColumnModel = L5.grid.ColumnModel;