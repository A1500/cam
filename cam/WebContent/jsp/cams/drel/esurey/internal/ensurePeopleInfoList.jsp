<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<%

	String nameValue=request.getParameter("name");
	String flag=request.getParameter("flag");
	if(flag == null){
		flag="";
	}
	String name="审批";
%>
<title>待核查人员列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript">
	var domicileCode='<%=request.getParameter("domicileCode")%>';
	var applyType='<%=request.getParameter("applyType")%>';
	var townName=decodeURIComponent('<%=request.getParameter("townName")%>');
	function init(){
		applyDataSet.setParameter("domicileCode",domicileCode.substr(0,6));
		applyDataSet.setParameter("applyType",applyType);
		applyDataSet.setParameter("townName",townName);
		applyDataSet.load();
	}
	
	//导出Excel
	function exportExcel(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		var applyIds="";
		for(var i =0; i<records.length; i++){
			applyIds+=records[i].get("APPLY_ID")+",";
		}
		if(applyIds){
			var dataset=L5.DatasetMgr.lookup("exportDataSet");
			dataset.setParameter("applyIds",applyIds);
			dataset.load();
			var pageSize = dataset.pageInfo.pageSize;
			var pageIndex = dataset.pageInfo.pageIndex;
			var startCursor = dataset.pageInfo.startCursor;
			dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
			dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
			dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
			L5.dataset2excel(dataset, "/jsp/cams/drel/export/commExcel.jsp");
			//disDateStart="+disDateStart+"&disDateEnd="+disDateEnd+"&empDateStart="+empDateStart+"&empDateEnd="+empDateEnd+"&expDateStart="+expDateStart+"&expDateEnd="+expDateEnd+"&checkDate="+checkDate
			dataset.baseParams["excelType"]="reset"; //重置导出类型

		}else{
			L5.Msg.alert("提示","请至少选择一条记录！");
		}
	}
	
	//测试
	//导出核对结果信息
	function exportXML(){
		var grid=L5.getCmp("daiBanGridPanel");
		var records=grid.getSelectionModel().getSelections();
		if(records.length==0){
			L5.Msg.alert("提示","请至少先选中一行!");
			return;
		}
		var applyIds="";
		for(var index=0;index<records.length;index++){
			if(applyIds!=""){
				applyIds+=",";
			}
			applyIds+=records[index].get("APPLY_ID");
		}
		var command = new L5.Command("com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientCmd");
		command.setParameter("applyIds",applyIds);
		command.execute("createXML");
		if(!command.error){
			L5.Msg.alert("提示","导出成功！");
		}else{
			L5.Msg.alert("提示","导出失败！"+command.error);
		}
	}
	
	
	function showEnsureInfo(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records.length==1){
			if(records[0].get("ENSURE_ID")==""){
				L5.Msg.alert("提示","核对信息未反馈！");
				return;
			}
			var applyId=records[0].get("APPLY_ID");
			var url = "../../../comm/ensureInfo/ensureToClientDetail.jsp?applyId="+applyId;
			var width = "1200";
		    var height = "300";
		    //var width = screen.availWidth;
		    //var height = screen.availHeight;
			var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
			if(true || returnValue) {
				//reQuery();
			}
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	
	//链接明细
	function editHref(value,cellmeta,record,rowindex,colindex,dataset){
			return 	'<a href="javascript:detail(\''+record.get("DECIMAL_CODE")+'\')">'+value+'</a>';
	}
	function detail(decimalCode){
		var url = "dicCityCheckDetail.jsp?decimalCode="+decimalCode;
		var width = screen.availWidth;
	    var height = screen.availHeight;
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue) {
			//reQuery();
		}
	}
	function detail(){
		var grid=L5.getCmp("grid");
		var records=grid.getSelectionModel().getSelections();
		if(records.length==0){
			L5.Msg.alert("提示","请先选中一行!");
			return;
		}
		var url = "dicCityCheckDetail.jsp?method=detail&batchId="+records[0].get("batchId");
		var width = screen.availWidth;
	    var height = screen.availHeight;
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue) {
			//reQuery();
		}
		/*var data=new L5.Map();
		data.put("method","detail");
		data.put("batchId",records[0].get("batchId"));
		url="jsp/cams/comm/diccityChange/dicCityChangeList.jsp";
		L5.forward(url,'',data);*/
	}
</script>
</head>
<body>

<model:datasets>
	<!-- 核对家庭信息 -->
	<model:dataset id="esureyFamilyDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily">
		</model:record>
	</model:dataset>
	
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryForPeopleDetail" global="true"  pageSize="20" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 业务信息 test-->
	<model:dataset id="exportDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryExport" global="true"  pageSize="20" >
	</model:dataset>
</model:datasets>
	<next:Panel width="100%" height="100%">
		 <next:GridPanel  clickToSelectedForChkSM="true" id="daiBanGridPanel" title="待核查人员列表" dataset="applyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
			<next:Columns>
   				<next:RowNumberColumn/>
   				<next:Column  header="街道（乡镇）" field="TOWN_NAME"  width="200"  ></next:Column>
   				<next:Column  header="业务主键" field="APPLY_ID" hidden="true"  width="200"  ></next:Column>	
   				<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="200"  ></next:Column>	
   				<next:Column  header="姓名" field="NAME"  width="200"  ></next:Column>
   				<next:Column  header="身份证号" field="ID_CARD"  width="200"  ></next:Column>
   				<next:Column  header="户主姓名" field="FAMILY_NAME"  width="200"  ></next:Column>	
   				<next:Column  header="户主身份证号" field="FAMILY_CARD_NO"  width="200"  ></next:Column>	
   				<next:Column  header="审批环节" field="CUR_ACTIVITY_NAME"  width="200"  ></next:Column>	
   				<next:Column  header="登记日期" field="BEGIN_DATE" hidden="true"  width="200"  ></next:Column>	
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="applyDataSet" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</body>

</html>