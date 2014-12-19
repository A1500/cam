L5.grid.GridSummary = function(config){
	this.sumText='合计:';
    L5.apply(this, config);
};

L5.extend(L5.grid.GridSummary, L5.util.Observable, {
    init : function(grid){
        this.grid = grid;
        this.cm = grid.getColumnModel();
        this.view = grid.getView();

        var v = this.view;
        v.renderSum = this.renderSum.createDelegate(this);;
		v.onLayout=function(vw, vh){
    		if(this.renderSum){
    			var sumHeight = this.mainSum.getHeight();
            	this.scroller.setSize(vw, vh-sumHeight);
            	this.mainSum.dom.style.width=vw;
    		}
    	};
    	v.afterMove=function(oldIndex,colIndex){
            if(this.renderSum){
    			var sumTR = this.view.sumBody;
            	sumTR.dom.cells[oldIndex].swapNode(sumTR.dom.cells[colIndex]);
    		}
    	};
        v.afterMethod('onColumnWidthUpdated', this.doWidth, this);
        v.afterMethod('onAllColumnWidthsUpdated', this.doAllWidths, this);
        v.afterMethod('onColumnHiddenUpdated', this.doHidden, this);
        v.afterMethod('onUpdate', this.doUpdate, this);
        v.afterMethod('onRemove', this.doRemove, this);
		v.afterMethod('onAdd', this.doAdd, this);
		v.afterMethod('syncHeaderScroll', this.syncSumScroll,v);
		v.afterMethod('onDataChange', this.refreshSummary,this);
		
        if(!this.rowTpl){
            this.rowTpl = new L5.Template(
                '<div class="l-grid3-summary-row" style="{tstyle}">',
                '<div class="l-grid3-header-offset">',
                '<table class="l-grid3-summary-table" border="0" cellspacing="0" cellpadding="0" style="{tstyle}">',
                    '<tbody><tr>{cells}</tr></tbody>',
                '</table></div></div>'
            );
            this.rowTpl.disableFormats = true;
        }
        this.rowTpl.compile();

        if(!this.cellTpl){
            this.cellTpl = new L5.Template(
                '<td class="l-grid3-col l-grid3-cell l-grid3-td-{id} {css}" style="{style}">',
                '<div class="l-grid3-cell-inner l-grid3-col-{id}" unselectable="on">{value}</div>',
                "</td>"
            );
            this.cellTpl.disableFormats = true;
        }
        this.cellTpl.compile();
    },

    hideSum : function(visible){
        var el = this.grid.mainSum;
        if(el){
            if(visible === undefined){
                visible = el.hasClass('l-grid-hide-summary');
            }
            el[visible ? 'removeClass' : 'addClass']('l-grid-hide-summary');
        }
    },

    renderSummary : function(o, cs){
        cs = cs || this.view.getColumnData();
        var cfg = this.cm.config;

        var buf = [], c, p = {}, cf, last = cs.length-1;
        for(var i = 0, len = cs.length; i < len; i++){
            c = cs[i];
            cf = cfg[i];
            p.id = c.id;
            p.style = c.style;
            p.css = i == 0 ? 'l-grid3-cell-first ' : (i == last ? 'l-grid3-cell-last ' : '');
            if(cf.summaryType || cf.summaryRenderer){
            	if(cf.summaryRenderer)
                	p.value = (cf.summaryRenderer)(o.data[c.name], p, o);
                else
                	p.value = o.data[c.name];
            }else{
                p.value = i == 0 ?this.sumText:'';
            }
            if(p.value == undefined || p.value === "") p.value = "&#160;";
            buf[buf.length] = this.cellTpl.apply(p);
        }
        return buf.join('');
    },

    calculate : function(rs, cs){
        var data = {}, r, c, cfg = this.cm.config, cf;
        for(var j = 0, jlen = rs.length; j < jlen; j++){
            r = rs[j];
            for(var i = 0, len = cs.length; i < len; i++){
                c = cs[i];
                cf = cfg[i];
                if(cf.summaryType){
                    data[c.name] = L5.grid.GridSummary.Calculations[cf.summaryType](data[c.name] || 0, r, c.name, data);
                }
            }
        }
        return data;
    },
	renderSum: function(){
		/*return this.rowTpl.apply({
            tstyle: 'width:'+this.view.getTotalWidth()+';',
            cells:this.renderSummary({data:{}})
        });*/
		var cs=this.view.getColumnData();
		var rs=this.grid.dataset.data.items;
		return this.rowTpl.apply({
            tstyle: 'width:'+this.view.getTotalWidth()+';',
            cells:this.doRenderSum(rs,cs)
        });
	},
    doRenderSum : function(rs, cs){
        var data = this.calculate(rs, cs);
        return this.renderSummary({data: data}, cs);
    },

    doWidth : function(col, w, tw){
    		//this.view.mainSum.dom.style.width=tw;//div's width
    		this.view.mainSum.dom.firstChild.firstChild.style.width=tw;//div's width
        	var sumTR = this.view.sumBody;//TR
        	if(sumTR.dom.cells[col])
        		sumTR.dom.cells[col].style.width = w;//TD's width
    },

    doAllWidths : function(ws, tw){
    	//this.view.mainSum.dom.style.width=tw;//div's width
    	this.view.mainSum.dom.firstChild.firstChild.style.width=tw;//table's width
    	var sumTR = this.view.sumBody;//TR
        var wlen = ws.length;
        for(var j = 0; j < wlen; j++){
        	if(sumTR.dom.cells[j])
        		sumTR.dom.cells[j].style.width = ws[j];//set everytd's width
        }
    },

    doHidden : function(col, hidden, tw){
    	//this.view.mainSum.dom.style.width=tw;//div's width
    	this.view.mainSum.dom.firstChild.style.width=tw;//table's width
        var sumTR = this.view.sumBody, s, display = hidden ? 'none' : '';
        sumTR.dom.cells[col].style.display = display;
    },

    refreshSummary: function(){
       /* var rs = [];
        this.grid.dataset.each(function(r){
             rs[rs.length] = r;
        });
        var cs = this.view.getColumnData();
        var data = this.calculate(rs, cs);
        var markup = this.renderSummary({data: data}, cs);
        this.view.sumBody.update(markup);
        */
    	var html=this.renderSum();
    	var index=html.indexOf('>');
    	var first=html.substr(index+1);
    	var finalHtml=first.substr(0,first.length-6);
    	//alert(this.view.mainSum.dom.innerHTML);
    	this.view.mainSum.dom.innerHTML=finalHtml;
    	this.view.sumBody=new L5.Element(this.view.mainSum.dom.firstChild.firstChild.rows[0]);//TODO 
        return true;
    },

    doUpdate : function(ds, record){
        this.refreshSummary();
    },

    doRemove : function(ds, record, index, isUpdate){
        if(!isUpdate){
            this.refreshSummary();
        }
    },
    doAdd:function(ds, records, index){
        this.refreshSummary();
    },
    syncSumScroll:function(){
    	var mb = this.scroller.dom;
        this.mainSum.dom.scrollLeft = mb.scrollLeft;
        this.mainSum.dom.scrollLeft = mb.scrollLeft; // second time for IE (1/2 time first fails, other browsers ignore)
    }
});

L5.grid.GridSummary.Calculations = {
    'sum' : function(v, record, field){
        return v + (record.data[field]||0);
    },

    'count' : function(v, record, field, data){
        return data[field+'count'] ? ++data[field+'count'] : (data[field+'count'] = 1);
    },

    'max' : function(v, record, field, data){
        var v = record.data[field];
        var max = data[field+'max'] === undefined ? (data[field+'max'] = v) : data[field+'max'];
        return v > max ? (data[field+'max'] = v) : max;
    },

    'min' : function(v, record, field, data){
        var v = record.data[field];
        var min = data[field+'min'] === undefined ? (data[field+'min'] = v) : data[field+'min'];
        return v < min ? (data[field+'min'] = v) : min;
    },

    'average' : function(v, record, field, data){
        var c = data[field+'count'] ? ++data[field+'count'] : (data[field+'count'] = 1);
        var t = (data[field+'total'] = ((data[field+'total']||0) + (record.data[field]||0)));
        return t === 0 ? 0 : t / c;
    }
}