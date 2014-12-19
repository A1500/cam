/**                              
 *  该函数参数是widget的属性
 *  第一个是widget Id           
 *  第二个是widget 名称,name
 *  第三个是widget 类型,type
 *  第四个是widget 访问地址,uri
 *  第五个是widget Logo地址,logoUri
 *  第六个是widget 高度,height
 */        
function L5_Widget(){
	var widgetId=arguments[0];
	var widgetName=arguments[1];
	var widgetType=arguments[2];
	var widgetUri=arguments[3];
	var widgetLogoUri=arguments[4];
	var widgetHeight=arguments[5];
	
	if(L5.type(widgetUri)!="string"){
	    return;	
	}
	//处理widget访问地址
	if(widgetUri!=null&&widgetUri!="")
	{
		if(widgetUri.indexOf("http")==-1&&widgetUri.indexOf("www")==-1)
		{
			if(widgetUri.substring(0,1)=="/")
			{
				widgetUri=L5.webPath+widgetUri;
			}
			else
			{
				widgetUri=L5.webPath+"/"+widgetUri;
			}
		}
		//如果以www开头,加上http://
		if(widgetUri.indexOf("http")==-1&&widgetUri.indexOf("www")>=0)
		{
			widgetUri="http://"+widgetUri;
		}
	}
		
	//如果widget有logo,则将logo和名称合并
	var widgetTitle=widgetName;
	if(widgetLogoUri!=null&&widgetLogoUri!="")
	{
		if(widgetLogoUri.indexOf("http")==-1&&widgetLogoUri.indexOf("www")==-1)
		{
			if(widgetLogoUri.substring(0,1)=="/")
			{
				widgetLogoUri=L5.webPath+widgetLogoUri;
			}
			else
			{
				widgetLogoUri=L5.webPath+"/"+widgetLogoUri;
			}
		}
		//如果以www开头,加上http://
		if(widgetLogoUri.indexOf("http")==-1&&widgetLogoUri.indexOf("www")>=0)
		{
			widgetLogoUri="http://"+widgetLogoUri;
		}
		
		widgetTitle='<img class="l-panel-inline-icon" src="'+widgetLogoUri+'">'+widgetName;
	}

	var html=script="";
	this.renderHTML=function(url){
		if(url!=null&&url!="")
		{
			L5.Ajax.request({
				url: url,
				sync:false,
				callback:function(options,success,response){
					html=response.responseText;
				}
		   });
		}

		return html;
	}
	var widget=new L5.ux.Portlet({
				title:widgetTitle,
				widgetId:widgetId,
				html:this.renderHTML(widgetUri)
			});
	widget.on("beforebinding",function(html,panel){
			panel.body.update(this.html,true,panel);
			if(panel.param){//如果有参数配置
				panel.getTool('gear').show();//展示配置按钮
				var script=panel.body.query("div[portal_type='script']")[0].innerHTML;//获取js函数
				panel.confdiv=new L5.Element(panel.body.query("div[portal_type='param']")[0]);//获取
				panel.confdiv.createChild([{
					tag: 'button',
					type:'button',
					portal_sure:true,
					html: '确定'
				},{
					tag: 'button',
					type:'button',
					portal_cancle:true,
					html: '取消'
				}]);
				var portal_sure=new L5.Element(panel.confdiv.query('button[portal_sure=true]')[0]);
				portal_sure.on('click',function(){
					var els=panel.body.query("input[portal_param]");
					for(var i=0;i<els.length;i++){
						var ele=new L5.Element(els[i]);
						panel.param[ele.getAttributeNS(null,'portal_param')]=ele.getValue();
					}
					//此处序列化json，传到后台。
					var json=L5.encode(panel.param);
	    			panel.fireEvent('paramchange',panel);
					panel.confdiv.hide();
				});
				var portal_cancle=new L5.Element(panel.confdiv.query('button[portal_cancle=true]')[0]);
				portal_cancle.on('click',function(){
					panel.confdiv.hide();
				});
				panel.confdiv.setVisibilityMode(2).hide();
				panel.paramHandler=new Function(script);
				//删除掉脚本div
				L5.removeNode(panel.body.query("div[type='script']")[0]);
				panel.paramHandler();
				panel.on('paramchange',panel.paramHandler);
			}
		});
	widget.widget={
				title:widgetTitle,
				conf:widgetUri,
				//widget类型
				widgetType:widgetType
		};
	widget.renderHTML=function(url){
			L5.Ajax.request({
					url: url,
					sync:false,
					callback:function(options,success,response){
						html=response.responseText;
					}
			});
			return html;
		}
	widget.refresh=function(url,script){
			if(url){
				this.widget.conf=url;
				L5.fly(this.body.dom).update(this.renderHTML(url),script===false?false:true,this);
			}else{
				L5.fly(this.body.dom).update(this.renderHTML(this.widget.conf),script===false?false:true,this);
			}
		}
	widget.reLoad=function(){
			    if(this.reload)
			    	return;
			    this.reload=true;
				L5.fly(this.body.dom).update(this.renderHTML(this.widget.conf),true,this);
		}
	
	return widget;
}
L5.Widget={
	get:function(widgetId){
		var widget=L5.ComponentMgr.all.find(function(w){
			if(w.widgetId==widgetId)
				return true;
		});
		return widget;
    }
};

//下面是widget之间传递事件的事件bus。
//使用方法就是L5.WidgetEventBus.fireEvent("频道",参数)
//L5.WidgetEventBus.on();
(function(){
	var Wevent =function(){
		//具体事件动态指定。
		this.addEvents({});
	};
	L5.extend(Wevent, L5.util.Observable,{});
	L5.WidgetEventBus = new Wevent();
})();