L5.ux.FloatMuiltLineToolBar = function (config) {
	this.initFloatBar(config);
}
L5.ux.FloatMuiltLineToolBar.prototype = {
		
		floatPanel : {},
		
		muiltLineBar : {},
		
		initFloatBar : function (config) {
			L5.apply(this, config);
			config.bodyStyle = "border:0px;filter:alpha(opacity=85);backgroundColor:#d0def0;"
			this.floatPanel = new L5.ux.FloatPanel(config);
			this.floatPanel.on("show",this.adjustSize,this);
			if(this.floatPanel){
		    	if(L5.isArray(this.mtbar)){
					//为窗体添加按钮对象，增加了列数的设置
		    		this.muiltLineBar = new L5.ux.MuiltLineToolBar(this.mtbar, this.colCount);
		        }
		    	this.muiltLineBar.render(this.floatPanel.body);
		    	this.muiltLineBar.el.dom.childNodes[0].className += " l-toolbar-float";
		    	this.muiltLineBar.el.dom.style.background = "";
		    }
		},
		
		adjustSize : function (){
			var size = L5.get(this.muiltLineBar.tbody).getSize();
			this.floatPanel.setSize(this.width?undefined:size.width+2,this.height?undefined:size.height+2);
		}
}
L5.reg('floatmuiltlinebar', L5.ux.FloatMuiltLineToolBar);