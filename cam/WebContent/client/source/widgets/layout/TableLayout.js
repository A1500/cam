/**
 * 表格布局，创建一个table，布局的时候把子组件渲染到table的td里面，可以设置列数，一个子组件可以占用多个单元格
 * <p>例如:
 * <pre><code>
// This code will generate a layout table that is 3 columns by 2 rows
// with some spanning included.  The basic layout will be:
// +--------+-----------------+
// |   A    |   B             |
// |        |--------+--------|
// |        |   C    |   D    |
// +--------+--------+--------+
var table = new L5.Panel({
    title: 'Table Layout',
    layout:'table',
    defaults: {
        // applied to each contained panel
        bodyStyle:'padding:20px'
    },
    layoutConfig: {
        // The total column count must be specified here
        columns: 3
    },
    items: [{
        html: '&lt;p&gt;Cell A content&lt;/p&gt;',
        rowspan: 2
    },{
        html: '&lt;p&gt;Cell B content&lt;/p&gt;',
        colspan: 2
    },{
        html: '&lt;p&gt;Cell C content&lt;/p&gt;',
        cellCls: 'highlight'
    },{
        html: '&lt;p&gt;Cell D content&lt;/p&gt;'
    }]
});
</code></pre>
 * @class L5.layout.TableLayout
 * @extends L5.layout.ContainerLayout
 */
L5.layout.TableLayout = L5.extend(L5.layout.ContainerLayout, {
    /**
     * @cfg {Number} columns
     * 表格的列的数量
     */

    // 不监控容器组件的resize事件
    monitorResize:false,

    /**
     * @override
     */
    setContainer : function(ct){
        L5.layout.TableLayout.superclass.setContainer.call(this, ct);
        //复原
        this.currentRow = 0;
        this.currentColumn = 0;
        this.cells = [];
    },

    /**
	 * 执行实际的布局工作
	 * 
	 * @param {L5.Container}
	 *            ct 对应的容器组件
	 * @param {L5.Element}
	 *            target 指定：渲染到哪个元素里
	 * @public
	 * 
	 * @override
	 */
    onLayout : function(ct, target){
        var cs = ct.items.items, len = cs.length, c, i;

        if(!this.table){
            target.addClass('l-table-layout-ct');
            //创建一个table元素
            this.table = target.createChild(
                {tag:'table', cls:'l-table-layout', cellspacing: 0, cn: {tag: 'tbody'}}, null, true);

            this.renderAll(ct, target);
        }
        var items = ct.items.items;
		for ( var i = 0, len = items.length; i < len; i++) {
			var c = items[i];
			if (c.onWinResize) {
				c.onWinResize();
			}
		}
    },   

	/**
	 * 渲染某个子组件：渲染在表格的"下一个单元格"中
	 * 
	 * @param {L5.Component}
	 *            c 要渲染的子组件
	 * @param {Number}
	 *            position 子组件的位置：顺序号
	 * @param {L5.Element}
	 *            target 指定：渲染到哪个元素里
	 * @override
	 */
    renderItem : function(c, position, target){
        if(c && !c.rendered){
            c.render(this.getNextCell(c));
            if(this.extraCls){
                var t = c.getPositionEl ? c.getPositionEl() : c;
                t.addClass(this.extraCls);
            }
        }
    },
    
    /**
     * 获得下一个空的单元格
     * @param {L5.Container} c
     * @returns 返回td元素
     */
	getNextCell : function(c){
		var cell = this.getNextNonSpan(this.currentColumn, this.currentRow);
		var curCol = this.currentColumn = cell[0], curRow = this.currentRow = cell[1];
		for(var rowIndex = curRow; rowIndex < curRow + (c.rowspan || 1); rowIndex++){
			if(!this.cells[rowIndex]){
				this.cells[rowIndex] = [];
			}
			for(var colIndex = curCol; colIndex < curCol + (c.colspan || 1); colIndex++){
				this.cells[rowIndex][colIndex] = true;
			}
		}
		var td = document.createElement('td');
		if(c.cellId){
			td.id = c.cellId;
		}
		var cls = 'l-table-layout-cell';
		if(c.cellCls){
			cls += ' ' + c.cellCls;
		}
		td.className = cls;
		if(c.colspan){
			td.colSpan = c.colspan;
		}
		if(c.rowspan){
			td.rowSpan = c.rowspan;
		}
		this.getRow(curRow).appendChild(td);
		return td;
	},
	
	 /**
     * 获取table的指定行(tr)
     * @returns 返回tr元素
     */
    getRow : function(index){
        var row = this.table.tBodies[0].childNodes[index];
        if(!row){
            row = document.createElement('tr');
            this.table.tBodies[0].appendChild(row);
        }
        return row;
    },    
    
    // private
	getNextNonSpan: function(colIndex, rowIndex){
		var cols = this.columns;
		while((cols && colIndex >= cols) || (this.cells[rowIndex] && this.cells[rowIndex][colIndex])) {
			if(cols && colIndex >= cols){
				rowIndex++;
				colIndex = 0;
			}else{
				colIndex++;
			}
		}
		return [colIndex, rowIndex];
	},
    // private
    isValidParent : function(c, target){
        return true;
    }

    /**
     * @property activeItem
     * @hide
     */
});

L5.Container.LAYOUTS['table'] = L5.layout.TableLayout;