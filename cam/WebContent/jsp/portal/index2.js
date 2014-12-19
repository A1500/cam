//当前门户页面布局Id
var portalUserLayoutId=null;
//当前门户页面布局类型(0:简单布局,1:任意布局)
var curPageLayoutType="0";
//前一次门户页面布局类型
var prePageLayoutType="0";
//当前门户菜单数组
var portalMenuArray=[];
//公共区域的widget是否加载完毕
var isWidgetLoadedOk=false;
//是否保存微件布局
var isSaveWidgetLayout=true;
//最大化的widget容器是否已初始化
var isMaxWidgetContainerInited=false;
//初始化函数
function init(){

  //初始化L5菜单
  L5.Ajax.request(config);
  
  //初始化门户菜单
  initPortalMenu();
  
  //初始化系统自定义事件
  initAppCustomEvent();
  //微件选择器初始为折叠
  var widgetSelector = L5.getCmp("widgetSelector");
  if(widgetSelector)
  {
	  widgetSelector.collapse(false);  
  }
	
  //如果当前用户有权限查看某门户菜单，则加载该菜单下的Widget
  if(portalUserLayoutId)
  {
    //设置当前门户菜单字体颜色
    document.getElementById(portalUserLayoutId).style.color=getPortalMenuSelectedFontColor();
	//初始化widget布局
	portalWidgetDataset.setParameter("portalUserLayoutId",portalUserLayoutId);
    portalWidgetDataset.on("load",initWidgetLayout);
    portalWidgetDataset.load();
    //设置点击门户菜单时,中间面板的显示页面
    portalMenuClickForward();
  }
  //当前用户无门户菜单	
  else{
	//将微件选择器隐藏
	 if(widgetSelector)
	 {
		 widgetSelector.hide(); 
	 }
  }
}

//初始化门户菜单
function initPortalMenu()
{
  //门户菜单Json串
  var portalMenuJson = portalMenuDataset.getCustomData("portalPageJson");
  try{
	  portalMenuArray =eval(portalMenuJson);
  }catch(e){
	  L5.MessageBox.alert("消息提示","获得当前用户门户菜单Json串出现异常!");
	  return;
  }
	
  var html='';
  //设置门户菜单名称
  var portalMenuElement=document.getElementById("portalMenu");
  //如果当前用户有可以展现的门户菜单
  if(portalMenuArray.length>0){
	for(var i=0;i<portalMenuArray.length;i++){
			html+='<a  class="cirbutton"><span align="right" style="color:'+getPortalMenuDefaultFontColor()+';font-weight:bold;" onclick="portalMenuClick(this)" id="'+portalMenuArray[i][0]+'">'+portalMenuArray[i][1]+'</span></a>';
    }
	//当前门户布局Id
	portalUserLayoutId=portalMenuArray[0][0];
	//当前门户页面布局类型
	curPageLayoutType=portalMenuArray[0][2];
	//前一次门户页面布局类型
	prePageLayoutType=curPageLayoutType;
  }
  //为门户菜单添加注销按钮
  html+=appendLogOutToPortalMenu();
  //展现门户菜单
  portalMenuElement.innerHTML=html;
}

//初始化页面样式
function initPortalCss()
{
    L5.util.CSS.swapStyleSheet("color",L5.webPath+"/jsp/portal/css/"+portalWidgetDataset.getCustomData("color")+".css");
   //document.body.style.background = "url('"+L5.webPath+"/jsp/portal/images/"+portalWidgetDataset.getCustomData("bgImage")+".gif')";
}
//初始化widget布局
function initWidgetLayout(){
	switch(curPageLayoutType)
	{
		//简单布局
		case "0":initColPortalWidgetLayout();
			    break;
	    //任意布局
		case "1":initAbsPortalWidgetLayout();
		        break;
	}
	//初始化最大化widget容器
	if(!isMaxWidgetContainerInited)
	{
		LoushangPortalUtil.initColPortalMaxWidgetContainer();
		isMaxWidgetContainerInited=true;
	}
	  
	//初始化widget背景
	initWidgetBackground();
		
	//公共区域的widget加载完毕
	isWidgetLoadedOk=true;
}
//初始化页面布局为 "column"的Portal里的widget布局
function initColPortalWidgetLayout()
{
	//1.显示微件选择器
	  var widgetSelector = L5.getCmp("widgetSelector");
	  if(widgetSelector)
	  {
		  widgetSelector.show();  
	  }
	  //2.隐藏任意布局
	  var absPortal=L5.getCmp("absportal");
	  absPortal.hide();
	  
	  //3.显示简单布局
	  var portal=L5.getCmp("portal");
	  portal.show();
	  portal.on("drop",saveWidgetLayout);
		  
	  //4.创建列
	  var pageColJson=portalWidgetDataset.getCustomData("pageColumn");
	  var pageColArray;
	  try{
		  pageColArray=eval(pageColJson);
	  }catch(e){
		  L5.MessageBox.alert("消息提示","获得页面列数出现异常!");
		  return;
	  }
	  //处理这种情况:设计模板时,保存并应用了模板,然后直接点击了门户菜单
	  if(portalUserLayoutId&&!pageColArray)
	  {
		  L5.MessageBox.alert("消息提示","页面布局已重新生成,请刷新页面!");
		  return; 
	  }
	  
	  for(var i=0;i<pageColArray.length;i++)
	  {
		  portal.addColumn(pageColArray[i][0],pageColArray[i][1]);
	  }
		
	  //5.向每列中添加widget	
	  //5.1 widget布局json串
	  var widgetLayoutJson = portalWidgetDataset.getCustomData("widgetLayout");
	  var widgetLayoutArray;
	  try
		{
			widgetLayoutArray =eval(widgetLayoutJson);
		}catch(e){
			L5.MessageBox.alert("消息提示","获得页面widget出现异常!");
			return;
		}
		
	  // 5.2 处理列数可能变动的情况
	  // 上次保存的页面列数
	  var preColumnCount=widgetLayoutArray.length;
	  // 这次设置的页面列数
	  var curColumnCount=pageColArray.length;
	  // 这次要向其中添加widget的页面列数
	  var toAddWidgetColumnCount=preColumnCount>curColumnCount?curColumnCount:preColumnCount;

	  //5.3 向每列中添加widget
	  for(var i=0;i<toAddWidgetColumnCount;i++){
		var colContainer = L5.getCmp("column"+(i+1));
		for(var j = 0 ;j<widgetLayoutArray[i].length;j++){
			var widgetId=widgetLayoutArray[i][j];
			var record = portalWidgetDataset.getById(widgetId);
			if(record)
			{
				colContainer.addPortlet(record);
			}
		}
	  }
	  //调整布局
	  portal.doLayout();
}
//初始化页面布局为 "absolute"的Portal里的widget布局
function initAbsPortalWidgetLayout()
{
	  //1.隐藏微件选择器
	  var widgetSelector = L5.getCmp("widgetSelector");
	  if(widgetSelector)
	  {
		  widgetSelector.hide();  
	  }
	  //2.隐藏简单布局
	  var portal=L5.getCmp("portal");
	  portal.hide();
	  
	  //3.显示任意布局
	  var absPortal=L5.getCmp("absportal");
	  absPortal.show();
  
	  // 4.向Portal中添加widget
	  // 4.1 widget布局json串
	  var widgetLayoutJson = portalWidgetDataset.getCustomData("widgetLayout");
	  var widgetLayoutArray;
	  try
	  {
		widgetLayoutArray =eval(widgetLayoutJson);
	  }catch(e){
		L5.MessageBox.alert("消息提示","获得页面widget布局出现异常!");
		return;
	  }
	  // 4.2 向Portal中添加widget
	  for(var i = 0 ;i<widgetLayoutArray.length;i++){
		  var widgetId=widgetLayoutArray[i][0];
		  var record = portalWidgetDataset.getById(widgetId);
		  if(record)
		  {
			var widgetX=widgetLayoutArray[i][1];
			var widgetY=widgetLayoutArray[i][2];
			var widgetWidth=widgetLayoutArray[i][3];
			var widgetHeight=widgetLayoutArray[i][4];
				
			absPortal.addPortlet(record,widgetX,widgetY,widgetWidth,widgetHeight,false);
		  }
	  }
	  
	  //调整布局
	  absPortal.doLayout();
}

//点击L5系统菜单
function sysMenuClick(ele){	
  //隐藏微件选择器
  var widgetSelector = L5.getCmp("widgetSelector");
  if(widgetSelector&&!widgetSelector.hidden)
  {
	widgetSelector.hide();
  }
  var viewport = L5.getCmp("viewport");
  viewport.syncSize();
  //隐藏普通widget容器
  var widgetContainer = L5.getCmp("widgetContainer");
  if(!widgetContainer.hidden)
  {
    widgetContainer.hide();	
  }

  //隐藏最大化widget容器
  var maxWidgetContainer = L5.getCmp("maxWidgetContainer");
  if(!maxWidgetContainer.hidden)
  {
	maxWidgetContainer.hide();
  }
 
  //显示L5系统左菜单及中间面板
  var widpanel = L5.getCmp("widpanel");
  if(widpanel.hidden)
  {
    widpanel.show();
	widpanel.doLayout();
  }
	
  //展开左侧菜单树
  var leftPanel = L5.getCmp("leftPanel");
  leftPanel.expand();
  var tree = L5.getCmp("tree");
  tree.innerCt.setVisible(false);
  tree.setRootNode(rootData.getAt(ele.id));
  tree.innerCt.slideIn('t', {
            duration: .30,
            easing:'easeIn'
     });
  tree.expand();
  
  //中间面板显示页面 
  sysMenuClickForward(ele);
}

//点击门户菜单
function portalMenuClick(ele){
  //如果公共区域的widget尚未加载完毕,则直接返回
  if(!isWidgetLoadedOk)
  { 
    return;
  }
  //否则开始加载公共区域的widget
  else
  {
      isWidgetLoadedOk=false;
  }
  
  //重新设置当前门户布局Id
  portalUserLayoutId=ele.id;
  //前一次门户页面布局类型
  prePageLayoutType=curPageLayoutType;
  //重新设置当前门户页面布局类型
  for(var i=0;i<portalMenuArray.length;i++)
  {
	  if(portalUserLayoutId==portalMenuArray[i][0])
	  {
		  curPageLayoutType=portalMenuArray[i][2];
		  break;
	  }
  }
 
  
  //微件选择器初始为折叠
  var widgetSelector = L5.getCmp("widgetSelector");
  if(widgetSelector){
	  widgetSelector.collapse(false);
	  if(widgetSelector.hidden)
	  {
		//显示微件选择器
		widgetSelector.show();
		var viewport = L5.getCmp("viewport");
		viewport.syncSize();//重新布局
	  }
  }
  //显示普通widget容器
  var widgetContainer = L5.getCmp("widgetContainer");
  if(widgetContainer.hidden){
	widgetContainer.show();	 
  }
  //隐藏L5系统左菜单及中间面板
  var widpanel = L5.getCmp("widpanel");
  widpanel.show();
  widpanel.doLayout();
  widpanel.hide();
 
  //隐藏最大化widget容器
  var maxWidgetContainer=L5.getCmp("maxWidgetContainer");
  if(!maxWidgetContainer.hidden)
  {
    maxWidgetContainer.hide();
  }

  //清除上次显示的widget
  //简单布局
  if(prePageLayoutType=="0")
  {
	  var portal = L5.getCmp("portal"); 
	  portal.removeAllColumn();
  }
  //任意布局
  else if(prePageLayoutType=="1")
  {
	  var portal = L5.getCmp("absportal"); 
	  portal.removeAllPortlet();
  }

  //首先设置门户菜单字体颜色
  for(var i=0;i<portalMenuArray.length;i++){
	document.getElementById(portalMenuArray[i][0]).style.color=getPortalMenuDefaultFontColor();
  }
  //然后设置选中的门户菜单字体颜色
  document.getElementById(portalUserLayoutId).style.color=getPortalMenuSelectedFontColor();

  //重新载入当前页的widget
  portalWidgetDataset.setParameter("portalUserLayoutId", portalUserLayoutId);
  portalWidgetDataset.load();
  //中间面板显示页面 
  portalMenuClickForward(ele);
}

//保存当前widget布局
function saveWidgetLayout(){
  var portal = L5.getCmp("portal");  
  var array=portal.toJsonArray();
  //将上面的json串保存到数据库中。
  var command = new L5.Command("org.loushang.portal.layout.cmd.PortalUserLayoutCmd");
  command.setParameter("widgetLayout",L5.encode(array));
  command.setParameter("portalUserLayoutId",portalUserLayoutId);

  command.afterExecute=function(){
	if (command.error){
	 L5.MessageBox.alert(command.error);
	}
  }
  command.execute("savePortalPageLayout",false);
}

//设置主题
function zhuticlick(ele){
	L5.util.CSS.swapStyleSheet("color",L5.webPath+"/jsp/portal/css/"+ele.value+".css");
	//保存设置
	var command = new L5.Command("org.loushang.portal.layout.cmd.PortalUserLayoutCmd");
	command.setParameter("portalUserLayoutId",portalUserLayoutId);
	command.setParameter("color",ele.value);
	command.execute("savePortalPageBackgroundColor",false);
}

//设置背景
function bgclick(ele){
	document.body.style.background = "url('"+L5.webPath+"/jsp/portal/images/"+ele.id+".gif')";
	document.getElementById("portal").firstChild.firstChild.style.background = "url('"+L5.webPath+"/jsp/portal/images/"+ele.id+".gif')";
	//保存设置
	var command = new L5.Command("org.loushang.portal.layout.cmd.PortalUserLayoutCmd");
	command.setParameter("portalUserLayoutId",portalUserLayoutId);
	command.setParameter("bgImage",ele.id);
	command.execute("savePortalPageBackgroundImage",false);
}

//初始化widget背景
function initWidgetBackground(){
	document.getElementById("portal").firstChild.firstChild.style.background = "url('"+L5.webPath+"/jsp/portal/images/"+portalWidgetDataset.getCustomData("bgImage")+".gif')";
	document.getElementById("widpanel").firstChild.firstChild.style.background = "url('"+L5.webPath+"/jsp/portal/images/"+portalWidgetDataset.getCustomData("bgImage")+".gif')";
}