var organNameTitleCode=escape(encodeURIComponent(organName));//供jsp页面传值使用
function init() {
	//判断资金拨付追踪
	disFundsSourceAlloDs.events['load'] = true; 
	disFundsSourceAlloDs.on('load',function(){
		if(disFundsSourceAlloDs.getCount()>1) {
			//打开window
			var FollowAlloWin = L5.getCmp("FollowAlloWin");
			FollowAlloWin.show();
		}else if(disFundsSourceAlloDs.getCount()==1) {
			//直接打开
			openFollowAlloDetail(disFundsSourceAlloDs.getAt(0).get("BATCH_ID"));
		}
	});
	//判断物资折款追踪
	disFundsSourceSwapDs.events['load'] = true; 
	disFundsSourceSwapDs.on('load',function(){
		if(disFundsSourceSwapDs.getCount()>1) {
			//打开window
			var FollowSwapWin = L5.getCmp("FollowSwapWin");
			FollowSwapWin.show();
		}else if(disFundsSourceSwapDs.getCount()==1) {
			//直接打开
			openFollowSwapDetail(disFundsSourceSwapDs.getAt(0).get("BATCH_ID"));
		}
	});
	
	disFundsSourceDs.events['load'] = true; 
	disFundsSourceDs.on('load',function(){
		if(disFundsSourceDs.getCount()>0) {
			if(disFundsSourceDs.getAt(0).get("sourceType")=="0") {
				//上级下拨
				document.getElementById("trBudget").style.display="none";
				document.getElementById("trAlloNum").style.display="";
			}else if(disFundsSourceDs.getAt(0).get("sourceType")=="1") {
				//本级投入
				document.getElementById("trBudget").style.display="";
				document.getElementById("trAlloNum").style.display="none";
				document.getElementById("trUap").style.display="none";
				document.getElementById("trUat").style.display="none";
				document.getElementById("upAllocationType").style.display="none";
			}else {
				//社会捐赠
				document.getElementById("trBudget").style.display="none";
				document.getElementById("trAlloNum").style.display="none";
			}
		}
	});
	disFundsSourceDs.setParameter("SOURCE_ID", sourceId);
	disFundsSourceDs.load();
	
	disFundsSourceFollowDs.setParameter("organCode", organCode);
	disFundsSourceFollowDs.setParameter("sourceId", sourceId);
	disFundsSourceFollowDs.load();
	
	disFundsSourceFollowDetailDs.setParameter("organCode", organCode);
	disFundsSourceFollowDetailDs.setParameter("sourceId", sourceId);
	disFundsSourceFollowDetailDs.load();
}
//拨付渲染
function amountBfRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	if(value>0.0)
		return '<a href="javascript:bfQuery(\'0\')">' + formatMoneyForDis(value) + '</a>';
	return formatMoneyForDis(value);
}
//拨付渲染
function useTypeRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	if(value=="F")
		return "资金拨付";	
	else if(value=="P")
		return "资金发放";
	return "物资采购";
}
//拨付查询
function bfQuery(index) {
	var record = disFundsSourceFollowDs.getAt(index);
	if(record.get("AMOUNT_BF")>0.0) {
		disFundsSourceAlloDs.setParameter("organCode", record.get("ID"));
		disFundsSourceAlloDs.setParameter("batchId", record.get("BATCH_ID"));
		disFundsSourceAlloDs.setParameter("sourceId", record.get("SOURCE_ID"));
		disFundsSourceAlloDs.load();
	}
}
//关闭资金追踪多记录窗口
function onCloseFollowAlloWin(){
	var FollowAlloWin = L5.getCmp("FollowAlloWin");
	FollowAlloWin.hide();
}
//查看资金追踪明细
function onFollowAlloDetail(){
	var followAlloGrid = L5.getCmp("followAlloGrid");
	var selected = followAlloGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录进行查看!");
		return false;
	}
	openFollowAlloDetail(selected[0].get("BATCH_ID"));
}
//进入明细页面
function openFollowAlloDetail(bId) {
	var url = 'fundsAllocationFollow.jsp?method=update&batchId='+bId+"&organNameTitleCode="+organNameTitleCode;
	var width = screen.width-50;
    var height = screen.height-50;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}


//物资折款渲染
function amountWzRenderer(value,cellmeta,record,rowindex,colindex,dataset) {
	if(value>0.0)
		return '<a href="javascript:wzQuery(\'0\')">' + formatMoneyForDis(value) + '</a>';
	return formatMoneyForDis(value);
}
//物资折款查询
function wzQuery(index) {
	var record = disFundsSourceFollowDs.getAt(index);
	if(record.get("AMOUNT_WZ")>0.0) {
		disFundsSourceSwapDs.setParameter("organCode", record.get("ID"));
		disFundsSourceSwapDs.setParameter("batchId", record.get("BATCH_ID"));
		disFundsSourceSwapDs.setParameter("sourceId", record.get("SOURCE_ID"));
		disFundsSourceSwapDs.load();
	}
}
//关闭物资折款追踪多记录窗口
function onCloseFollowSwapWin(){
	var FollowSwapWin = L5.getCmp("FollowSwapWin");
	FollowSwapWin.hide();
}
//查看物资折款追踪明细
function onFollowSwapDetail(){
	var followSwapGrid = L5.getCmp("followSwapGrid");
	var selected = followSwapGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录进行查看!");
		return false;
	}
	openFollowSwapDetail(selected[0].get("BATCH_ID"));
}
//进入物资折款明细页面
function openFollowSwapDetail(bId) {
	var url = 'fundsGoodSwapDetails.jsp?batchId='+bId+"&organNameTitleCode="+organNameTitleCode;
	var width = screen.width-50;
    var height = screen.height-50;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}

//发放资金渲染
function amountFfRenderer(value,cellmeta,record,rowindex,colindex,dataset) {
	if(value>0.0)
		return '<a href="javascript:ffQuery(\'0\')">' + formatMoneyForDis(value) + '</a>';
	return formatMoneyForDis(value);
}
//发放资金查询,未完成....
function ffQuery(bId,sId,bdId) {
	//先判断是否已确认
	var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
	cmd.setParameter("batchId", bId);
	cmd.execute("queryReliefType");
	var flag = cmd.getReturn("flag");	
	var url = "fundsDoleRollList.jsp?batchId="+bId+"&doleId="+sId+"&batchDetailId="+bdId+"&flag="+flag;
	var width = screen.width-50;
    var height = screen.height-50;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}


//使用金额渲染
function amountUseRenderer(value,cellmeta,record,rowindex,colindex,dataset) {
	if(value>0.0) {
		if(record.get("USE_TYPE")=="F")
			return '<a href="javascript:openFollowAlloDetail(\'' + record.get("BATCH_ID") + '\')">' + formatMoneyForDis(value) + '</a>';
		else if(record.get("USE_TYPE")=="D")
			return '<a href="javascript:openFollowSwapDetail(\'' + record.get("BATCH_ID") + '\')">' + formatMoneyForDis(value) + '</a>';
		else if(record.get("USE_TYPE")=="P")
			return '<a href="javascript:ffQuery(\'' + record.get("BATCH_ID") +  '\',\''+record.get("SOURCE_ID")+  '\',\''+record.get("BATCH_DETAIL_ID")+'\')">' + formatMoneyForDis(value) + '</a>';
	}
	return formatMoneyForDis(value);
}
