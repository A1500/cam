L5.ns('L5.ux.grid');

if(L5.isWebKit){
    L5.grid.GridView.prototype.borderWidth = 0;
}

L5.ux.grid.ColumnHeaderGroup = L5.extend(L5.util.Observable, {

    constructor: function(config){
        this.config = config;
    },

    init: function(grid){
        L5.applyIf(grid.colModel, this.config);
        L5.apply(grid.getView(), this.viewConfig);
    },

    viewConfig: {
        initTemplates: function(){
            this.constructor.prototype.initTemplates.apply(this, arguments);
            var ts = this.templates || {};
            if(!ts.gcell){
                ts.gcell = new L5.XTemplate('<td colspan="{colspan}" class="l-grid3-hd l-grid3-gcell l-grid3-td-{id} ux-grid-hd-group-row-{row} {cls}" style="{style}">', '<div {tooltip} class="l-grid3-hd-inner l-grid3-hd-{id}" unselectable="on" style="{istyle}">{value}</div></td>');
            }
            if(!ts.headers){//增加多表头模板
                ts.headers = new L5.Template(
                        '<table border="0" cellspacing="0" cellpadding="0" style="{tstyle}">',
                        '<thead>{rows}</thead>',
                        "</table>"
                        );
            }
            ts.hcell = new L5.Template(//增加了rowspan
                        '<td rowspan="{rowspan}" class="l-grid3-hd l-grid3-cell l-grid3-td-{id} {css}" style="{style}"><div {tooltip} {attr} class="l-grid3-hd-inner l-grid3-hd-{id}" unselectable="on" style="{istyle}">', this.grid.enableHdMenu ? '<a class="l-grid3-hd-btn" href="#"></a>' : '',
                        '{value}<img class="l-grid3-sort-icon" src="', L5.BLANK_IMAGE_URL, '" />',
                        "</div></td>"
                   );
            this.templates = ts;
            this.hrowRe = new RegExp("ux-grid-hd-group-row-(\\d+)", "");
        },
        /**
         * 重写了renderHeaders方法
         * dom结构发生了很大变化
         */
        renderHeaders : function(){
            var cm = this.cm,rows=cm.rows,ts = this.templates;
            var ct = ts.hcell;

            var len = cm.getColumnCount();
            var rowstring=[],used=[];//已经使用过的hcell
            var length=rows.length;//一共多少行表头
            var last = len - 1;
            for(var j=0;j<length;j++){//遍历每个表头，从最上层开始
            	var row=rows[j];//获取到每一层表头。
            	var cb = [];
            	for(var k=0;k<row.length;k++){
            		var p = {};
            		var cell=row[k];//获取到每个cell
            		var i;
            		if(k==0){//如果是第一个cell，则从0开始
            			i=0;
            		}else{
            			i=row[k-1].start+row[k-1].colspan;//否则从上一次表头结尾开始
            		}
            		for(; i < cell.start; i++){//依次循环生成td
            			if(used.indexOf(i)==-1){//如果已经被使用了，则不再使用。
	            			p.id = cm.getColumnId(i);
	            			p.rowspan=length-j+1;
	                        p.value = cm.getColumnHeader(i) || "";
	                        p.style = this.getColumnStyle(i, true);
	                        p.tooltip = this.getColumnTooltip(i);
	                        p.css = i == 0 ? 'l-grid3-cell-first ' : (i == last ? 'l-grid3-cell-last ' : '');
	                        if(cm.config[i].align == 'right'){
	                            p.istyle = 'padding-right:16px';
	                        } else {
	                            delete p.istyle;
	                        }
	                        used[used.length]=i;
	                        cb[cb.length] = ct.apply(p);
            			}//这是对于td，需要rowspan的情况
            		}
                     cell.colspan = cell.colspan || 1;
                     cb[cb.length]= ts.gcell.apply({//这是对于td，colspan的情况
                         cls: 'ux-grid-hd-group-cell',
                         id: k,
                         row: k,
                         colspan:cell.colspan,
                         style:(cell.align ? 'text-align:' + cell.align + ';' : 'text-align:center;'),
                         tooltip: cell.tooltip ? (L5.QuickTips.isEnabled() ? 'L5:qtip' : 'title') + '="' + cell.tooltip + '"' : '',
                         istyle: cell.align == 'right' ? 'padding-right:16px' : '',
                         value: cell.header || '&nbsp;'
                     });
            	}
            	//一行处理完毕，将生成的html放进rowstring里
            	rowstring[rowstring.length]='<tr class="l-grid3-hd-row">'+cb.join("")+'</tr>';
            }
            var cb = [];
            for(var i = 0; i < len; i++){//处理剩余的最下面的一行tr
            	cm.setFixed(i);
            	if(used.indexOf(i)==-1){
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
            }
            rowstring[rowstring.length]='<tr class="l-grid3-hd-row">'+cb.join("")+'</tr>';
            return ts.headers.apply({rows: rowstring.join(""), tstyle:'table-layout:auto;width:'+this.getTotalWidth()+';'});//重写table-layout:auto防止无法设定td宽度;
        },

        getHeaderCell: function(index){
            return this.mainHd.query(this.cellSelector)[index];
        },

        findHeaderCell: function(el){
            return el ? this.fly(el).findParent('td.l-grid3-hd', this.cellSelectorDepth) : false;
        },

        findHeaderIndex: function(el){
            var cell = this.findHeaderCell(el);
            return cell ? this.getCellIndex(cell) : false;
        },

        updateSortIcon: function(col, dir){
            var sc = this.sortClasses, hds = this.mainHd.select(this.cellSelector).removeClass(sc);
            hds.item(col).addClass(sc[dir == "DESC" ? 1 : 0]);
        },

        handleHdOver: function(e, t){
        	//什么都不做，直接返回，避免onover样式变形。
        	return;
        },

        onHeaderClick : function(g, index){//重写onheaderclick，防止多表头点击抛js错误
            if(this.headersDisabled ||index==-1|| !this.cm.isSortable(index)){
                return;
            }
            g.stopEditing(true);
            g.dataset.sort(this.cm.getDataIndex(index));
        },
        renderUI: function(){
            this.constructor.prototype.renderUI.apply(this, arguments);
           // L5.apply(this.columnDrop, L5.ux.grid.ColumnHeaderGroup.prototype.columnDropConfig);
            L5.apply(this.splitZone, L5.ux.grid.ColumnHeaderGroup.prototype.splitZoneConfig);
        }
    },

    splitZoneConfig: {
        allowHeaderDrag: function(e){
            return !e.getTarget(null, null, true).hasClass('ux-grid-hd-group-cell');
        }
    }
});