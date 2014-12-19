/**
  * @class L5.grid.GridView
 * @extends L5.util.Observable
 * 这个类封装了对GridPanel的界面操作的方法和属性。这个类的方法用来控制用户界面显示一些特定的效果。
 * 这个类并不提供改变底层数据的方法，只是通过监控数据模型，检测数据变动，加载等事件，然后相应的改变
 * 用户界面的显示数据。
 * @constructor
 * @param {Object} config 配置对象，一般传过来的是GridPanel/EditGridPanel本身
 */
L5.grid.GridView = function(config){
    L5.apply(this, config);
    //这些事件仅仅用于grid组件内部
    this.addEvents(
      /**
		 * @ignore
		 * @event beforerowremoved 内部事件，当行被移动之前触发
		 * @param {L5.grid.GridView}
		 *            view grid的视图管理对象本身
		 * @param {Number}
		 *            rowIndex 将被移动的行的索引
		 * @param {L5.model.Record}
		 *            record 被移动的行对应的record
		 */
	"beforerowremoved",
	/**
	 * @ignore
	 * @event beforerowsinserted 内部事件，当有行插入到grid之前触发
	 * @param {L5.grid.GridView}
	 *            view grid的视图管理对象本身
	 * @param {Number}
	 *            firstRow 被插入位置的开始索引
	 * @param {Number}
	 *            lastRow 被插入位置的结束索引
	 */
	"beforerowsinserted",
	/**
	 * @ignore
	 * @event beforerefresh
	 * 内部事件，当界面被刷新之前触发
	 * @param {L5.grid.GridView}
	 *            view grid的视图管理对象本身
	 */
	"beforerefresh",
	/**
	 * @ignore
	 * @event rowremoved 
	 * 内部事件，当行被移动之后触发
	 * @param {L5.grid.GridView}
	 *            view grid的视图管理对象本身
	 * @param {Number}
	 *            rowIndex 被移动后的行的索引
	 * @param {L5.model.Record}
	 *            record 被移动行对应的Record
	 */
	"rowremoved",
	/**
	 * @ignore
	 * @event rowsinserted 
	 * 内部事件，当行被插入后触发
	 * @param {L5.grid.GridView}
	 *            view grid的视图管理对象本身
	 * @param {Number}
	 *            firstRow 被插入位置的开始索引
	 * @param {Number}
	 *            lastRow 被插入位置的结束索引
	 */
	"rowsinserted",
	/**
	 * @ignore
	 * @event rowupdated
	 * 内部事件，当行更新后触发
	 * @param {L5.grid.GridView}
	 *            view grid的视图管理对象本身
	 * @param {Number}
	 *            firstRow 被更新的行的索引
	 * @param {L5.model.record}
	 *            record 被更新行对应的索引
	 */
	"rowupdated",
	/**
	 * @ignore
	 * @event refresh Internal UI Event. Fired after the GridView's body has
	 *        been refreshed.
	 *       	内部事件，当grid表体刷新的时候
	 * @param {L5.grid.GridView}
	 *            view grid的视图管理对象本身
	 */
	"refresh"
  );
    L5.grid.GridView.superclass.constructor.call(this);
};

L5.extend(L5.grid.GridView, L5.util.Observable, {
    /**
	 * @ignore 
	 * 通过重写该方法，实现在grid渲染时候自定义行CSS的目的。我们可以通过rowParams为行模板传自定义参数。
	 * 这个方法必须要返回一个CSS类名（如果不需要自定义样式返回''空字符串），该CSS样式将被添加到所有的子
	 * DIV元素中（DOM）。可以返回多个类名，中间用空格隔开例如：'my-class another-class'
	 * @param {Record}
	 *            record 当前行对应的record。
	 * @param {Number}
	 *            index 当前行的索引
	 * @param {Object}
	 *            rowParams 一个配置对象，当渲染行的时候可以将该配置对象自定义的一些行的特性传递给行模板。
	 *            该配置对象仅仅在enableRowBody=true的时候起作用。该配置对象支持的属性有：
	 *            <ul>
	 *            <li><code>body</code> : String <div class="sub-desc">一个HTML代码片段，将被渲染到单元格，默认是""</div></li>
	 *            <li><code>bodyStyle</code> : String <div class="sub-desc">被拥戴列的TR标签上的CSS样式</div></li>
	 *            <li><code>cols</code> : Number <div class="sub-desc">用于列合并的属性，该属性将被赋值给TD
	 *            的colspan属性</div></li>
	 *            </ul>
	 * @param {Dataset}
	 *            dataset grid绑定的数据模型DataSet
	 * @method getRowClass
	 * @return {String} 返回一个CSS类，将被应用到该行
	 */
    /**
     * @ignore
     * @cfg {Boolean} enableRowBody True to add a second TR element per row that can be used to provide a row body
     * that spans beneath the data row.  Use the {@link #getRowClass} method's rowParams config to customize the row body.
     */
    /**
     * @ignore
     * @cfg {String} emptyText 当没有行可以用的时候用来在grid表体部分显示的文本,默认是"".
     */
    /**
     * @ignore
     * @property dragZone
     * @type L5.grid.GridDragZone
     * <p><b>This will only be present if the owning GridPanel was configured with {@link L5.grid.GridPanel#enableDragDrop enableDragDrop} <tt>true</tt>.</b></p>
     * <p><b>This will only be present after the owning GridPanel has been rendered</b>.</p>
     * <p>A customized implementation of a {@link L5.dd.DragZone DragZone} which provides default implementations of the
     * template methods of DragZone to enable dragging of the selected rows of a GridPanel. See {@link L5.grid.GridDragZone} for details.</p>
     */
    /**
     * @ignore
     * @cfg {Boolean} deferEmptyText 如果是true，当dataset第一次load的时候会延迟将emptyText渲染到body上,默认是true
     */
    deferEmptyText: true,
    /**
     * @ignore
     * 预留的滚动条的控件（默认是19px）
     * @type Number
     */
    scrollOffset: 19,
    /**
     * @ignore
     * @cfg {Boolean} autoFill 如果是true，在grid渲染的时候自动将列填充满grid，默认是false.
     */
    autoFill: false,
    /**
     * @ignore
     * @cfg {Boolean} forceFit 如果是true，自动宽展所有列并填充满grid强制不出现水平滚动条。此时各个列设置的width将不起作用
     */
    forceFit: false,
    /**
     * @ignore 
     * @cfg {Array} sortClasses
     * 当排序后再表头显示的css样式数组，（ 默认是["sort-asc", "sort-desc"]）
     * The CSS classes applied to a header when it is sorted. (defaults to ["sort-asc", "sort-desc"])
     * @type Array
     */
    sortClasses : ["sort-asc", "sort-desc"],
    /**
     * @ignore
     * 在菜单中升序排序所显示的文字
     * @type String
     */
    sortAscText : "Sort Ascending",
    /**
     * @ignore
     * 在菜单中降序排序所显示的文字
     * @type String
     */
    sortDescText : "Sort Descending",
    /**
     * @ignore
     * 在菜单中列菜单所显示的文字
     * @type String
     */
    columnsText : "Columns",

    /**
     * @private
     */
    borderWidth: 2,
    tdClass: 'l-grid3-cell',
    hdCls: 'l-grid3-hd',

    /**
     * @ignore
     * @cfg {Number} cellSelectorDepth 当搜索单元格的时候搜索的层级数（默认是4层）
     */
    cellSelectorDepth: 4,
    /**
     * @ignore
     * @cfg {Number} rowSelectorDepth 当搜索行的时候搜索的层级数（默认是10层）
     */
    rowSelectorDepth: 10,

    /**
     * @ignore
     * @cfg {String} cellSelector 查找单元格的时候的CSS选择符
     */
    cellSelector: 'td.l-grid3-cell',
    /**
     * @ignore
     * @cfg {String} rowSelector 查找行的时候的CSS选择符
     */
    rowSelector: 'div.l-grid3-row',
    
    unselect: true,

    /* -------------------------------- UI的具体实现 ----------------------------- */

    /**
     * @private
     * 初始化grid模板，表头模板，表体模板，单元格模板，行模板等
     */
    initTemplates : function(){
        var ts = this.templates || {};
        if(!ts.master){
            ts.master = new L5.Template(
                    '<div class="l-grid3" hidefocus="true">',
                        '<div class="l-grid3-viewport">',
                            '<div class="l-grid3-header"><div class="l-grid3-header-inner"><div class="l-grid3-header-offset">{header}</div></div><div class="l-clear"></div></div>',
                            '<div class="l-grid3-scroller"><div class="l-grid3-body" style="{bodywidth}">{body}</div><a href="#" class="l-grid3-focus" tabIndex="-1"></a></div>',
                        	this.renderSum ? '{sum}' : '',
                        "</div>",
                        '<div class="l-grid3-resize-marker">&#160;</div>',
                        '<div class="l-grid3-resize-proxy">&#160;</div>',
                    "</div>"
                    );
        }

        if(!ts.header){
            ts.header = new L5.Template(
                    '<table border="0" cellspacing="0" cellpadding="0" style="{tstyle}">',
                    '<thead><tr class="l-grid3-hd-row">{cells}</tr></thead>',
                    "</table>"
                    );
        }

        if(!ts.hcell){
            ts.hcell = new L5.Template(
                    '<td class="l-grid3-hd l-grid3-cell l-grid3-td-{id} {css}" style="{style}"><div {tooltip} {attr} class="l-grid3-hd-inner l-grid3-hd-{id}" unselectable="on" style="{istyle}">', this.grid.enableHdMenu ? '<a class="l-grid3-hd-btn" href="#"></a>' : '',
                    '{value}<img class="l-grid3-sort-icon" src="', L5.BLANK_IMAGE_URL, '" />',
                    "</div></td>"
                    );
        }

        if(!ts.body){
            ts.body = new L5.Template('{rows}');
        }

        if(!ts.row){
            ts.row = new L5.Template(
                    '<div class="l-grid3-row {alt}" style="{tstyle}"><table class="l-grid3-row-table" border="0" cellspacing="0" cellpadding="0" style="{tstyle}">',
                    '<tbody><tr>{cells}</tr>',
                    (this.enableRowBody ? '<tr class="l-grid3-row-body-tr" style="{bodyStyle}"><td colspan="{cols}" class="l-grid3-body-cell" tabIndex="0" hidefocus="on"><div class="l-grid3-row-body">{body}</div></td></tr>' : ''),
                    '</tbody></table></div>'
                    );
        }

        if(!ts.cell){
        	var divTmp = '<div title="{valueTip}"  class="l-grid3-cell-inner l-grid3-col-{id}"';
            if(this.unselect)
            	divTmp += ' unselectable="on"';
            divTmp += ' {attr}>{value}</div>';
        	ts.cell = new L5.Template(
                    '<td class="l-grid3-col l-grid3-cell l-grid3-td-{id} {css}" style="{style}" tabIndex="0" {cellAttr}>',
                    divTmp,
                    "</td>"
                    );
        }

        for(var k in ts){
            var t = ts[k];
            if(t && typeof t.compile == 'function' && !t.compiled){
                t.disableFormats = true;
                t.compile();
            }
        }

        this.templates = ts;
        this.colRe = new RegExp("l-grid3-td-([^\\s]+)", "");
    },

    /**
     * @private
     * view自己的轻量级缓存机制。避免创建过多的L5.Element对象
     */
    fly : function(el){
        if(!this._flyweight){
            this._flyweight = new L5.Element.Flyweight(document.body);
        }
        this._flyweight.dom = el;
        return this._flyweight;
    },

    /**
     * @private
     * 获取编辑器的父节点
     * @returns {DOM} 返回编辑器的父节点
     */
    getEditorParent : function(){
        return this.scroller.dom;
    },

    /**
     * @private
     * 初始化GridView用到的L5.Element对象
     */
    initElements : function(){
        var E = L5.Element;

        var el = this.grid.getGridEl().dom.firstChild;
        var cs = el.childNodes;

        this.el = new E(el);

        this.mainWrap = new E(cs[0]);
        this.mainHd = new E(this.mainWrap.dom.firstChild);
		if(this.renderSum){
			this.mainSum=new E(this.mainWrap.dom.childNodes[2]);//TODO 
			this.sumBody=new E(this.mainSum.dom.firstChild.firstChild.rows[0]);//TODO 
		}
        if(this.grid.hideHeaders){
            this.mainHd.setDisplayed(false);
        }

        this.innerHd = this.mainHd.dom.firstChild;
        this.offsetHd = this.mainHd.dom.firstChild.firstChild;
        this.scroller = new E(this.mainWrap.dom.childNodes[1]);
        if(this.forceFit){
            this.scroller.setStyle('overflow-x', 'hidden');
        }
        /**
         * @private
         * view的主体部分，负责管理所有的列，当gridPanel渲染完成后才可以使用
         * @type L5.Element
         * @property mainBody
         */
        this.mainBody = new E(this.scroller.dom.firstChild);

        this.focusEl = new E(this.scroller.dom.childNodes[1]);
        this.focusEl.swallowEvent("click", true);

        this.resizeMarker = new E(cs[1]);
        this.resizeProxy = new E(cs[2]);
    },

    /**
     * @private
     * 获取grid的所有行
     * @returns {Array} 返回所有行的一个数组
     */
    getRows : function(){
        return this.hasRows() ? this.mainBody.dom.childNodes : [];
    },

    // finder methods, used with delegation

    /**
     * @private
     * 获取grid指定单元格的DOM（通过配置项cellSelector，cellSelector是CSS选择符）
     * @param {L5.Element} el 单元格对应的Element对象
     * @return {HTMLElement} 返回匹配上的单元格DOM（如果没有匹配成功返回null）
     */
    findCell : function(el){
        if(!el){
            return false;
        }
        return this.fly(el).findParent(this.cellSelector, this.cellSelectorDepth);
    },

    /**
     * @private
     * 获取单元格的索引
     * @param {L5.Element} el 单元格对应的Element对象
     * @param {String} requiredCls （可选）必须包含的CSS类名
     * @return {Number/Boolean} 返回单元格索引，假如匹配不成功返回false
     */
    findCellIndex : function(el, requiredCls){
        var cell = this.findCell(el);
        if(cell && (!requiredCls || this.fly(cell).hasClass(requiredCls))){
            return this.getCellIndex(cell);
        }
        return false;
    },

    /**
     * @ignore
     * @private
     * 被findCellIndex调用，获取TD的索引
     */
    getCellIndex : function(el){
        if(el){
            var m = el.className.match(this.colRe);
            if(m && m[1]){
                return this.cm.getIndexById(m[1]);
            }
        }
        return false;
    },

    /**
     * @ignore
     * @private
     * 获取表头单元格的DOM
     * 获取grid指定单元格的DOM（通过配置项hdCls，hdCls是CSS选择符）
     * @param {L5.Element} el 表头单元格对应的Element对象
     * @return {HTMLElement} 返回匹配上的单元格DOM（如果没有匹配成功返回null）
     */
    findHeaderCell : function(el){
        var cell = this.findCell(el);
        return cell && this.fly(cell).hasClass(this.hdCls) ? cell : null;
    },

    /**
     * @private
     * 获取表头单元格的索引
     * @param {L5.Element} el 表头单元格对应的Element对象
     * @return {Number/Boolean} 返回单元格索引，假如匹配不成功返回false
     */
    findHeaderIndex : function(el){
        return this.findCellIndex(el, this.hdCls);
    },

	/**
	 * @private
	 * 获取grid表体包含参数el（Element）的行的HTMLElement信息
	 * @param {Element} el 包含的元素对象
	 * @return {HTMLElement} 返回该行的DOM信息，如果没有符合条件的返回null.
	 */
    findRow : function(el){
        if(!el){
            return false;
        }
        return this.fly(el).findParent(this.rowSelector, this.rowSelectorDepth);
    },

	/**
	 * @private
	 * 获取包含指定Element的行的索引
	 * @param {Element} el 被包含的元素对象
	 * @return {Number} 行的索引，如果没有匹配成功返回false.
	 */
    findRowIndex : function(el){
        var r = this.findRow(el);
        return r ? r.rowIndex : false;
    },

    // getter methods for fetching elements dynamically in the grid

	/**
	 * @private
	 * 获取指定索引处的TR对象（HTMLElement）对象
	 * @param {Number} index 指定的索引
	 * @return {HTMLElement} 返回指定索引出的TR对象
	 */
    getRow : function(row){
        return this.getRows()[row];
    },

	/**
	 * @private
	 * 获取表体指定位置的TD对象（HTMLElement）
	 * @param {Number} row 行索引.
	 * @param {Number} col 列索引.
	 * @return {HTMLElement} 返回指定位置的TD对象
	 */
    getCell : function(row, col){
    	if(this.getRow(row))
    		return this.getRow(row).getElementsByTagName('td')[col];
    },

	/**
	 * @private
	 * 获取表头指定索引处的TD（HTMLElement对象）
	 * @param {Number} index 列索引
	 * @return {HtmlElement} 指定索引处的TD对象
	 */
    getHeaderCell : function(index){
      return this.mainHd.dom.getElementsByTagName('td')[index];
    },

    // manipulating elements

    // private - use getRowClass to apply custom row classes
    /**
     * @private
     * 为某行增加自定义CSS样式
     * @param {Number} row 行索引
     * @param {String} cls 要增加的CSS
     */
    addRowClass : function(row, cls){
        var r = this.getRow(row);
        if(r){
            this.fly(r).addClass(cls);
        }
    },
    /**
     * @ignore
     * @private
     * 如果指定行有指定的CSS那就移除，如果没有就增加,并且只有一行可以有这个CSS样式。
     * 为了解决grid的checkbox选择模式而写的方法。
     * @param {Number} row 行索引
     * @param {String} cls 要增加的CSS
     */
    toggleRowClass : function(row , cls){
    	var r = this.getRow(row);
        if(r){
        	if(this.fly(r).hasClass(cls)){
        		this.fly(r).removeClass(cls);
        	} else {
        		this.removeRowClass(this.lastToggleRow,cls);
        		this.fly(r).addClass(cls);
        		this.ds.moveTo(row);
        		this.lastToggleRow = row;
        	}
        }
    },

    /**
     * @private
     * 移除指定行的指定的CSS样式
     * @param {Number} row 行索引
     * @param {String} cls 要移除的CSS
     */
    removeRowClass : function(row, cls){
        var r = this.getRow(row);
        if(r){
            this.fly(r).removeClass(cls);
        }
    },

    /**
     * @private
     * 移除某一行
     * @param {Number} row 行索引
     */
    removeRow : function(row){
        L5.removeNode(this.getRow(row));
        this.syncFocusEl(row);
    },
    
    /**
     * @private
     * 移除指定区间的行
     * @param {Number} firstRow 开始行索引
     * @param {Number} lastRow 结束行索引
     */
    removeRows : function(firstRow, lastRow){
        var bd = this.mainBody.dom;
        for(var rowIndex = firstRow; rowIndex <= lastRow; rowIndex++){
            L5.removeNode(bd.childNodes[firstRow]);
        }
        this.syncFocusEl(firstRow);
    },

    // scrolling stuff

    /**
     * @private
     * 获取滚动条的状态
     */
    getScrollState : function(){
        var sb = this.scroller.dom;
        return {left: sb.scrollLeft, top: sb.scrollTop};
    },

    /**
     * @private
     * 恢复滚动条的位置
     * @param {Object} state 滚动条的状态信息
     */
    restoreScroll : function(state){
        var sb = this.scroller.dom;
        sb.scrollLeft = state.left;
        sb.scrollTop = state.top;
    },

    /**
     * @private
     * 将滚动条置顶
     */
    scrollToTop : function(){
        this.scroller.dom.scrollTop = 0;
        this.scroller.dom.scrollLeft = 0;
    },

    /**
     * @private
     * 当表体滚动的时候同步表头移动,并触发bodyscroll事件
     */
    syncScroll : function(){
    	this.syncHeaderScroll();
      	var mb = this.scroller.dom;
        this.grid.fireEvent("bodyscroll", mb.scrollLeft, mb.scrollTop);
    },

    /**
     * @private
     * 将表体滚动条位置同步到表头
     */
    syncHeaderScroll : function(){
        var mb = this.scroller.dom;
        this.innerHd.scrollLeft = mb.scrollLeft;
        this.innerHd.scrollLeft = mb.scrollLeft; // second time for IE (1/2 time first fails, other browsers ignore)
    },

    /**
     * 更新排序的图标
     * @param {Number} col 要更新图标的列
     * @param {String} dir 图标的样式升序/降序
     */
    updateSortIcon : function(col, dir){
        var sc = this.sortClasses;
        var hds = this.mainHd.select('td').removeClass(sc);
        hds.item(col).addClass(sc[dir == "DESC" ? 1 : 0]);
    },

    /**
     * 更新所有列的宽度，一般用于forceFit是true的时候
     * @private
     */
    updateAllColumnWidths : function(){
        var tw = this.getTotalWidth();
        var clen = this.cm.getColumnCount();
        var ws = [];
        for(var i = 0; i < clen; i++){
            ws[i] = this.getColumnWidth(i);
        }

        this.innerHd.firstChild.firstChild.style.width = tw;

        for(var i = 0; i < clen; i++){
            var hd = this.getHeaderCell(i);
            hd.style.width = ws[i];
        }

        var ns = this.getRows(), row, trow;
        for(var i = 0, len = ns.length; i < len; i++){
            row = ns[i];
            row.style.width = tw;
            if(row.firstChild){
                row.firstChild.style.width = tw;
                trow = row.firstChild.rows[0];
                for (var j = 0; j < clen; j++) {
                   trow.childNodes[j].style.width = ws[j];
                }
            }
        }
        if(row && row.parentNode){
        	row.parentNode.style.width = tw;
        }
        this.onAllColumnWidthsUpdated(ws, tw);
    },

    /**
     * @private
     * 更新某一列的宽度
     * @param {Number} col 指定的列
     * @param {Number} width 要更新的宽度
     */
    updateColumnWidth : function(col, width){
        var w = this.getColumnWidth(col);
        var tw = this.getTotalWidth();
        
        this.innerHd.firstChild.firstChild.style.width = tw;
        var hd = this.getHeaderCell(col);
        hd.style.width = w;

        var ns = this.getRows(), row;
        for(var i = 0, len = ns.length; i < len; i++){
            row = ns[i];
            row.style.width = tw;
            if(row.firstChild){
                row.firstChild.style.width = tw;
                row.firstChild.rows[0].childNodes[col].style.width = w;
            }
        }
        if(row && row.parentNode){
        	row.parentNode.style.width = tw;
        }

        this.onColumnWidthUpdated(col, w, tw);
    },

    /**
     * @private
     * 更新某列的显示隐藏状态
     * @param {Number} col 指定的列
     * @param {Boolean} hidden 是否隐藏
     */
    updateColumnHidden : function(col, hidden){
        var tw = this.getTotalWidth();

        this.innerHd.firstChild.firstChild.style.width = tw;

        var display = hidden ? 'none' : '';

        var hd = this.getHeaderCell(col);
        hd.style.display = display;

        var ns = this.getRows(), row;
        for(var i = 0, len = ns.length; i < len; i++){
            row = ns[i];
            row.style.width = tw;
            if(row.firstChild){
                row.firstChild.style.width = tw;
                row.firstChild.rows[0].childNodes[col].style.display = display;
            }
        }
        if(row && row.parentNode){
        	row.parentNode.style.width = tw;
        }
        
        this.onColumnHiddenUpdated(col, hidden, tw);

        delete this.lastViewWidth; // force recalc
        this.layout();
    },

    /**
     * @private
     * 将指定的行数组的数据渲染到grid表体的指定位置
     * @param {Array} cs 通过getColumnData获取的表头的配置信息数组
     * @param {Array} rs 指定行集合对应的Record数组
     * @param {L5.model.DataSet} ds grid对应的数据模型
     * @param {Number} startRow 要渲染到的指定位置的索引
     * @param {Number} colCount 总的列数
     * @param {Boolean} stripe 
     * @return {String} 返回HTML代码段
     */
    doRender : function(cs, rs, ds, startRow, colCount, stripe){
        var ts = this.templates, ct = ts.cell, rt = ts.row, last = colCount-1;
        var tstyle = 'width:'+this.getTotalWidth()+';';
        // buffers
        var buf = [], cb, c, p = {}, rp = {tstyle: tstyle}, r;
        for(var j = 0, len = rs.length; j < len; j++){
            r = rs[j]; cb = [];
            var rowIndex = (j+startRow);
            for(var i = 0; i < colCount; i++){
                c = cs[i];
                p.id = c.id;
                p.css = i == 0 ? 'l-grid3-cell-first ' : (i == last ? 'l-grid3-cell-last ' : '');
                p.attr = p.cellAttr = "";
                p.value = (""+c.renderer(r.data[c.name], p, r, rowIndex, i, ds,c.name,this.grid)).replace(/\n/g, '<br/>');
                if(this.cm.config[i].valueTip){
                	if(L5.isIE){
                		p.valueTip = p.value.replace(/<br\/>/g, '\n');
        			}else{
        				p.valueTip = p.value.replace(/<br\/>/g, '&#13;');
        			}
                }else{
                	delete p.valueTip;
                }
                p.style = c.style;
                if(p.value == undefined || p.value === "") p.value = "&#160;";
                if((r.dirty && typeof r.modified[c.name] !== 'undefined')){
                    p.css += ' l-grid3-dirty-cell';
                }
                //将校验从脏或者修改状态拿出来，因为第一次渲染或者新增也需要校验。
                L5.Validator.validate(r,c.name,r.data[c.name]);//首先校验一下，防止set滞后调用。
                if(r.validate[c.name]!=null){
                	
                	//修改提示校验信息不准确的bug（如果有隐藏列将隐藏列也算上了，列号和我们看到的界面上的列不同）
                	/*var beforeHiddenCount=0;//记录前面不是隐藏列的数目
                	for (var t=0; t < i+1; t++){
                        if(this.cm.isHidden(t)){
                        	beforeHiddenCount++;
                        }
                    }*/
                	
                	var msgLable=L5.di + (rowIndex+1) + L5.hang + c.header + L5.lie;
                	if(!r.cellLable)r.cellLable={};
                	r.cellLable[c.name]=msgLable;//将错误提示回填进msgLabel里
//                	var msg = L5.di + (rowIndex+1) + L5.hang + L5.di + (i-beforeHiddenCount+1) + L5.lie + r.msg[c.name];
                	var msg = L5.di + (rowIndex+1) + L5.hang + c.header + L5.lie+ r.msg[c.name];
                	p.css += ' l-grid3-validate-cell';
                	if(L5.QuickTips){ // fix for floating editors interacting with DND
                		L5.QuickTips.enable();
                	}
                	p.attr="L5:qtitle="+L5.valError+" L5:qtip=" + msg;
                	
                }
                cb[cb.length] = ct.apply(p);
            }
            var alt = [];
            if(stripe && ((rowIndex+1) % 2 == 0)){
                alt[0] = "l-grid3-row-alt";
            }
            if(r.dirty){
                alt[1] = " l-grid3-dirty-row";
            }
            rp.cols = colCount;
            if(this.getRowClass){
                alt[2] = this.getRowClass(r, rowIndex, rp, ds);
            }
            rp.alt = alt.join(" ");
            rp.cells = cb.join("");
            buf[buf.length] =  rt.apply(rp);
        }
        return buf.join("");
    },

    /**
     * @private
     * 处理从索引处开始的剩余的行，主要是处理序号列，文件列等
     */
    processRows : function(startRow, skipStripe){
        if(this.ds.getCount() < 1){
            return;
        }
        skipStripe = skipStripe || !this.grid.stripeRows;
        startRow = startRow || 0;
        var rows = this.getRows();
        var cls = ' l-grid3-row-alt ';
        if(this.grid.isEditor||this.grid.notSelectFirstRow){
        	rows[0].className += ' l-grid3-row-first ';
        }else{
        	this.grid.getSelectionModel().selectFirstRow();
        	rows[0].className += ' l-grid3-row-first l-grid3-row-selected';
        }
        rows[rows.length - 1].className += ' l-grid3-row-last';
        for(var i = startRow, len = rows.length; i < len; i++){
            var row = rows[i];
            row.rowIndex = i;
            var numbererCell=L5.fly(row).query("div.l-grid3-col-numberer",row);
            var fileCell=L5.fly(row).query("input.l-form-file",row);
            if(numbererCell[0]){//if we have rowNumbererCell is a DIV[0]
            	numbererCell[0].innerHTML=i+1;//reset the rowNumber
            }
            if(fileCell[0]){//支持多列上传文件时需修改此处
            	var oldname=fileCell[0].name;
            	var fieldname=oldname.substring(0,oldname.indexOf('['));
            	var newname=fieldname+'['+i+']';
            	this.ds.getAt(i).set(fieldname,newname);
            	fileCell[0].name=newname;
            }
            if(!skipStripe){
                var isAlt = ((i+1) % 2 == 0);
                var hasAlt = (' '+row.className + ' ').indexOf(cls) != -1;
                if(isAlt == hasAlt){
                    continue;
                }
                if(isAlt){
                    row.className += " l-grid3-row-alt";
                }else{
                    row.className = row.className.replace("l-grid3-row-alt", "");
                }
            }
        }
    },
    /**
     * @private
     * 渲染grid的表体，以及处理序号列和文件长传列
     */
    afterRender: function(){
        this.mainBody.dom.innerHTML = this.renderRows();
        this.processRows(0, true);

        if(this.deferEmptyText !== true){
            this.applyEmptyText();
        }
    },

    /**
     * @private
     * 渲染整体的grid表体，将大体的框架渲染出来，具体的表体内的数据行
     * 有专门的渲染方法
     */
    renderUI : function(){

        var header = this.renderHeaders();
        var body = this.templates.body.apply({rows:''});
		var main=null;
		if(this.renderSum){
			main={
			 body: body,
             header: header,
             bodywidth:'width:'+this.getTotalWidth()+';',
             sum:this.renderSum()
			};
		}else{
			main={
			 body: body,
             header: header,
             bodywidth:'width:'+this.getTotalWidth()+';'
			};
		}
        var html = this.templates.master.apply(main);

        var g = this.grid;
		
        g.getGridEl().dom.innerHTML = html;

        this.initElements();

        // get mousedowns early
        L5.fly(this.innerHd).on("click", this.handleHdDown, this);
        this.mainHd.on("mouseover", this.handleHdOver, this);
        this.mainHd.on("mouseout", this.handleHdOut, this);
        this.mainHd.on("mousemove", this.handleHdMove, this);

        this.scroller.on('scroll', this.syncScroll,  this);
        if(g.enableColumnResize !== false){
            this.splitZone = new L5.grid.GridView.SplitDragZone(g, this.mainHd.dom);
        }

        if(g.enableColumnMove){
            this.columnDrag = new L5.grid.GridView.ColumnDragZone(g, this.innerHd);
            this.columnDrop = new L5.grid.HeaderDropZone(g, this.mainHd.dom);
        }

        if(g.enableHdMenu !== false){
            if(g.enableColumnHide !== false){
                this.colMenu = new L5.menu.Menu({id:g.id + "-hcols-menu"});
                this.colMenu.on("beforeshow", this.beforeColMenuShow, this);
                this.colMenu.on("itemclick", this.handleHdMenuClick, this);
            }
            this.hmenu = new L5.menu.Menu({id: g.id + "-hctx"});
            this.hmenu.add(
                {id:"asc", text: this.sortAscText, cls: "xg-hmenu-sort-asc"},
                {id:"desc", text: this.sortDescText, cls: "xg-hmenu-sort-desc"}
            );
            if(g.enableColumnHide !== false){
                this.hmenu.add('-',
                    {id:"columns", text: this.columnsText, menu: this.colMenu, iconCls: 'l-cols-icon'}
                );
            }
            this.hmenu.on("itemclick", this.handleHdMenuClick, this);

            //g.on("headercontextmenu", this.handleHdCtx, this);
        }

        if(g.trackMouseOver){
            this.mainBody.on("mouseover", this.onRowOver, this);
            this.mainBody.on("mouseout", this.onRowOut, this);
        }
        if(g.enableDragDrop || g.enableDrag){
            this.dragZone = new L5.grid.GridDragZone(g, {
                ddGroup : g.ddGroup || 'GridDD'
            });
        }

        this.updateHeaderSortState();

    },

    /**
     * 整体设置grid的位置，大小，样式等信息
     */
    layout : function(){
        if(!this.mainBody){
            return; // not rendered
        }
        var g = this.grid;
        var c = g.getGridEl();
        var csize = c.getSize(true);
        var vw = csize.width;

        if(vw < 20 || csize.height < 20){ // display: none?
            return;
        }

        if(g.autoHeight){
            this.scroller.dom.style.overflow = 'visible';
            if(L5.isSafari){
                this.scroller.dom.style.position = 'static';
            }
        }else{
            this.el.setSize(csize.width, csize.height);

            var hdHeight = this.mainHd.getHeight();
            var vh = csize.height - (hdHeight);

            this.scroller.setSize(vw, vh);
            if(this.innerHd){
            	this.innerHd.style.width = (vw-15)+'px';
            }
        }
        if(this.forceFit){
            if(this.lastViewWidth != vw){
                this.fitColumns(false, false);
                this.lastViewWidth = vw;
            }
        }else {
            this.autoExpand();
            this.syncHeaderScroll();
        }
        this.onLayout(vw, vh);
    },

    // template functions for subclasses and plugins
    // these functions include precalculated values
    onLayout : function(vw, vh){
        // do nothing
    },
    /**
     * @private
     */
    onColumnWidthUpdated : function(col, w, tw){
        //template method
        this.focusEl.setWidth(tw);
    },
    /**
     * @private
     */
    onAllColumnWidthsUpdated : function(ws, tw){
        //template method
        this.focusEl.setWidth(tw);
    },
    /**
     * @private
     */
    onColumnHiddenUpdated : function(col, hidden, tw){
        // template method
        this.focusEl.setWidth(tw);
    },
    /**
     * @private
     * 更新单元格的提示信息
     * @param {Number}  row 行索引
     * @param {Number}  col 列索引
     * @param {String}  text 单元格的显示信息
     * @param {String}  css 单元格的CSS样式
     * @param {String}  attr 包含提示信息的字符串
     */
    updateColumnText : function(row,col,text,css,attr){
    	var cell=this.getCell(row,col);
    	if(cell){
    		if(attr==""){
    			cell.firstChild.removeAttribute("L5:qtitle");
    			cell.firstChild.removeAttribute("L5:qtip");
    		} else {
    			if(L5.QuickTips){ // fix for floating editors interacting with DND
            		L5.QuickTips.enable();
            	}
    			var tp = attr.split(" ");
    			cell.firstChild.setAttribute("L5:qtitle",tp[0].split("=")[1]);
    			cell.firstChild.setAttribute("L5:qtip",tp[1].split("=")[1]);
    		}
    		if(css.indexOf("l-grid3-dirty-cell")==-1)
    			L5.fly(cell).removeClass("l-grid3-dirty-cell");
    		if(css.indexOf("l-grid3-validate-cell")==-1)
    			L5.fly(cell).removeClass("l-grid3-validate-cell");
    		L5.fly(cell).addClass(css);
    		L5.fly(cell).child("div").update(text);
    		/**
    		 * 如果需要浮动显示值，就设置否则移除属性
    		 */
    		if(this.cm.config[col].valueTip){//浮动显示要分行
    			if(L5.isIE){
    				cell.firstChild.setAttribute("title",text.replace(/<br\/>/g, '\n'));
    			}else{
    				cell.firstChild.setAttribute("title",text.replace(/<br\/>/g, '&#13;'));
    			}
            }else{
            	cell.firstChild.removeAttribute("title");
            }
    	}
        // template method
    },

    afterMove : function(oldIndex,colIndex){
        // template method
    },

    /* ----------------------------------- Core Specific -------------------------------------------*/
    /**
     * @private
     * 初始化grid的基本信息，包括模板（grid主体，表头，表体，行单元格等）
     * 然后将数据模型的事件初始化，通过监听数据模型的变化更新表格信息，最后初始化UI的事件
     */
    init: function(grid){
        this.grid = grid;
        this.unselect = grid.unselect;
        this.initTemplates();
        this.initData(grid.dataset, grid.colModel);
        this.initUI(grid);
        
    },

    /**
     * @private
     * 获取指定列的ID
     * @param {Number} index 列的索引
     * @return {String} 返回列id
     */
    getColumnId : function(index){
      return this.cm.getColumnId(index);
    },

    /**
     * @private
     * 渲染表头
     */
    renderHeaders : function(){
        var cm = this.cm, ts = this.templates;
        var ct = ts.hcell;

        var cb = [], sb = [], p = {};
        var len = cm.getColumnCount();
        var last = len - 1;
        for(var i = 0; i < len; i++){
            p.id = cm.getColumnId(i);
            p.value = cm.getColumnHeader(i) || "";
            p.style = this.getColumnStyle(i, true);
            p.tooltip = this.getColumnTooltip(i);
            p.css = i == 0 ? 'l-grid3-cell-first ' : (i == last ? 'l-grid3-cell-last ' : '');
            if(cm.config[i].align == 'right'){
                p.istyle = 'padding-right:16px';
            } else {
                delete p.istyle;
            }
            cb[cb.length] = ct.apply(p);
        }
        return ts.header.apply({cells: cb.join(""), tstyle:'width:'+this.getTotalWidth()+';'});
    },

    /**
     * @private
     * 获取列的提示信息
     * @param {Number} i 列的索引
     * @return {String} 列的提示信息
     */
    getColumnTooltip : function(i){
        var tt = this.cm.getColumnTooltip(i);
        if(tt){
            if(L5.QuickTips.isEnabled()){
                return 'L5:qtip="'+tt+'"';
            }else{
                return 'title="'+tt+'"';
            }
        }
        return "";
    },

    /**
     * @private
     */
    beforeUpdate : function(){
        this.grid.stopEditing(true);
    },

    /**
     * @private
     */
    updateHeaders : function(){
        this.innerHd.firstChild.innerHTML = this.renderHeaders();
    },

    /**
     * 定位到某行.
     * @param {Number} row 行号
     */
    focusRow : function(row){
        this.focusCell(row, 0, false);
    },

    /**
     * 定位到某个cell单元格.
     * @param {Number} row 行号
     * @param {Number} col 列号
     * @param {Boolean} hscroll 是否计算隐藏列
     */
    focusCell : function(row, col, hscroll){
		this.syncFocusEl(this.ensureVisible(row, col, hscroll));
        if(L5.isGecko){
            this.focusEl.focus();
        }else{
            //this.focusEl.focus.defer(1, this.focusEl);
        	this.scroller.focus();//消除正在编辑单元的焦点
        }
    },
    /**
     * @private
     * 通过行索引列索引获取行的DOM和单元格的DOM
     * @param {Number} row 行索引
     * @param {Number} col 列索引
     * @param {Boolean} hscroll 是否计算隐藏的列
     * @return {Object} 返回一个对象，里面有属性row和cell，分别指向行和单元格
     */
	resolveCell : function(row, col, hscroll){
		if(typeof row != "number"){
            row = row.rowIndex;
        }
        if(!this.ds){
            return null;
        }
        if(row < 0 || row >= this.ds.getCount()){
            return null;
        }
        col = (col !== undefined ? col : 0);

        var rowEl = this.getRow(row), cellEl;
        if(!(hscroll === false && col === 0)){
            while(this.cm.isHidden(col)){
                col++;
            }
            cellEl = this.getCell(row, col);
        }

		return {row: rowEl, cell: cellEl};
	},
	/**
	 * @private
	 * 获取指定对象（resolveCell返回的对象）的XY信息
	 * @param {Object} 返回一个对象，里面有属性row和cell，分别指向行和单元格
	 */
	getResolvedXY : function(resolved){
		if(!resolved){
			return null;
		}
		var s = this.scroller.dom, c = resolved.cell, r = resolved.row;
		return c ? L5.fly(c).getXY() : [this.el.getX(), L5.fly(r).getY()];
	},
	/**
	 * @private
	 * 聚焦到某一单元格，被focusCell调用
	 * @param {Number} row 行号
     * @param {Number} col 列号
     * @param {Boolean} hscroll 是否计算隐藏列
	 */
	syncFocusEl : function(row, col, hscroll){
		var xy = row;
		if(!L5.isArray(xy)){
			row = Math.min(row, Math.max(0, this.getRows().length-1));
        	xy = this.getResolvedXY(this.resolveCell(row, col, hscroll));
		}
		if(xy)
			this.focusEl.setY(xy[1]||this.scroller.getXY()[1]);//只处理focus的Y坐标，防止scoller过宽，拖动scollbar不准确
    },
    /**
     * @private
     * 让某单元格可见
     * @param {Number} row 行号
     * @param {Number} col 列号
     * @param {Boolean} hscroll 是否计算隐藏列
     */
	ensureVisible : function(row, col, hscroll){
        var resolved = this.resolveCell(row, col, hscroll);
		if(!resolved || !resolved.row){
			return;
		}

		var rowEl = resolved.row, cellEl = resolved.cell;

		var c = this.scroller.dom;

        var ctop = 0;
        var p = rowEl, stop = this.el.dom;
        while(p && p != stop){
            ctop += p.offsetTop;
            p = p.offsetParent;
        }
        ctop -= this.mainHd.dom.offsetHeight;

        var cbot = ctop + rowEl.offsetHeight;

        var ch = c.clientHeight;
        var stop = parseInt(c.scrollTop, 10);
        var sbot = stop + ch;

//		if(ctop < stop){
//          c.scrollTop = ctop;消除grid跳动效果，即使以后在最后一条，却选择第一条，
//        }else if(cbot > sbot){也不能使其进入视野，只能自己拖动滚动条
//            c.scrollTop = cbot-ch;
//        }

        if(hscroll !== false){
            var cleft = parseInt(cellEl.offsetLeft, 10);
            var cright = cleft + cellEl.offsetWidth;

            var sleft = parseInt(c.scrollLeft, 10);
            var sright = sleft + c.clientWidth;
            if(cleft < sleft){
                c.scrollLeft = cleft;
            }else if(cright > sright){
                c.scrollLeft = cright-c.clientWidth;
            }
        }
        return this.getResolvedXY(resolved);
    },

    /**
     * @private
     * 插入指定区间的行，从grid绑定的Ds中获取数据然后渲染数据
     * @param {L5.model.DataSet} dm grid的数据模型
     * @param {Number} firstRow 开始的索引
     * @param {Number} lastRow 结束的索引
     * @param {Boolean} isUpdate 时候是更新
     */
    insertRows : function(dm, firstRow, lastRow, isUpdate){
        if(!isUpdate && firstRow === 0 && lastRow >= dm.getCount()-1){
            this.refresh();
        }else{
            if(!isUpdate){
                this.fireEvent("beforerowsinserted", this, firstRow, lastRow);
            }
            var html = this.renderRows(firstRow, lastRow);
            var before = this.getRow(firstRow);
            if(before){
                L5.DomHelper.insertHtml('beforeBegin', before, html);
            }else{
                L5.DomHelper.insertHtml('beforeEnd', this.mainBody.dom, html);
            }
            if(!isUpdate){
                this.fireEvent("rowsinserted", this, firstRow, lastRow);
                this.processRows(firstRow);
            }
        }
        this.syncFocusEl(firstRow);
    },
    /**
     * @private
     * 更新某一行的数据
     * @param {L5.model.Record} record 要更新的行对应的record
     * @param {Number} index 行索引
     */
    updateRow :function(record,index){
        var cm = this.cm, colCount = cm.getColumnCount(),last = colCount-1,alt=" l-grid3-dirty-row";
        for(var i = 0; i < colCount; i++){
        	if(cm.isFileColumn(i)){
        		if(!cm.getRenderer(i).doRender)
        			continue;
        	}
            var name = cm.getDataIndex(i);
            var cellcss='';
            var attr="";
            var value=(cm.getRenderer(i)(record.get(name),{},record,index,i,{},name,this.grid)+"").replace(/\n/g, '<br/>');
            if(value == undefined ||value === "")value = "&#160;";
            if(record.dirty && typeof record.modified[name] !== 'undefined'){
                cellcss += ' l-grid3-dirty-cell';
            }
            //将校验从脏或者修改状态拿出来，因为第一次渲染或者新增也需要校验。
            L5.Validator.validate(record,name,record.get(name));//首先校验一下，防止set滞后调用。
            if(record.validate[name]!=null){
            	
            	//修改提示校验信息不准确的bug（如果有隐藏列将隐藏列也算上了，列号和我们看到的界面上的列不同）
            	/*var beforeHiddenCount=0;//记录前面不是隐藏列的数目
            	for (var t=0; t < rowIndex+1; t++){
                    if(this.cm.isHidden(t)){
                    	beforeHiddenCount++;
                    }
                }*/
            	
            	var msgLable=L5.di + (index+1) + L5.hang + cm.getColumnHeader(i) + L5.lie;
            	if(!record.cellLable)record.cellLable={};
            	record.cellLable[name]=msgLable;//将错误提示回填进msgLabel里
//            	var msg = L5.di + (index+1) + L5.hang + L5.di + (i+1-beforeHiddenCount) + L5.lie + record.msg[name];
            	var msg=L5.di + (index+1) + L5.hang + cm.getColumnHeader(i) + L5.lie + record.msg[name];
            	cellcss += ' l-grid3-validate-cell';
            	if(L5.QuickTips){ // fix for floating editors interacting with DND
            		L5.QuickTips.enable();
            	}
            	attr="L5:qtitle="+L5.valError+" L5:qtip=" + msg;
            }
            this.updateColumnText(index,i,value,cellcss,attr);
        }
    },
    /**
     * @private
     * 删除指定区间的行
     * @param {L5.model.DataSet} dm grid的数据模型
     * @param {Number} firstRow 开始的索引
     * @param {Number} lastRow 结束的索引
     */
    deleteRows : function(dm, firstRow, lastRow){
        if(dm.getRowCount()<1){
            this.refresh();
        }else{
            this.fireEvent("beforerowsdeleted", this, firstRow, lastRow);

            this.removeRows(firstRow, lastRow);

            this.processRows(firstRow);
            this.fireEvent("rowsdeleted", this, firstRow, lastRow);
        }
    },

    /**
     * @private
     * 获取列的样式信息
     * @param {Number} col 列的索引
     * @param {Boolean} isHeader 是否是表头
     * @return {String} 返回DOM的Style信息
     */
    getColumnStyle : function(col, isHeader){
        var style = !isHeader ? (this.cm.config[col].css || '') : '';
        style += 'width:'+this.getColumnWidth(col)+';';
        if(this.cm.isHidden(col)){
            style += 'display:none;';
        }
        var align = this.cm.config[col].align;
        if(isHeader){
        	align="center";
        }
        if(align){
            style += 'text-align:'+align+';';
        }
        return style;
    },

    /**
     * @private
     * 获取指定列的宽度
     * @param {Number} col 列的索引
     * @return {Number} 返回列的宽度信息
     */
    getColumnWidth : function(col){
        var w = this.cm.getColumnWidth(col);
        if(typeof w == 'number'){
            return (L5.isBorderBox ? w : (w-this.borderWidth > 0 ? w-this.borderWidth:0)) + 'px';
        }else{
        	w=parseInt(w)+"%";
        }
        return w;
    },

    /**
     * @private
     * 获取总的列的宽度
     * @return {String} 返回所有列的宽度
     */
    getTotalWidth : function(){
        return isNaN(this.cm.getTotalWidth()/1)?this.cm.getTotalWidth():this.cm.getTotalWidth()+'px';
    },

    /**
     * @private
     * 强制所有列宽自动调整，充满grid组件
     * @param {Boolean} preventRefresh 
     * @param {Boolean} onlyExpand 
     * @param {Number} omitColumn
     */
    fitColumns : function(preventRefresh, onlyExpand, omitColumn){
        var cm = this.cm, leftOver, dist, i;
        var tw = cm.getTotalWidth(false);
        var aw = this.grid.getGridEl().getWidth(true)-this.scrollOffset;

        if(aw < 20){ // not initialized, so don't screw up the default widths
            return;
        }
        var extra = aw - tw;

        if(extra === 0){
            return false;
        }

        var vc = cm.getColumnCount(true);
        var ac = vc-(typeof omitColumn == 'number' ? 1 : 0);
        if(ac === 0){
            ac = 1;
            omitColumn = undefined;
        }
        var colCount = cm.getColumnCount();
        var cols = [];
        var extraCol = 0;
        var width = 0;
        var w;
        for (i = 0; i < colCount; i++){
            if(!cm.isHidden(i) && !cm.isFixed(i) && i !== omitColumn){
                w = cm.getColumnWidth(i);
                cols.push(i);
                extraCol = i;
                cols.push(w);
                width += w;
            }
        }
        var frac = (aw - cm.getTotalWidth())/width;
        while (cols.length){
            w = cols.pop();
            i = cols.pop();
            cm.setColumnWidth(i, Math.max(this.grid.minColumnWidth, Math.floor(w + w*frac)), true);
        }

        if((tw = cm.getTotalWidth(false)) > aw){
            var adjustCol = ac != vc ? omitColumn : extraCol;
             cm.setColumnWidth(adjustCol, Math.max(1,
                     cm.getColumnWidth(adjustCol)- (tw-aw)), true);
        }

        if(preventRefresh !== true){
            this.updateAllColumnWidths();
        }


        return true;
    },

    /**
     * @private
     * 自动调整列的宽度
     * @param {Boolean} preventUpdate
     */
    autoExpand : function(preventUpdate){
        var g = this.grid, cm = this.cm;
        if(!this.userResized && g.autoExpandColumn){
            var tw = cm.getTotalWidth(false);
            var aw = this.grid.getGridEl().getWidth(true)-this.scrollOffset;
            if(tw != aw){
                var ci = cm.getIndexById(g.autoExpandColumn);
                var currentWidth = cm.getColumnWidth(ci);
                var cw = Math.min(Math.max(((aw-tw)+currentWidth), g.autoExpandMin), g.autoExpandMax);
                if(cw >= currentWidth){//如果剩余的没有当前的宽则保持默认宽度
                    cm.setColumnWidth(ci, cw, true);
                    if(preventUpdate !== true){
                        this.updateColumnWidth(ci, cw);
                    }
                }
            }
        }
    },

    /**
     * @private
     * 获取所有列的配置信息
     * @return {Array) 返回所有列的配置信息数组，数组中每个元素都对应了该列的配置信息
     */
    getColumnData : function(){
        // build a map for all the columns
        var cs = [], cm = this.cm, colCount = cm.getColumnCount();
        for(var i = 0; i < colCount; i++){
            var name = cm.getDataIndex(i);
            cs[i] = {
            	header : cm.getColumnHeader(i),
                name : (typeof name == 'undefined' ? this.ds.fields.get(i).name : name),
                renderer : cm.getRenderer(i),
                id : cm.getColumnId(i),
                style : this.getColumnStyle(i)
            };
        }
        return cs;
    },

    /**
     * @private
     * 渲染指定区间的行
     * @param {Number} startRow 开始的行索引
     * @param {Number} endRow 结束的行索引
     * @return {String} 返回HTML代码段
     */
    renderRows : function(startRow, endRow){
        // pull in all the crap needed to render rows
        var g = this.grid, cm = g.colModel, ds = g.dataset, stripe = g.stripeRows;
        var colCount = cm.getColumnCount();

        if(ds.getCount() < 1){
            return "";
        }

        var cs = this.getColumnData();

        startRow = startRow || 0;
        endRow = typeof endRow == "undefined"? ds.getCount()-1 : endRow;

        // records to render
        var rs = ds.getRange(startRow, endRow);

        return this.doRender(cs, rs, ds, startRow, colCount, stripe);
    },

    /**
     * @private
     * 渲染grid的body部分
     */
    renderBody : function(){
        var markup = this.renderRows();
        return this.templates.body.apply({rows: markup});
    },

    /**
     * @private
     * 刷新某一行的数据
     * @param {L5.model.Record} record 该行对应的record
     */
    refreshRow : function(record){
        var ds = this.ds, index;
        if(typeof record == 'number'){
            index = record;
            record = ds.getAt(index);
        }else{
            index = ds.indexOf(record);
        }
//        this.insertRows(ds, index, index, true);
        this.updateRow(record,index);
//        this.getRow(index).rowIndex = index;
//        this.onRemove(ds, record, index+1, true);
        this.fireEvent("rowupdated", this, index, record);
    },
    /**
     * 刷新视图
     * @param {Boolean} headersToo (可选) 设置true则也刷新grid头
     */
    refresh : function(headersToo){
        this.fireEvent("beforerefresh", this);
        this.grid.stopEditing(true);

        var result = this.renderBody();
        this.mainBody.update(result);
        this.grid.getSelectionModel().clearSelections();
        if(headersToo === true){
            this.updateHeaders();
            this.updateHeaderSortState();
        }
        this.processRows(0, true);
        this.layout();
        this.applyEmptyText();
        this.fireEvent("refresh", this);
    },

    /**
     * @private
     * 当没有数据的时候将emptyText信息渲染到主体部分
     */
    applyEmptyText : function(){
        if(this.emptyText && !this.hasRows()){
            this.mainBody.update('<div class="l-grid-empty">' + this.emptyText + '</div>');
        }
    },

    /**
     * @private
     * 更新表头的排序状态
     */
    updateHeaderSortState : function(){
        var state = this.ds.getSortState();
        if(!state){
            return;
        }
        if(!this.sortState || (this.sortState.field != state.field || this.sortState.direction != state.direction)){
            this.grid.fireEvent('sortchange', this.grid, state);
        }
        this.sortState = state;
        var sortColumn = this.cm.findColumnIndex(state.field);
        if(sortColumn != -1){
            var sortDir = state.direction;
            this.updateSortIcon(sortColumn, sortDir);
        }
    },

    /**
     * @private
     * 销毁view对象背身，释放资源
     */
    destroy : function(){
        if(this.colMenu){
            L5.menu.MenuMgr.unregister(this.colMenu);
            this.colMenu.destroy();
            delete this.colMenu;
        }
        if(this.hmenu){
            L5.menu.MenuMgr.unregister(this.hmenu);
            this.hmenu.destroy();
            delete this.hmenu;
        }
        if(this.grid.enableColumnMove){
            var dds = L5.dd.DDM.ids['gridHeader' + this.grid.getGridEl().id];
            if(dds){
                for(var dd in dds){
                    if(!dds[dd].config.isTarget && dds[dd].dragElId){
                        var elid = dds[dd].dragElId;
                        dds[dd].unreg();
                        L5.get(elid).remove();
                    } else if(dds[dd].config.isTarget){
                        dds[dd].proxyTop.remove();
                        dds[dd].proxyBottom.remove();
                        dds[dd].unreg();
                    }
                    if(L5.dd.DDM.locationCache[dd]){
                        delete L5.dd.DDM.locationCache[dd];
                    }
                }
                delete L5.dd.DDM.ids['gridHeader' + this.grid.getGridEl().id];
            }
        }
        
        if(this.dragZone){
            this.dragZone.unreg();
        }
        
        L5.fly(this.innerHd).removeAllListeners();
        L5.removeNode(this.innerHd);
        L5.removeNode(this.offsetHd);
        if(this.sumBody)L5.removeNode(this.sumBody);
        L5.destroy(this.resizeMarker, this.resizeProxy, this.focusEl, this.mainBody, 
                    this.scroller, this.mainHd,this.mainSum,this.mainWrap, this.dragZone, 
                    this.splitZone, this.columnDrag, this.columnDrop);

        this.initData(null, null);
        L5.EventManager.removeResizeListener(this.onWindowResize, this);
        this.purgeListeners();
    },

    /**
     * @private
     */
    onDenyColumnHide : function(){

    },

    /**
     * @private
     * 渲染grid本身，将出了表体数据部分全部渲染
     */
    render : function(){
        if(this.autoFill){
            var ct = this.grid.ownerCt;
            if (ct && ct.getLayout()){
                ct.on('afterlayout', function(){ 
                    this.fitColumns(true, true);
                    this.updateHeaders(); 
                }, this, {single: true}); 
            }else{ 
                this.fitColumns(true, true); 
            }
        }else if(this.forceFit){
            this.fitColumns(true, false);
        }else if(this.grid.autoExpandColumn){
            this.autoExpand(true);
        }

        this.renderUI();
    },

    /* --------------------------------- Model Events and Handlers --------------------------------*/
    /**
     * @private
     * 初始化数据模型的事件监控，通过监听事件来更新自身的表体
     */
    initData : function(ds, cm){
        if(this.ds){
            this.ds.un("load", this.onLoad, this);
            this.ds.un("datachanged", this.onDataChange, this);
            this.ds.un("add", this.onAdd, this);
            this.ds.un("remove", this.onRemove, this);
            this.ds.un("update", this.onUpdate, this);
            this.ds.un("clear", this.onClear, this);
           
        }
        if(ds){
            ds.on("load", this.onLoad, this);
            ds.on("datachanged", this.onDataChange, this);
            ds.on("add", this.onAdd, this);
            ds.on("remove", this.onRemove, this);
            ds.on("update", this.onUpdate, this);
            ds.on("clear", this.onClear, this);
            
        }
        this.ds = ds;

        if(this.cm){
            this.cm.un("configchange", this.onColConfigChange, this);
            this.cm.un("widthchange", this.onColWidthChange, this);
            this.cm.un("headerchange", this.onHeaderChange, this);
            this.cm.un("hiddenchange", this.onHiddenChange, this);
            this.cm.un("columnmoved", this.onColumnMove, this);
            this.cm.un("columnlockchange", this.onColumnLock, this);
        }
        if(cm){
            delete this.lastViewWidth;
            cm.on("configchange", this.onColConfigChange, this);
            cm.on("widthchange", this.onColWidthChange, this);
            cm.on("headerchange", this.onHeaderChange, this);
            cm.on("hiddenchange", this.onHiddenChange, this);
            cm.on("columnmoved", this.onColumnMove, this);
            cm.on("columnlockchange", this.onColumnLock, this);
        }
        this.cm = cm;
    },
        
    /**
     * @private
     */
    onDataChange : function(){
        this.refresh();
        this.updateHeaderSortState();
        this.syncFocusEl(0);
    },

    /**
     * @private
     */
    onClear : function(){
        this.refresh();
        this.syncFocusEl(0);
    },

    /**
     * @private
     */
    onUpdate : function(ds, record){
    	this.refreshRow.defer(1, this, [record]);
//      this.refreshRow(record);
    },

    /**
     * @private
     */
    onAdd : function(ds, records, index){
        this.insertRows(ds, index, index + (records.length-1));
    },

    /**
     * @private
     */
    onRemove : function(ds, record, index, isUpdate){
        if(isUpdate !== true){
            this.fireEvent("beforerowremoved", this, index, record);
        }
        this.removeRow(index);
        if(isUpdate !== true){
            this.processRows(index);
            this.applyEmptyText();
            this.fireEvent("rowremoved", this, index, record);
        }
    },

    /**
     * @private
     */
    onLoad : function(){
        this.scrollToTop();
    },

    /**
     * @private
     */
    onColWidthChange : function(cm, col, width){
        this.updateColumnWidth(col, width);
    },

    /**
     * @private
     */
    onHeaderChange : function(cm, col, text){
        this.updateHeaders();
    },

    /**
     * @private
     */
    onHiddenChange : function(cm, col, hidden){
        this.updateColumnHidden(col, hidden);
    },

    /**
     * @private
     */
    onColumnMove : function(cm, oldIndex, newIndex){
        this.indexMap = null;
        var s = this.getScrollState();
        this.refresh(true);
        this.restoreScroll(s);
        this.afterMove(oldIndex,newIndex);
    },

    /**
     * @private
     */
    onColConfigChange : function(){
        delete this.lastViewWidth;
        this.indexMap = null;
        this.refresh(true);
    },

    /* -------------------- UI Events and Handlers ------------------------------ */
    /**
     * @private
     */
    initUI : function(grid){
        grid.on("headerclick", this.onHeaderClick, this);
    },

    /**
     * @private
     */
    initEvents : function(){

    },

    /**
     * @private
     */
    onHeaderClick : function(g, index){
        if(this.headersDisabled || !this.cm.isSortable(index)){
            return;
        }
        g.stopEditing(true);
        g.dataset.sort(this.cm.getDataIndex(index));
    },

    /**
     * @private
     */
    onRowOver : function(e, t){
        var row;
        if((row = this.findRowIndex(t)) !== false){
            this.addRowClass(row, "l-grid3-row-over");
        }
    },

    /**
     * @private
     */
    onRowOut : function(e, t){
        var row;
        if((row = this.findRowIndex(t)) !== false && !e.within(this.getRow(row), true)){
            this.removeRowClass(row, "l-grid3-row-over");
        }
    },

    /**
     * @private
     */
    handleWheel : function(e){
        e.stopPropagation();
    },

    /**
     * @private
     */
    onRowSelect : function(row){
        this.addRowClass(row, "l-grid3-row-selected");
    },

    /**
     * @private
     */
    onRowDeselect : function(row){
        this.removeRowClass(row, "l-grid3-row-selected");
    },

    /**
     * @private
     */
    onCellSelect : function(row, col){
        var cell = this.getCell(row, col);
        if(cell){
            this.fly(cell).addClass("l-grid3-cell-selected");
        }
    },

    /**
     * @private
     */
    onCellDeselect : function(row, col){
        var cell = this.getCell(row, col);
        if(cell){
            this.fly(cell).removeClass("l-grid3-cell-selected");
        }
    },

    /**
     * @private
     * 当拖动改变列宽的时候触发的方法
     * @param {Number} i 列的索引号
     * @param {Number} w 列宽
     */
    onColumnSplitterMoved : function(i, w){
    	this.offsetHd.width='100%';//调整因为拖动列宽带来的offset宽度不够宽的问题
        this.userResized = true;
        var cm = this.grid.colModel;
        cm.setColumnWidth(i, w, true);

        if(this.forceFit){
            this.fitColumns(true, false, i);
            this.updateAllColumnWidths();
        }else{
            this.updateColumnWidth(i, w);
            this.syncHeaderScroll();
        }

        this.grid.fireEvent("columnresize", i, w);
    },

    /**
     * @private
     * 当点击头部菜单的时候调用该方法
     */
    handleHdMenuClick : function(item){
        var index = this.hdCtxIndex;
        var cm = this.cm, ds = this.ds;
        switch(item.id){
            case "asc":
                ds.sort(cm.getDataIndex(index), "ASC");
                break;
            case "desc":
                ds.sort(cm.getDataIndex(index), "DESC");
                break;
            default:
                index = cm.getIndexById(item.id.substr(4));
                if(index != -1){
                    if(item.checked && cm.getColumnsBy(this.isHideableColumn, this).length <= 1){
                        this.onDenyColumnHide();
                        return false;
                    }
                    cm.setHidden(index, item.checked);
                }
        }
        return true;
    },

    /**
     * @private
     * 判断列是否可隐藏，被handleHdMenuClick调用
     * @param {Object} 某一列的配置对象
     * @return {Boolean} 某列是否可隐藏
     */
    isHideableColumn : function(c){
        return !c.hidden && !c.fixed;
    },

    /**
     * @private
     * 当列显示之前调用此方法
     */
    beforeColMenuShow : function(){
        var cm = this.cm,  colCount = cm.getColumnCount();
        this.colMenu.removeAll();
        for(var i = 0; i < colCount; i++){
            if(cm.config[i].fixed !== true && cm.config[i].hideable !== false){
                this.colMenu.add(new L5.menu.CheckItem({
                    id: "col-"+cm.getColumnId(i),
                    text: cm.getColumnHeader(i),
                    checked: !cm.isHidden(i),
                    hideOnClick:false,
                    disabled: cm.config[i].hideable === false
                }));
            }
        }
    },

    /**
     * @private
     * 表头被点击的时候触发
     * @param {L5.EventObject} 触发的事件
     * @param {L5.Element} t 表头单元格对应的Element对象
     */
    handleHdDown : function(e, t){
        if(L5.fly(t).hasClass('l-grid3-hd-btn')){
            e.stopEvent();
            var hd = this.findHeaderCell(t);
            L5.fly(hd).addClass('l-grid3-hd-menu-open');
            var index = this.getCellIndex(hd);
            this.hdCtxIndex = index;
            var ms = this.hmenu.items, cm = this.cm;
            ms.get("asc").setDisabled(!cm.isSortable(index));
            ms.get("desc").setDisabled(!cm.isSortable(index));
            this.hmenu.on("hide", function(){
                L5.fly(hd).removeClass('l-grid3-hd-menu-open');
            }, this, {single:true});
            this.hmenu.show(t, "tl-bl?");
        }
    },

    /**
     * @private
     * 当鼠标悬浮在表头的时候触发
     * @param {L5.EventObject} 触发的事件
     * @param {L5.Element} t 表头单元格对应的Element对象
     */
    handleHdOver : function(e, t){
        var hd = this.findHeaderCell(t);
        if(hd && !this.headersDisabled){
            this.activeHd = hd;
            this.activeHdIndex = this.getCellIndex(hd);
            var fly = this.fly(hd);
            this.activeHdRegion = fly.getRegion();
            if(!this.cm.isMenuDisabled(this.activeHdIndex)){
                fly.addClass("l-grid3-hd-over");
                this.activeHdBtn = fly.child('.l-grid3-hd-btn');
                if(this.activeHdBtn){
                    this.activeHdBtn.dom.style.height = (hd.firstChild.offsetHeight-1)+'px';
                }
            }
        }
    },

    /**
     * @private
     * 当表头移动的时候触发此方法
     * @param {L5.EventObject} e 触发的事件
     * @param {L5.Element} t 表头单元格对应的Element对象
     */
    handleHdMove : function(e, t){
        if(this.activeHd && !this.headersDisabled){
            var hw = this.splitHandleWidth || 5;
            var r = this.activeHdRegion;
            var x = e.getPageX();
            var ss = this.activeHd.style;
            if(x - r.left <= hw && this.cm.isResizable(this.activeHdIndex-1)){
                ss.cursor = L5.isAir ? 'move' : L5.isSafari ? 'e-resize' : 'col-resize'; // col-resize not always supported
            }else if(r.right - x <= (!this.activeHdBtn ? hw : 2) && this.cm.isResizable(this.activeHdIndex)){
                ss.cursor = L5.isAir ? 'move' : L5.isSafari ? 'w-resize' : 'col-resize';
            }else{
                ss.cursor = '';
            }
        }
    },

    /**
     * @private
     * 当鼠标从某表头移出时候调用该方法
     * @param {L5.EventObject} 触发的事件
     * @param {L5.Element} t 表头单元格对应的Element对象
     */
    handleHdOut : function(e, t){
        var hd = this.findHeaderCell(t);
        if(hd && (!L5.isIE || !e.within(hd, true))){
            this.activeHd = null;
            this.fly(hd).removeClass("l-grid3-hd-over");
            hd.style.cursor = '';
        }
    },

    /**
     * @private
     */
    hasRows : function(){
        var fc = this.mainBody.dom.firstChild;
        return fc && fc.className != 'l-grid-empty';
    },

    // back compat
    /**
     * @private
     */
    bind : function(d, c){
        this.initData(d, c);
    }
});


// private
// This is a support class used internally by the Grid components
/**
 * @private
 * view的拖拽封装
 */
L5.grid.GridView.SplitDragZone = function(grid, hd){
    this.grid = grid;
    this.view = grid.getView();
    this.marker = this.view.resizeMarker;
    this.proxy = this.view.resizeProxy;
    L5.grid.GridView.SplitDragZone.superclass.constructor.call(this, hd,
        "gridSplitters" + this.grid.getGridEl().id, {
        dragElId : L5.id(this.proxy.dom), resizeFrame:false
    });
    this.scroll = false;
    this.hw = this.view.splitHandleWidth || 5;
};
L5.extend(L5.grid.GridView.SplitDragZone, L5.dd.DDProxy, {

    b4StartDrag : function(x, y){
        this.view.headersDisabled = true;
        var h = this.view.mainWrap.getHeight();
        this.marker.setHeight(h);
        this.marker.show();
        this.marker.alignTo(this.view.getHeaderCell(this.cellIndex), 'tl-tl', [-2, 0]);
        this.proxy.setHeight(h);
        var w = this.cm.getColumnWidth(this.cellIndex);
        var minw = Math.max(w-this.grid.minColumnWidth, 0);
        this.resetConstraints();
        this.setXConstraint(minw, 1000);
        this.setYConstraint(0, 0);
        this.minX = x - minw;
        this.maxX = x + 1000;
        this.startPos = x;
        L5.dd.DDProxy.prototype.b4StartDrag.call(this, x, y);
    },


    handleMouseDown : function(e){
        var t = this.view.findHeaderCell(e.getTarget());
        if(t){
            var xy = this.view.fly(t).getXY(), x = xy[0], y = xy[1];
            var exy = e.getXY(), ex = exy[0], ey = exy[1];
            var w = t.offsetWidth, adjust = false;
            if((ex - x) <= this.hw){
                adjust = -1;
            }else if((x+w) - ex <= this.hw){
                adjust = 0;
            }
            if(adjust !== false){
                this.cm = this.grid.colModel;
                var ci = this.view.getCellIndex(t);
                if(adjust == -1){
                  if (ci + adjust < 0) {
                    return;
                  }
                    while(this.cm.isHidden(ci+adjust)){
                        --adjust;
                        if(ci+adjust < 0){
                            return;
                        }
                    }
                }
                this.cellIndex = ci+adjust;
                this.split = t.dom;
                if(this.cm.isResizable(this.cellIndex) && !this.cm.isFixed(this.cellIndex)){
                    L5.grid.GridView.SplitDragZone.superclass.handleMouseDown.apply(this, arguments);
                }
            }else if(this.view.columnDrag){
                this.view.columnDrag.callHandleMouseDown(e);
            }
        }
    },

    endDrag : function(e){
        this.marker.hide();
        var v = this.view;
        var endX = Math.max(this.minX, e.getPageX());
        var diff = endX - this.startPos;
        v.onColumnSplitterMoved(this.cellIndex, this.cm.getColumnWidth(this.cellIndex)+diff);
        setTimeout(function(){
            v.headersDisabled = false;
        }, 50);
    },

    autoOffset : function(){
        this.setDelta(0,0);
    }
});
