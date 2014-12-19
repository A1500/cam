L5.ux.Portlet = L5.extend(L5.Panel, {
    anchor: '100%',
    collapsible:true,
    draggable:{
	onBeforeDrag:function(data, e){
			//var p=data.panel;
			//var parent=p.ownerCt;
			//if(parent.items.getCount()==1){
			//	return false;
			//}
				return true;
			
	}},
	getBy:function(value,type){
		var select="*[id="+value+"]"
		if(type){
		   select="*["+type+"="+value+"]"
		}
		var doms=L5.query(select,this.body.dom);
		if(doms){
			return doms[0];
		}
	},
    cls:'l-portlet',
	fireToolEvent:function(value){
		var tc = this.tools[value];
		L5.fireEvent(tc.dom,"click");
	},
    tools:[{
    	id:'gear',
    	hidden:true,
    	handler:function(event,toolEl,panel){
    			panel.confdiv.show();
    		}
    	},{
        id:'maximize',
        handler: function(event, toolEl, panel){
    		var portal=L5.getCmp("portal");
    		portal.hide();
    		var content=L5.getCmp('content');
    		var w=null;
    		var conf=panel.widget.conf;
    		var title=panel.widget.title;
    		//根据widget类型,处理最大化
    		var widgetType=panel.widget.widgetType;
    		//取默认widget
    		if(widgetType=="1")
    		{
    			w=content.items.get(0);
    			content.items.get(1).hide();
    		}
    		//取iframe;
    		else
    		{
    			w=content.items.get(1);
    			content.items.get(0).hide();
    		}
    	    w.setTitle(title);
    	    w.currentWidget=panel;//当前最大化的哪个widget
    		content.show();
    		content.doLayout();
    		content.onWinResize();
    		w.getTool('close').show();
    		w.getTool('maximize').hide();
    		w.show();
    		var refresh=true;
    	    w.isMax = true;
    	    if(panel.url==null&&panel.onMax){
    	    	w.refresh(conf,true);
    	    	refresh=panel.onMax(w);//最大化传递的参数是最大化后的widget
    		}
    	    if(refresh)
    	    	w.refresh(conf);
        }
    },{
        id:'close',
        hidden:true,
        handler: function(event, toolEl, panel){     	
    		var portal=L5.getCmp("portal");
    		portal.show();
    		var content=L5.getCmp('content');
    		panel.hide();
    		content.hide();
    		//panel.body.update("");
    		//在首页隐藏hidcontent空白
    		var content=L5.getCmp('content');
    		w=content.items.get(1);
    		if(!w)
    			document.getElementById("hidcontent").style.display="none";
    		if(panel.currentWidget&&panel.currentWidget.onMin){//如果最大化之前有对应事件，则关闭时触发
    			panel.currentWidget.onMin(panel.currentWidget);//最小化传递的是最小化后的widget
    		}
        }
    },{
        id:'refresh',
        handler: function(event, toolEl, panel){
        	panel.refresh();
    		if(panel.onMax&&panel.isMax){
		    	refresh=panel.onMax(panel);//最大化传递的参数是最大化后的widget
			}
        }
    }]
});
L5.reg('portlet', L5.ux.Portlet);
L5.maxContent=function(url,title,widget){
	var portal=L5.getCmp("portal");
	portal.hide();
	var content=L5.getCmp('content');
	//根据widget类型,处理最大化
	var widgetType=widget.widget.widgetType;
	//取默认widget
	if(widgetType=="1")
	{
		w=content.items.get(0);
		content.items.get(1).hide();
	}
	//取iframe;
	else
	{
		w=content.items.get(1);
		content.items.get(0).hide();
	}
	w.setTitle(title);
	w.currentWidget=widget;//可以没有最大化的那个widget	
	content.show();
	content.doLayout();
	content.onWinResize();
	w.getTool('close').show();
	w.getTool('maximize').hide();
	w.show();
	var refresh=true;
	w.isMax = true;
	if(widget&&widget.onMax){
    	w.refresh(url,false);
    	refresh=widget.onMax(w);//最大化传递的参数是最大化后的widget
	}
    if(refresh)
    	w.refresh(url,true);
}
//显示的明细约束在框架里面
L5.detailContent=function(url,title,moduleId){
	var hidcontent = L5.getCmp("hidcontent");
	hidcontent.hide();
		
	var content = L5.getCmp("content");
	content.hide();	
	var widpanel = L5.getCmp("widpanel");
	if(widpanel)
	{
		widpanel.show();
		widpanel.doLayout();
	}

	var tree = L5.getCmp("tree");
	if(tree)
	{
		tree.innerCt.setVisible(false);
		
		var menuId=0;
		for(var i=0,len=outerChildren.length;i<len;i++){
			var recjson = parent.outerChildren[i];
			if(recjson['id']==moduleId)
			{
				menuId=i;		
				break;
			}			
		}
		
		tree.setRootNode(rootData.getAt(menuId));
		tree.innerCt.slideIn('t', {
	        duration: .30,
	       easing:'easeIn'
	    });
	}

	
	var tabPanel=L5.getCmp('center');
	if(!tabPanel)
	{
		tabPanel=parent.L5.getCmp('center');
	}
	if(!tabPanel)
		return;
	var panel = tabPanel.getItem(0);
	panel.setTitle(title);
	var iframes=panel.body.query('iframe');
	if(url.indexOf("http")>=0||url.indexOf("www")>=0)
	{
		iframes[0].src=url;
	}
	else if(url.substring(0,1)=="/")
	{
		iframes[0].src=L5.webPath+url;
	}
	else
	{
		iframes[0].src=L5.webPath+"/"+url;
	}
}