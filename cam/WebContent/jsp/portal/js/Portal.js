
LoushangPortalUtil={};LoushangPortalUtil.addWidgetToCurPage=function(record){if(typeof(curPageLayoutType)!="undefined"){switch(curPageLayoutType){case"0":LoushangPortalUtil.addWidgetToColPortalCurPage(record);break;case"1":LoushangPortalUtil.addWidgetToAbsPortalCurPage(record);break;default:L5.MessageBox.alert("消息提示","不支持的页面布局类型!");}}}
LoushangPortalUtil.addWidgetToColPortalCurPage=function(record){if(!record){return;}
var widgetId=record.get("id");if(LoushangPortalUtil.isWidgetAddedToColPortalCurPage(widgetId)){L5.MessageBox.alert("消息提示","该微件已被添加到当前页面中,请选择其他微件!");return;}
var portal=L5.getCmp("portal");var minWidgetColumn=portal.getColumnByIndex(0);var minWidgetCount=minWidgetColumn.getPortletCount();for(var i=1,len=portal.getColumnCount();i<len;i++){var tmpWidgetColumn=portal.getColumnByIndex(i);var tmpWidgetCount=tmpWidgetColumn.getPortletCount();if(minWidgetCount>tmpWidgetCount){minWidgetCount=tmpWidgetCount;minWidgetColumn=tmpWidgetColumn;}}
minWidgetColumn.addPortlet(record);if(typeof(isSaveWidgetLayout)!="undefined"&&isSaveWidgetLayout==true){saveWidgetLayout();}}
LoushangPortalUtil.addWidgetToAbsPortalCurPage=function(record){if(!record){return;}
var widgetId=record.get("id");if(LoushangPortalUtil.isWidgetAddedToAbsPortalCurPage(widgetId)){L5.MessageBox.alert("消息提示","该微件已被添加到当前页面中,请选择其他微件!");return;}
var absPortal=L5.getCmp("absportal");absPortal.addPortlet(record,100,200,300,400,true);}
LoushangPortalUtil.isWidgetAddedToColPortalCurPage=function(widgetId){var isWidgetAdded=false;var portal=L5.getCmp("portal");for(var i=0,len=portal.getColumnCount();i<len;i++){var tmpColumn=portal.getColumnByIndex(i);if(tmpColumn.getPortletById(widgetId)){isWidgetAdded=true;break;}}
return isWidgetAdded;}
LoushangPortalUtil.isWidgetAddedToAbsPortalCurPage=function(widgetId){var isWidgetAdded=false;var portal=L5.getCmp("absportal");if(portal.getPortletById(widgetId)){isWidgetAdded=true;}
return isWidgetAdded;}
LoushangPortalUtil.initColPortalMaxWidgetContainer=function(){var maxWidgetContainer=L5.getCmp('maxWidgetContainer');var widgetUri="/jsp/portal/help/blank.jsp";var defaultWidget=new LoushangColPortalWidget("widgetId","widgetName","1","","","","");defaultWidget.hide();maxWidgetContainer.add(defaultWidget);var iframeWidget=new LoushangColPortalIframeWidget("widgetId","widgetName","2",widgetUri,"","","");iframeWidget.hide();maxWidgetContainer.add(iframeWidget);maxWidgetContainer.doLayout();maxWidgetContainer.onWinResize();}
LoushangPortalUtil.getFullPathUrl=function(url){var returnUrl=url;if(url.indexOf("http")==-1&&url.indexOf("www")==-1){if(url.substring(0,1)=="/"){returnUrl=L5.webPath+url;}else{returnUrl=L5.webPath+"/"+url;}}
if(url.indexOf("http")==-1&&url.indexOf("www")>=0){returnUrl="http://"+url;}
return returnUrl;}
LoushangPortalUtil.showModalDialog=function(url,arguments,dialogHeight,dialogWidth){var dialogLeft=(screen.width-dialogWidth)/2;var dialogTop=(screen.height-dialogHeight)/2;var sFeatures="dialogHeight:"+dialogHeight+"px;dialogWidth:"+dialogWidth+"px;dialogLeft:"+dialogLeft+"px;dialogTop:"+dialogTop+"px;resizable:no;scroll:yes"
return window.showModalDialog(url,arguments,sFeatures);}

L5.ux.AbsEditablePortlet=L5.extend(L5.Panel,{frame:true,floating:{zindex:8000},shadow:false,cls:'l-portlet',draggable:{insertProxy:false,onDrag:function(e){var pel=this.proxy.getEl();this.x=pel.getLeft(true);this.y=pel.getTop(true);},endDrag:function(e){if(this.x<=0||this.y<=30){return;}
this.panel.setPagePosition(this.x,this.y);}},tools:[{id:'gear',handler:function(event,toolEl,panel){panel.doConfigPortlet(event,toolEl,panel);}},{id:'refresh',handler:function(event,toolEl,panel){panel.doRefreshPortlet(event,toolEl,panel);}},{id:'close',handler:function(event,toolEl,panel){panel.el.dom.parentNode.removeChild(panel.el.dom);panel.ownerCt.remove(panel,true);}}],getBy:function(value,domAttr){var returnDom=null;var select="*[id="+value+"]"
if(domAttr){select="*["+domAttr+"="+value+"]"}
var doms=L5.query(select,this.body.dom);if(doms){returnDom=doms[0];}
return returnDom;},toJsonArray:function(){var portlet=this;var portletEl=portlet.getEl();var array=[];array.push(portlet.widgetId);array.push(portletEl.getLeft(true));array.push(portletEl.getTop(true));array.push(portletEl.getWidth());array.push(portletEl.getHeight());return array;},doConfigPortlet:function(event,toolEl,panel){var url=L5.webPath+"/jsp/portal/help/widgetpropertyhelper.jsp";var obj=new Object();obj.widgetName=panel.widget.name;obj.widgetWidth=panel.width;obj.widgetHeight=panel.height;var returnValue=LoushangPortalUtil.showModalDialog(url,obj,200,500);if(returnValue){panel.width=returnValue[0];panel.height=returnValue[1];panel.setSize(returnValue[0],returnValue[1]);if(panel.layout){panel.doLayout(true);}}},doRefreshPortlet:function(event,toolEl,panel){panel.refresh();if(panel.onMax&&panel.isMax){refresh=panel.onMax(panel);}},listeners:{render:function(){var resizer=new L5.Resizable(this.getEl(),{handles:'n e s w'});var element=this;resizer.on("resize",function(resizer,width,height,event){element.width=width;element.height=height;element.setSize(width,height);if(element.layout){element.doLayout(true);}});}}});

L5.ux.AbsPortlet=L5.extend(L5.Panel,{frame:true,draggable:false,cls:'l-portlet',tools:[{id:'refresh',hidden:true,handler:function(event,toolEl,panel){panel.doRefreshPortlet(event,toolEl,panel);}}],getBy:function(value,domAttr){var returnDom=null;var select="*[id="+value+"]"
if(domAttr){select="*["+domAttr+"="+value+"]"}
var doms=L5.query(select,this.body.dom);if(doms){returnDom=doms[0];}
return returnDom;},doMouseOverHeader:function(event){var mouseOverEvent=event||window.event;if(L5.isIE&&mouseOverEvent.within(this.header,true)){return;}else if(L5.isGecko&&mouseOverEvent.within(this,true)){return;}
this.getTool("refresh").show();},doMouseOutHeader:function(event){var mouseOutEvent=event||window.event;if(L5.isIE&&mouseOutEvent.within(this.header,true)){return;}else if(L5.isGecko&&mouseOutEvent.within(this,true)){return;}
for(var tool in this.tools){this.tools[tool].setVisible(false);}},doRefreshPortlet:function(event,toolEl,panel){panel.refresh();if(panel.onMax&&panel.isMax){refresh=panel.onMax(panel);}},listeners:{render:function(){if(this.header){this.header.setHeight(23);this.header.on('mouseover',this.doMouseOverHeader,this);this.header.on('mouseout',this.doMouseOutHeader,this);}}}});

L5.ux.AbsPortal=L5.extend(L5.Panel,{layout:'absolute',autoScroll:true,cls:'l-portal',initComponent:function(){L5.ux.AbsPortal.superclass.initComponent.call(this);this.addEvents({validatedrop:true,beforedragover:true,dragover:true,beforedrop:true,drop:true});},initEvents:function(){L5.ux.AbsPortal.superclass.initEvents.call(this);},addPortlet:function(portletRecord,portletX,portletY,portletWidth,portletHeight,portletEditable){var portlet=null;var portletId=portletRecord.get("id");var portletName=portletRecord.get("name");var portletType=portletRecord.get("type");var portletUri=portletRecord.get("uri");var portletLogoUri=portletRecord.get("logoUri");var portletBgImageUri=portletRecord.get("bgImageUri");switch(portletType){case"1":portlet=new LoushangAbsPortalWidget(portletId,portletName,portletType,portletUri,portletLogoUri,portletBgImageUri,portletX,portletY,portletWidth,portletHeight,portletEditable);break;case"2":portlet=new LoushangAbsPortalIframeWidget(portletId,portletName,portletType,portletUri,portletLogoUri,portletBgImageUri,portletX,portletY,portletWidth,portletHeight,portletEditable);break;}
if(portlet){this.add(portlet);this.doLayout();}},removeAllPortlet:function(){for(var i=this.getPortletCount()-1;i>=0;i--){var portlet=this.items.itemAt(i);portlet.el.dom.parentNode.removeChild(portlet.el.dom);portlet.ownerCt.remove(portlet,true);}},getPortletById:function(portletId){var portlet=null;for(var i=0,len=this.getPortletCount();i<len;i++){var tmpPortlet=this.items.itemAt(i);if(portletId==tmpPortlet.widgetId){portlet=tmpPortlet;break;}}
return portlet;},getPortletCount:function(){return this.items.length;},toJsonArray:function(){var array=[];for(var i=0,len=this.getPortletCount();i<len;i++){var portlet=this.items.itemAt(i);array.push(portlet.toJsonArray());}
return array;}});L5.reg('absportal',L5.ux.AbsPortal);

L5.ux.ColPortlet=L5.extend(L5.Panel,{frame:true,autoWidth:true,draggable:true,cls:'l-portlet',isNormalState:true,tools:[{id:'refresh',hidden:true,handler:function(event,toolEl,panel){panel.doRefreshPortlet(event,toolEl,panel);}},{id:'maximize',hidden:true,handler:function(event,toolEl,panel){panel.doMaxPortlet(event,toolEl,panel);}},{id:'restore',hidden:true,handler:function(event,toolEl,panel){panel.doRestorePortlet(event,toolEl,panel);}},{id:'close',hidden:true,handler:function(event,toolEl,panel){panel.doClosePortlet(event,toolEl,panel);}}],listeners:{render:function(){if(this.header){this.header.autoHeight();this.header.on('mouseover',this.doMouseOverHeader,this);this.header.on('mouseout',this.doMouseOutHeader,this);}}},getBy:function(value,domAttr){var returnDom=null;var select="*[id="+value+"]"
if(domAttr){select="*["+domAttr+"="+value+"]"}
var doms=L5.query(select,this.body.dom);if(doms){returnDom=doms[0];}
return returnDom;},doRefreshPortlet:function(event,toolEl,panel){panel.refresh();if(panel.onMax&&panel.isMax){refresh=panel.onMax(panel);}},doMaxPortlet:function(event,toolEl,panel){var maxWidgetContainer=L5.getCmp('maxWidgetContainer');var maxWidget=null;switch(panel.widget.widgetType){case"1":maxWidget=maxWidgetContainer.items.get(0);maxWidgetContainer.items.get(1).hide();break;case"2":maxWidget=maxWidgetContainer.items.get(1);maxWidgetContainer.items.get(0).hide();break;}
maxWidget.widgetId=panel.widgetId;maxWidget.setTitle(panel.widget.title);maxWidget.currentWidget=panel;maxWidget.isNormalState=false;maxWidget.isMax=true;if(maxWidget.header){maxWidget.header.autoHeight();maxWidget.header.on('mouseover',panel.doMouseOverHeader,maxWidget);maxWidget.header.on('mouseout',panel.doMouseOutHeader,maxWidget);}
maxWidget.show();var widgetContainer=L5.getCmp("widgetContainer");widgetContainer.hide();maxWidgetContainer.show();maxWidgetContainer.doLayout();maxWidgetContainer.onWinResize();var refresh=true;if(panel.onMax){maxWidget.refresh(panel.widget.conf,true);refresh=panel.onMax(maxWidget);}
if(refresh)
maxWidget.refresh(panel.widget.conf);},doRestorePortlet:function(event,toolEl,panel){var widgetContainer=L5.getCmp("widgetContainer");widgetContainer.show();var maxWidgetContainer=L5.getCmp('maxWidgetContainer');panel.hide();maxWidgetContainer.hide();if(panel.currentWidget&&panel.currentWidget.onMin){panel.currentWidget.onMin(panel.currentWidget);}
this.isNormalState=true;},doClosePortlet:function(event,toolEl,panel){if(typeof(isSaveWidgetLayout)=="undefined"){panel.el.dom.parentNode.removeChild(panel.el.dom);panel.ownerCt.remove(panel,true);}else{L5.MessageBox.confirm("消息提示","您确定要从当前页面中删除该微件吗?",function(sta){if(sta=='yes'){panel.el.dom.parentNode.removeChild(panel.el.dom);panel.ownerCt.remove(panel,true);saveWidgetLayout();}});}},doMouseOverHeader:function(event){var mouseOverEvent=event||window.event;if(L5.isIE&&mouseOverEvent.within(this.header,true)){return;}else if(L5.isGecko&&mouseOverEvent.within(this,true)){return;}
if(this.isNormalState){this.getTool("refresh").show();this.getTool("maximize").show();this.getTool("close").show();}else{this.getTool("refresh").show();this.getTool("restore").show();}},doMouseOutHeader:function(event){var mouseOutEvent=event||window.event;if(L5.isIE&&mouseOutEvent.within(this.header,true)){return;}else if(L5.isGecko&&mouseOutEvent.within(this,true)){return;}
for(var tool in this.tools){this.tools[tool].setVisible(false);}},fireToolEvent:function(value){var tc=this.tools[value];L5.fireEvent(tc.dom,"click");}});L5.reg('portlet',L5.ux.ColPortlet);

L5.ux.ColPortalColumn=L5.extend(L5.Container,{layout:'anchor',autoEl:'div',defaultType:'portlet',cls:'l-portal-column',addPortlet:function(portletRecord){var portlet=null;var portletId=portletRecord.get("id");var portletName=portletRecord.get("name");var portletType=portletRecord.get("type");var portletUri=portletRecord.get("uri");var portletLogoUri=portletRecord.get("logoUri");var portletBgImageUri=portletRecord.get("bgImageUri");var portletHeight=portletRecord.get("height");switch(portletType){case"1":portlet=new LoushangColPortalWidget(portletId,portletName,portletType,portletUri,portletLogoUri,portletBgImageUri,portletHeight);break;case"2":portlet=new LoushangColPortalIframeWidget(portletId,portletName,portletType,portletUri,portletLogoUri,portletBgImageUri,portletHeight);break;}
if(portlet){this.add(portlet);this.doLayout();}},removeAllPortlet:function(){for(var i=this.getPortletCount()-1;i>=0;i--){var portlet=this.items.itemAt(i);portlet.el.dom.parentNode.removeChild(portlet.el.dom);portlet.ownerCt.remove(portlet,true);}},getPortletCount:function(){return this.items.length;},getPortletByIndex:function(portletIndex){var portlet=null;if(portletIndex>=0&&portletIndex<this.getPortletCount()){portlet=this.items.itemAt(portletIndex);}
return portlet;},getPortletById:function(portletId){var portlet=null;for(var i=0,len=this.getPortletCount();i<len;i++){var tmpPortlet=this.items.itemAt(i);if(portletId==tmpPortlet.widgetId){portlet=tmpPortlet;break;}}
return portlet;},toJsonArray:function(){var array=[];for(var i=0,len=this.getPortletCount();i<len;i++){var portlet=this.items.itemAt(i);array.push(portlet.widgetId);}
return array;}});L5.reg('portalcolumn',L5.ux.ColPortalColumn);

L5.ux.ColPortal=L5.extend(L5.Panel,{layout:'column',autoScroll:true,cls:'l-portal',defaultType:'portalcolumn',initComponent:function(){L5.ux.ColPortal.superclass.initComponent.call(this);this.addEvents({validatedrop:true,beforedragover:true,dragover:true,beforedrop:true,drop:true});},initEvents:function(){L5.ux.ColPortal.superclass.initEvents.call(this);this.dd=new L5.ux.ColPortal.DropZone(this,this.dropConfig);},beforeDestroy:function(){if(this.dd){this.dd.unreg();}
L5.ux.ColPortal.superclass.beforeDestroy.call(this);},addColumn:function(columnId,columnWidth){var column=new L5.ux.ColPortalColumn({id:columnId,columnWidth:columnWidth});this.add(column);this.doLayout();},removeAllColumn:function(){for(var i=this.getColumnCount()-1;i>=0;i--){var column=this.items.itemAt(i);column.removeAllPortlet();this.remove(column,true);}},getColumnCount:function(){return this.items.length;},getColumnByIndex:function(columnIndex){var column=null;if(columnIndex>=0&&columnIndex<this.getColumnCount()){column=this.items.itemAt(columnIndex);}
return column;},toJsonArray:function(){var array=[];for(var i=0,len=this.getColumnCount();i<len;i++){var column=this.items.itemAt(i);array.push(column.toJsonArray());}
return array;}});L5.reg('portal',L5.ux.ColPortal);

L5.ux.ColPortal.DropZone=function(portal,cfg){this.portal=portal;L5.dd.ScrollManager.register(portal.body);L5.ux.ColPortal.DropZone.superclass.constructor.call(this,portal.bwrap.dom,cfg);portal.body.ddScrollConfig=this.ddScrollConfig;};L5.extend(L5.ux.ColPortal.DropZone,L5.dd.DropTarget,{ddScrollConfig:{vthresh:50,hthresh:-1,animate:true,increment:200},createEvent:function(dd,e,data,col,c,pos){return{portal:this.portal,panel:data.panel,columnIndex:col,column:c,position:pos,data:data,source:dd,rawEvent:e,status:this.dropAllowed};},notifyOver:function(dd,e,data){var xy=e.getXY(),portal=this.portal,px=dd.proxy;if(!this.grid){this.grid=this.getGrid();}
var cw=portal.body.dom.clientWidth;if(!this.lastCW){this.lastCW=cw;}else if(this.lastCW!=cw){this.lastCW=cw;portal.doLayout();this.grid=this.getGrid();}
var col=0,xs=this.grid.columnX,cmatch=false;for(var len=xs.length;col<len;col++){if(xy[0]<(xs[col].x+xs[col].w)){cmatch=true;break;}}
if(!cmatch){col--;}
var p,match=false,pos=0,c=portal.items.itemAt(col),items=c.items.items,overSelf=false;for(var len=items.length;pos<len;pos++){p=items[pos];var h=p.el.getHeight();if(h===0){overSelf=true;}
else if((p.el.getY()+(h/2))>xy[1]){match=true;break;}}
pos=(match&&p?pos:c.items.getCount())+(overSelf?-1:0);var overEvent=this.createEvent(dd,e,data,col,c,pos);if(portal.fireEvent('validatedrop',overEvent)!==false&&portal.fireEvent('beforedragover',overEvent)!==false){px.getProxy().setWidth('auto');if(p){px.moveProxy(p.el.dom.parentNode,match?p.el.dom:null);}else{px.moveProxy(c.el.dom,null);}
this.lastPos={c:c,col:col,p:overSelf||(match&&p)?pos:false};this.scrollPos=portal.body.getScroll();portal.fireEvent('dragover',overEvent);return overEvent.status;}else{return overEvent.status;}},notifyOut:function(){delete this.grid;},notifyDrop:function(dd,e,data){delete this.grid;if(!this.lastPos){return;}
var c=this.lastPos.c,col=this.lastPos.col,pos=this.lastPos.p;var dropEvent=this.createEvent(dd,e,data,col,c,pos!==false?pos:c.items.getCount());if(this.portal.fireEvent('validatedrop',dropEvent)!==false&&this.portal.fireEvent('beforedrop',dropEvent)!==false){dd.proxy.getProxy().remove();dd.panel.el.dom.parentNode.removeChild(dd.panel.el.dom);if(pos!==false){if(c==dd.panel.ownerCt&&(c.items.items.indexOf(dd.panel)<=pos)){pos++;}
c.insert(pos,dd.panel);}else{c.add(dd.panel);}
c.doLayout();this.portal.fireEvent('drop',dropEvent);var st=this.scrollPos.top;if(st){var d=this.portal.body.dom;setTimeout(function(){d.scrollTop=st;},10);}}
var tools=data.panel.tools;for(var tool in tools)
{tools[tool].setVisible(false);}
data.panel.header.autoHeight();delete this.lastPos;},getGrid:function(){var box=this.portal.bwrap.getBox();box.columnX=[];this.portal.items.each(function(c){box.columnX.push({x:c.el.getX(),w:c.el.getWidth()});});return box;},unreg:function(){L5.ux.ColPortal.DropZone.superclass.unreg.call(this);}});

function LoushangColPortalWidget(){var widgetId=arguments[0];var widgetName=arguments[1];var widgetType=arguments[2];var widgetUri=arguments[3];var widgetLogoUri=arguments[4];var widgetBgImageUri=arguments[5];var widgetHeight=arguments[6];if(L5.type(widgetUri)!="string"){return;}
if(widgetUri)
{widgetUri=LoushangPortalUtil.getFullPathUrl(widgetUri);}
var widgetTitle=widgetName;if(widgetLogoUri)
{widgetLogoUri=LoushangPortalUtil.getFullPathUrl(widgetLogoUri);widgetTitle='<img class="l-panel-inline-icon" src="'+widgetLogoUri+'">'+widgetName;}
var html=script="";this.renderHTML=function(url){if(url)
{L5.Ajax.request({url:url,sync:false,callback:function(options,success,response){html=response.responseText;}});}
return html;}
var widget;if(widgetBgImageUri)
{widgetBgImageUri=LoushangPortalUtil.getFullPathUrl(widgetBgImageUri);widget=new L5.ux.ColPortlet({title:widgetTitle,widgetId:widgetId,bodyStyle:'background-image:url('+widgetBgImageUri+')',html:this.renderHTML(widgetUri)});}
else
{widget=new L5.ux.ColPortlet({title:widgetTitle,widgetId:widgetId,html:this.renderHTML(widgetUri)});}
widget.on("beforebinding",function(html,panel){panel.body.update(this.html,true,panel);});widget.widget={title:widgetTitle,conf:widgetUri,widgetType:widgetType};widget.renderHTML=function(url){L5.Ajax.request({url:url,sync:false,callback:function(options,success,response){html=response.responseText;}});return html;}
widget.refresh=function(url,script){if(url){this.widget.conf=url;L5.fly(this.body.dom).update(this.renderHTML(url),script===false?false:true,this);}else{L5.fly(this.body.dom).update(this.renderHTML(this.widget.conf),script===false?false:true,this);}}
widget.reLoad=function(){if(this.reload)
{return;}
this.reload=true;L5.fly(this.body.dom).update(this.renderHTML(this.widget.conf),true,this);}
return widget;}
function LoushangColPortalIframeWidget(){var widgetId=arguments[0];var widgetName=arguments[1];var widgetType=arguments[2];var widgetUri=arguments[3];var widgetLogoUri=arguments[4];var widgetBgImageUri=arguments[5];var widgetHeight=arguments[6];if(L5.type(widgetUri)!="string"){return;}
var iframeSrc="";if(widgetUri)
{widgetUri=LoushangPortalUtil.getFullPathUrl(widgetUri);iframeSrc=' src="'+widgetUri+'"';}
var iframeHeight="280";if(widgetHeight)
{iframeHeight=widgetHeight;}
var widgetTitle=widgetName;if(widgetLogoUri)
{widgetLogoUri=LoushangPortalUtil.getFullPathUrl(widgetLogoUri);widgetTitle='<img class="l-panel-inline-icon" src="'+widgetLogoUri+'">'+widgetName;}
var widget;if(widgetBgImageUri)
{widgetBgImageUri=LoushangPortalUtil.getFullPathUrl(widgetBgImageUri);widget=new L5.ux.ColPortlet({title:widgetTitle,widgetId:widgetId,bodyStyle:'background-image:url('+widgetBgImageUri+')',html:'<iframe scrolling="auto" id="contentiframe" allowtransparency="true" frameborder="0" style="border: 0pt none ; margin: 0pt; padding: 0pt; overflow: auto; width: 100%;height:'+iframeHeight+'px;" '+iframeSrc+'/>'});}
else
{widget=new L5.ux.ColPortlet({title:widgetTitle,widgetId:widgetId,html:'<iframe scrolling="auto" id="contentiframe" frameborder="0" style="border: 0pt none ; margin: 0pt; padding: 0pt; overflow: auto; width: 100%;height:'+iframeHeight+'px;" '+iframeSrc+'/>'});}
widget.widget={title:widgetTitle,conf:widgetUri,widgetType:widgetType};widget.refresh=function(url){var iframes=this.body.query('iframe');if(iframes[0]){if(!this.loadmask){this.loadmask=new L5.LoadMask(this.body,{msg:"请等待..."});}
this.loadmask.show();var loadmask=this.loadmask;iframes[0].style.height=iframeHeight;iframes[0].style.visibility="hidden";iframes[0].onload=iframes[0].onreadystatechange=function(){if(this.readyState=="complete"||!this.readyState){(function(){loadmask.hide();iframes[0].style.visibility="visible";}).defer(50);}}
if(url){iframes[0].src=url;this.widget.conf=url;}else{iframes[0].src=this.widget.conf;}}}
return widget;}
function LoushangAbsPortalWidget(){var widgetId=arguments[0];var widgetName=arguments[1];var widgetType=arguments[2];var widgetUri=arguments[3];var widgetLogoUri=arguments[4];var widgetBgImageUri=arguments[5];var widgetX=arguments[6];var widgetY=arguments[7];var widgetWidth=arguments[8];var widgetHeight=arguments[9];var widgetEditable=arguments[10];if(L5.type(widgetUri)!="string"){return;}
if(widgetUri)
{widgetUri=LoushangPortalUtil.getFullPathUrl(widgetUri);}
var widgetTitle=widgetName;if(widgetLogoUri)
{widgetLogoUri=LoushangPortalUtil.getFullPathUrl(widgetLogoUri);widgetTitle='<img class="l-panel-inline-icon" src="'+widgetLogoUri+'">'+widgetName;}
var html=script="";this.renderHTML=function(url){if(url)
{L5.Ajax.request({url:url,sync:false,callback:function(options,success,response){html=response.responseText;}});}
return html;}
var widget;if(widgetEditable)
{if(widgetBgImageUri)
{widgetBgImageUri=LoushangPortalUtil.getFullPathUrl(widgetBgImageUri);widget=new L5.ux.AbsEditablePortlet({title:widgetTitle,widgetId:widgetId,bodyStyle:'background-image:url('+widgetBgImageUri+')',x:widgetX,y:widgetY,width:widgetWidth,height:widgetHeight,html:this.renderHTML(widgetUri)});}
else
{widget=new L5.ux.AbsEditablePortlet({title:widgetTitle,widgetId:widgetId,x:widgetX,y:widgetY,width:widgetWidth,height:widgetHeight,html:this.renderHTML(widgetUri)});}}
else
{if(widgetBgImageUri)
{widgetBgImageUri=LoushangPortalUtil.getFullPathUrl(widgetBgImageUri);widget=new L5.ux.AbsPortlet({title:widgetTitle,widgetId:widgetId,bodyStyle:'background-image:url('+widgetBgImageUri+')',x:widgetX,y:widgetY,width:widgetWidth,height:widgetHeight,html:this.renderHTML(widgetUri)});}
else
{widget=new L5.ux.AbsPortlet({title:widgetTitle,widgetId:widgetId,x:widgetX,y:widgetY,width:widgetWidth,height:widgetHeight,html:this.renderHTML(widgetUri)});}}
widget.on("beforebinding",function(html,panel){panel.body.update(this.html,true,panel);});widget.widget={title:widgetTitle,name:widgetName,conf:widgetUri,widgetType:widgetType};widget.renderHTML=function(url){L5.Ajax.request({url:url,sync:false,callback:function(options,success,response){html=response.responseText;}});return html;}
widget.refresh=function(url,script){if(url){this.widget.conf=url;L5.fly(this.body.dom).update(this.renderHTML(url),script===false?false:true,this);}else{L5.fly(this.body.dom).update(this.renderHTML(this.widget.conf),script===false?false:true,this);}}
widget.reLoad=function(){if(this.reload)
{return;}
this.reload=true;L5.fly(this.body.dom).update(this.renderHTML(this.widget.conf),true,this);}
return widget;}
function LoushangAbsPortalIframeWidget(){var widgetId=arguments[0];var widgetName=arguments[1];var widgetType=arguments[2];var widgetUri=arguments[3];var widgetLogoUri=arguments[4];var widgetBgImageUri=arguments[5];var widgetX=arguments[6];var widgetY=arguments[7];var widgetWidth=arguments[8];var widgetHeight=arguments[9];var widgetEditable=arguments[10];if(L5.type(widgetUri)!="string"){return;}
var iframeSrc="";if(widgetUri)
{widgetUri=LoushangPortalUtil.getFullPathUrl(widgetUri);iframeSrc=' src="'+widgetUri+'"';}
var widgetTitle=widgetName;if(widgetLogoUri)
{widgetLogoUri=LoushangPortalUtil.getFullPathUrl(widgetLogoUri);widgetTitle='<img class="l-panel-inline-icon" src="'+widgetLogoUri+'">'+widgetName;}
var widget;if(widgetEditable)
{if(widgetBgImageUri)
{widgetBgImageUri=LoushangPortalUtil.getFullPathUrl(widgetBgImageUri);widget=new L5.ux.AbsEditablePortlet({title:widgetTitle,widgetId:widgetId,bodyStyle:'background-image:url('+widgetBgImageUri+')',x:widgetX,y:widgetY,width:widgetWidth,height:widgetHeight,html:'<iframe scrolling="auto" id="contentiframe" allowtransparency="true" frameborder="0" style="border: 0pt none ; margin: 0pt; padding: 0pt; overflow: auto; width: 100%;height:100%;" '+iframeSrc+'/>'});}
else
{widget=new L5.ux.AbsEditablePortlet({title:widgetTitle,widgetId:widgetId,x:widgetX,y:widgetY,width:widgetWidth,height:widgetHeight,html:'<iframe scrolling="auto" id="contentiframe" frameborder="0" style="border: 0pt none ; margin: 0pt; padding: 0pt; overflow: auto; width: 100%;height:100%;" '+iframeSrc+'/>'});}}
else
{if(widgetBgImageUri)
{widgetBgImageUri=LoushangPortalUtil.getFullPathUrl(widgetBgImageUri);widget=new L5.ux.AbsPortlet({title:widgetTitle,widgetId:widgetId,bodyStyle:'background-image:url('+widgetBgImageUri+')',x:widgetX,y:widgetY,width:widgetWidth,height:widgetHeight,html:'<iframe scrolling="auto" id="contentiframe" allowtransparency="true" frameborder="0" style="border: 0pt none ; margin: 0pt; padding: 0pt; overflow: auto; width: 100%;height:100%;" '+iframeSrc+'/>'});}
else
{widget=new L5.ux.AbsPortlet({title:widgetTitle,widgetId:widgetId,x:widgetX,y:widgetY,width:widgetWidth,height:widgetHeight,html:'<iframe scrolling="auto" id="contentiframe" frameborder="0" style="border: 0pt none ; margin: 0pt; padding: 0pt; overflow: auto; width: 100%;height:100%;" '+iframeSrc+'/>'});}}
widget.widget={title:widgetTitle,name:widgetName,conf:widgetUri,widgetType:widgetType};widget.refresh=function(url){var iframes=this.body.query('iframe');if(iframes[0]){if(!this.loadmask){this.loadmask=new L5.LoadMask(this.body,{msg:"请等待..."});}
this.loadmask.show();var loadmask=this.loadmask;iframes[0].style.height=widgetHeight;iframes[0].style.visibility="hidden";iframes[0].onload=iframes[0].onreadystatechange=function(){if(this.readyState=="complete"||!this.readyState){(function(){loadmask.hide();iframes[0].style.visibility="visible";}).defer(50);}}
if(url){iframes[0].src=url;this.widget.conf=url;}else{iframes[0].src=this.widget.conf;}}}
return widget;}
(function(){var Wevent=function(){this.addEvents({});};L5.extend(Wevent,L5.util.Observable,{});L5.WidgetEventBus=new Wevent();})();

LoushangPortal={};LoushangPortal.maxContent=function(url,title,widget){var maxWidgetContainer=L5.getCmp('maxWidgetContainer');var maxWidget=null;switch(widget.widget.widgetType){case"1":maxWidget=maxWidgetContainer.items.get(0);maxWidgetContainer.items.get(1).hide();break;case"2":maxWidget=maxWidgetContainer.items.get(1);maxWidgetContainer.items.get(0).hide();break;}
maxWidget.widgetId=widget.widgetId;maxWidget.setTitle(title);maxWidget.currentWidget=widget;maxWidget.isNormalState=false;maxWidget.isMax=true;maxWidget.show();var widgetContainer=L5.getCmp("widgetContainer");widgetContainer.hide();maxWidgetContainer.show();maxWidgetContainer.doLayout();maxWidgetContainer.onWinResize();var refresh=true;if(widget&&widget.onMax){maxWidget.refresh(url,false);refresh=widget.onMax(maxWidget);}
if(refresh){maxWidget.refresh(url,true);}}
L5.maxContent=LoushangPortal.maxContent;LoushangPortal.detailContent=function(url,title,menuPath){if(!url)
{L5.MessageBox.alert("消息提示","要跳转到的业务页面地址不能为空!");return;}
var widgetContainer=L5.getCmp("widgetContainer");widgetContainer.hide();var maxWidgetContainer=L5.getCmp("maxWidgetContainer");maxWidgetContainer.hide();var widgetSelector=L5.getCmp("widgetSelector");if(widgetSelector){widgetSelector.hide();}
var widpanel=L5.getCmp("widpanel");if(widpanel){widpanel.show();widpanel.doLayout();}
var tree=L5.getCmp("tree");if(tree){tree.innerCt.setVisible(false);var rootMenuIndex=0;var menuPathArray=[];if(menuPath)
{menuPathArray=menuPath.split("#");for(var i=0,len=outerChildren.length;i<len;i++){var recjson=parent.outerChildren[i];if(recjson['id']==menuPathArray[0]){rootMenuIndex=i;break;}}}
var rootNode=rootData.getAt(rootMenuIndex);if(rootNode){tree.setRootNode(rootNode);if(menuPathArray.length>1)
{var menuPathPrefix="/tree_menuRecord_";var expandMenuPath="";for(var i=0;i<menuPathArray.length;i++)
{expandMenuPath+=menuPathPrefix+menuPathArray[i];}
tree.selectPath(expandMenuPath);}
tree.innerCt.slideIn('t',{duration:.30,easing:'easeIn'});}}
var tabPanel=L5.getCmp('center');if(!tabPanel){tabPanel=parent.L5.getCmp('center');}
if(!tabPanel){return;}
var panel=tabPanel.getItem(0);panel.setTitle(title);var iframes=panel.body.query('iframe');if(url.indexOf("http")>=0||url.indexOf("www")>=0){iframes[0].src=url;}else if(url.substring(0,1)=="/"){iframes[0].src=L5.webPath+url;}else{iframes[0].src=L5.webPath+"/"+url;}}
L5.detailContent=LoushangPortal.detailContent;
