L5.ux.MuiltLineToolBar = function(config, colCount) {
	this.colCount = colCount;
	L5.ux.MuiltLineToolBar.superclass.constructor.call(this, config);
};

(function() {

	var T = L5.ux.MuiltLineToolBar;

	L5.extend(T, L5.Toolbar, {
		
		// private
		onRender : function(ct, position) {
			T.superclass.onRender.call(this,ct, position);
			//增加tbody
			this.tbody = this.el.child("tbody", true);
			this.createItemIndex = 0;
		},

		/**
		 * private
		 * 增加td元素
		 */
		nextBlock : function() {
			var index = this.createItemIndex++;
			if(index%this.colCount == 0){
				this.tr = document.createElement("tr");
				this.tbody.appendChild(this.tr);
			}
			var td = document.createElement("td");
			this.tr.appendChild(td);
			return td;
		},

		// private
	    onDestroy : function(){
	        T.superclass.onDestroy.call(this);
	        if(this.rendered){
	            L5.Element.uncache(this.tbody);
	        }
	    },
	    
		insertButton : function(index, item){
			L5.Msg.showMsg("系统提示","该类不支持此方法!");
	    }
		
	});
	L5.reg('muiltlinetoolbar', L5.ux.MuiltLineToolBar);
})();
