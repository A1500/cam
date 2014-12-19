//当前门户页面布局Id
var portalUserLayoutId = null;
// 当前门户页面布局类型(0:简单布局,1:任意布局)
var curPageLayoutType = "0";
// 是否保存微件布局
var isSaveWidgetLayout = true;
// 初始化
function init() {
	//微件选择器初始为折叠
	var widgetSelector = L5.getCmp("widgetSelector");
	if (widgetSelector) {
		widgetSelector.collapse(false);
	}

	//门户菜单Json串
	var portalMenuJson = portalMenuDataset.getCustomData("portalPageJson");
	// 如果没有门户菜单,则显示欢迎图片
	if (!portalMenuJson || portalMenuJson == "[]") {
		//隐藏普通widget容器
		var widgetContainer = L5.getCmp("widgetContainer");
		widgetContainer.hide();
		// 隐藏最大化widget容器
		var maxWidgetContainer = L5.getCmp("maxWidgetContainer");
		maxWidgetContainer.hide();
		// 隐藏微件选择器
		if (widgetSelector) {
			widgetSelector.hide();
		}
		//显示欢迎图片
		var headImg = document.getElementById("headImg");
		headImg.style.display = "";
		return;
	} else {
		try {
			var portalMenuArray = eval(portalMenuJson);
			portalUserLayoutId = portalMenuArray[0][0];
			curPageLayoutType = portalMenuArray[0][2];
		} catch (e) {
			L5.MessageBox.alert("消息提示", "获得当前用户门户菜单Json串出现异常!");
			return;
		}
	}

	portalWidgetDataset.setParameter("portalUserLayoutId", portalUserLayoutId);
	portalWidgetDataset.load(true);
	// 设置样式
	L5.util.CSS.swapStyleSheet("color", L5.webPath + "/jsp/portal/css/"
			+ portalWidgetDataset.getCustomData("color") + ".css");
	document.body.style.background = "url('" + L5.webPath
			+ "/jsp/portal/images/"
			+ portalWidgetDataset.getCustomData("bgImage") + ".gif')";

	// 简单页面布局
	if (curPageLayoutType == "0") {
		//1.隐藏任意布局
		 var absPortal = L5.getCmp("absportal");
		 absPortal.hide();

		// 2.显示简单布局
		var portal = L5.getCmp("portal");
		portal.show();
		portal.on("drop", saveWidgetLayout);

		// 3.创建列
		var pageColJson = portalWidgetDataset.getCustomData("pageColumn");
		var pageColArray;
		try {
			pageColArray = eval(pageColJson);
		} catch (e) {
			L5.MessageBox.alert("消息提示", "获得页面列数出现异常!");
			return;
		}
		//处理这种情况:设计模板时,保存并应用了模板,然后直接点击了门户菜单
		if(portalUserLayoutId&&!pageColArray)
		{
			L5.MessageBox.alert("消息提示","页面布局已重新生成,请刷新页面!");
			return; 
		}

		for ( var i = 0; i < pageColArray.length; i++) {
			portal.addColumn(pageColArray[i][0], pageColArray[i][1]);
		}

		//4.向每列中添加widget	
		// 4.1 widget布局json串
		var widgetLayoutJson = portalWidgetDataset
				.getCustomData("widgetLayout");
		var widgetLayoutArray;
		try {
			widgetLayoutArray = eval(widgetLayoutJson);
		} catch (e) {
			L5.MessageBox.alert("消息提示", "获得页面widget出现异常!");
			return;
		}

		// 4.2 处理列数可能变动的情况
		// 上次保存的页面列数
		var preColumnCount = widgetLayoutArray.length;
		// 这次设置的页面列数
		var curColumnCount = pageColArray.length;
		// 这次要向其中添加widget的页面列数
		var toAddWidgetColumnCount = preColumnCount > curColumnCount ? curColumnCount
				: preColumnCount;

		// 4.3 向每列中添加widget
		for ( var i = 0; i < toAddWidgetColumnCount; i++) {
			var colContainer = L5.getCmp("column" + (i + 1));
			for ( var j = 0; j < widgetLayoutArray[i].length; j++) {
				var widgetId = widgetLayoutArray[i][j];
				var record = portalWidgetDataset.getById(widgetId);
				if (record) {
					colContainer.addPortlet(record);
				}
			}
		}
		//调整布局
		portal.doLayout();
	}
	//任意布局
	else if (curPageLayoutType == "1") {
		//1.隐藏微件选择器
		if(widgetSelector)
		{
			widgetSelector.hide();  
		}
		
		//2.隐藏简单页面布局
		var portal = L5.getCmp("portal");
		portal.hide();

		// 3.显示任意布局
		var absPortal = L5.getCmp("absportal");
		absPortal.show();

		// 4.向Portal中添加widget
		// 4.1 widget布局json串
		var widgetLayoutJson = portalWidgetDataset
				.getCustomData("widgetLayout");
		var widgetLayoutArray;
		try {
			widgetLayoutArray = eval(widgetLayoutJson);
		} catch (e) {
			L5.MessageBox.alert("消息提示", "获得页面widget布局出现异常!");
			return;
		}
		// 4.2 向Portal中添加widget
		for ( var i = 0; i < widgetLayoutArray.length; i++) {
			var widgetId = widgetLayoutArray[i][0];
			var record = portalWidgetDataset.getById(widgetId);
			if (record) {
				var widgetX = widgetLayoutArray[i][1];
				var widgetY = widgetLayoutArray[i][2];
				var widgetWidth = widgetLayoutArray[i][3];
				var widgetHeight = widgetLayoutArray[i][4];

				absPortal.addPortlet(record, widgetX, widgetY, widgetWidth,
						widgetHeight,false);
			}
		}

		//调整布局
		absPortal.doLayout();
	}
	
	// 初始化最大化widget容器
	LoushangPortalUtil.initColPortalMaxWidgetContainer();
}
//保存当前widget布局
function saveWidgetLayout() {
	var portal = L5.getCmp("portal");
	var array = portal.toJsonArray();
	// 将上面的json串保存到数据库中。
	var command = new L5.Command(
			"org.loushang.portal.layout.cmd.PortalUserLayoutCmd");
	command.setParameter("widgetLayout", L5.encode(array));
	command.setParameter("portalUserLayoutId", portalUserLayoutId);

	command.afterExecute = function() {
		if (command.error) {
			L5.MessageBox.alert(command.error);
		}
	}
	command.execute("savePortalPageLayout", false);
}