/**                              
 *  该函数参数是widget的属性
 *  第一个是widget Id           
 *  第二个是widget 名称,name
 *  第三个是widget 类型,type
 *  第四个是widget 访问地址,uri
 *  第五个是widget Logo地址,logoUri
 *  第六个是widget 高度,height
 */        
function L5_IFrame_Widget(){
	var widgetId=arguments[0];
	var widgetName=arguments[1];
	var widgetType=arguments[2];
	var widgetUri=arguments[3];
	var widgetLogoUri=arguments[4];
	var widgetHeight=arguments[5];
	
	if(L5.type(widgetUri)!="string"){
	    return;	
	}
	//iframe的src地址
	var iframeSrc="";
	
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
		
		iframeSrc=' src="'+widgetUri+'"';
	}
	//iframe的高度
	var iframeHeight="280";
	if(widgetHeight!=null&&widgetHeight!="")
	{
		iframeHeight=widgetHeight;
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
	
	var widget=new L5.ux.Portlet({
				title:widgetTitle,
				widgetId:widgetId,
				html:'<iframe scrolling="auto" id="contentiframe" frameborder="0" style="border: 0pt none ; margin: 0pt; padding: 0pt; overflow: auto; width: 100%;height:'+iframeHeight+'px;" '+iframeSrc+'/>'
			});
	widget.widget={
				title:widgetTitle,
				conf:widgetUri,
				//widget类型
				widgetType:widgetType
		};
	widget.refresh=function(url){
			var iframes=this.body.query('iframe');
			if(iframes[0]){
				if(!this.loadmask){
					this.loadmask = new L5.LoadMask(this.body, {msg:"请等待..."});
				}
				this.loadmask.show();
				var loadmask=this.loadmask;
				var widgetId=this.widgetId;
				iframes[0].style.height=318;
				iframes[0].style.visibility="hidden";
				iframes[0].onload=iframes[0].onreadystatechange=function(){
				if(this.readyState=="complete"||!this.readyState){
					(function(){
						loadmask.hide();
						iframes[0].style.visibility="visible";
						if(widgetId=="contentiframe"){
							var clientHeight=L5.getBody().getHeight();//body的高度
					        var offsetTop=L5.fly(iframes[0]).getOffsetsTo(L5.getBody())[1];//当前元素顶部距离body顶部的高度
					        var height=clientHeight-offsetTop;//body中的剩余高度
							try{
								L5.fly(iframes[0]).setHeight(Math.max(iframes[0].contentWindow.document.body.scrollHeight+5,height-11));
							}catch(e){
								L5.fly(iframes[0]).setHeight(height-11);		
							}
						}
					}).defer(50);
					}
				}
				if(url){
					iframes[0].src=url;
					this.widget.conf=url;
				}else{
					iframes[0].src=this.widget.conf;
				}
			}
		}
	
		return widget;
}