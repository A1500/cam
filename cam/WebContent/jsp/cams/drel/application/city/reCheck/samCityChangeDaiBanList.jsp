<%@page import="org.loushang.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.drel.comm.RoleCmp" %>
<html>
<head>
<%
	String nameValue="";
	String name="";
	//if(RoleCmp.getIfRoleName("城市低保变更流程")){
		
	if(RoleCmp.getIfRoleName("城市低保业务受理审核")){
			name="审核";
			nameValue="check";
	}
	if(RoleCmp.getIfRoleName("城市低保业务审批")){
			name="审批";
			nameValue="audit";
	}
%>
<title>新申请待办</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"ISPrint.js")%>'></script>
<script type="text/javascript" src='../../print/samChangePrint.js'></script>
<script type="text/javascript">
    <%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
    var assistanceType="01";
    var assistanceTypeName="城市居民最低生活保障";
    var currentDate="<%=DateUtil.getMonth() %>";
	var nameValue='<%=nameValue%>';
	var applyIds ='';
	var assignmentIds='';
	function setTaskState(value,a,rec)
	{
		var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
		var image="";
		//正常状态
		if(value=="0")
		{
			image="normal.png";
		}
		//预警状态
		else if(value=="1")
		{
			image="warn.png";
		}
		//超时状态
		else if(value=="2")
		{
			image="limit.png";
		}else{ //测试使用
			image="normal.png";
		}
	
		return '<img src="'+imagePath+image+'" />';
	}
	function renderDate(value,cellmeta,record) {
		var revalue="";
		revalue+= value.substr(0,4)+"-";
		revalue+= value.substr(4,2)+"-";
		revalue+= value.substr(6,2);
//		revalue+= value.substr(8,6);
		return revalue;
	}
	//查看待办流程图
	function showState(){
		var daiBanTaskGridPanel=L5.getCmp("daiBanGridPanel");
		var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
		if(selecteds.length!=1){
			L5.Msg.alert("提示","请选择一条您要查看的记录");
			return false;
		}
		var assignmentId=selecteds[0].get("ID");
		var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
		L5.forward(url);
	}
	function init(){
		query();
		document.getElementById("lrdwmc").value=organName;
		document.getElementById("lrdwId").value=organArea;
	}
	//新增业务
	function newApply(){
		var width = screen.width-100;
	    var height = screen.height-140;
		var url='samCityInsert.jsp?method=insert&applyId=&name='+nameValue+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
	//办理						
	function handle(){
	
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			var width = screen.width-100;
		    var height = screen.height-140;
		    var curActivityId = records[0].get("CUR_ACTIVITY_ID");
			/*if(!isInArray(curActivityId,nameValue)){
				L5.Msg.alert("警告","此业务因乡镇（街道）操作时出现问题！请联系维护人员！");
				return;
			}*/
		    if(isInArray("check",nameValue)){
		  	  var url='samCityDetail.jsp?method=handle&name=check&applyId='+records[0].get('APPLY_ID')+'&assignmentId='+records[0].get('ID')+"&hrefFlg="+getCurrent();
		    }else if(isInArray("audit",nameValue)){
		  	  var url='samCityDetail.jsp?method=handle&name=audit&applyId='+records[0].get('APPLY_ID')+'&assignmentId='+records[0].get('ID')+"&hrefFlg="+getCurrent();
		    }
		    //alert(url);
		    //var url='samCityDetail.jsp?method=handle&name=check&applyId='+records[0].get('APPLY_ID')+'&assignmentId='+records[0].get('ID')+"&hrefFlg="+getCurrent();
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
		//批量审批
	function batchHandle(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		applyIds='';
		assignmentIds="";
		if(records&&records.length > 0){
			for(var i =0; i<records.length; i++){
				var curActivityId = records[0].get("CUR_ACTIVITY_ID");
				if(curActivityId != nameValue){
					L5.Msg.alert("警告","户主姓名为"+records[0].get("FAMILY_NAME")+"的业务因乡镇（街道）操作时出现问题！请联系维护人员！");
					return;
				}
				applyIds += records[i].get('APPLY_ID') +';';
				assignmentIds += records[i].get('ID') +';';
			}
			var width = screen.width-300;
			var height = screen.height-100;
		  	var url='../../batchApp/samBatchHandleAudit.jsp?method=handle&assistanceType='+assistanceType+'&hrefFlg='+getCurrent();
			window.showModalDialog(url, window, "scroll:no;status:no;resizable=no;location=no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		
		}else{
			L5.Msg.alert("提示","请至少选择一条记录！");
		}
	}
	//删除
	function removeApply(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
		    if(isInArray("check",nameValue) ){
			  	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
					if(sta=="yes"){
						var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamApplyInfoCmd");
						command.setParameter("APPLY_ID",records[0].get('APPLY_ID'));
						command.execute("deleteSamApply");
						if (!command.error) {
							L5.Msg.alert("提示","删除成功！",function(){
								query();
							});		
						}else{
							L5.Msg.alert('提示',"删除时出现错误！"+command.error);
						}
					}
					else{
						return;
					}
				});	
		    }else{
		    	L5.Msg.alert("提示","没有权限删除此条数据！");
		    }
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	//打印
    function printNotice(){
        printChangeNotice("daiBanGridPanel");
    }
	//查询
	function query(){
	   var lrdwId=document.getElementById("lrdwId").value;
	    if(""==lrdwId){
	    	lrdwId=organArea;
	    }
		var regDateStart=document.getElementById("regDateStart").value;
		var regDateEnd=document.getElementById("regDateEnd").value;
		var familyName=document.getElementById("familyName").value;
		var idCard=document.getElementById("idCard").value;
		var mysetwhere="FAMILY_NAME:"+familyName+"&FAMILY_CARD_NO:"+idCard+"&DOMICILE_CODE:"+lrdwId+"&APPLY_DATE:"+regDateStart+"-"+regDateEnd;
		applyDataSet.setParameter("mysetwhere",mysetwhere);
		applyDataSet.load();
		noReclick(applyDataSet,"queryId");
		if (regDateStart > regDateEnd) {
			alert("开始日期不能大于结束日期，请重新输入！");
			regDateStart.focus();
			return false;
	     }
	}
	/**
	 * 选择属地行政区划窗口
	 */
	function func_ForDomicileSelect() {
		var revalue = window.showModalDialog(
				L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
						+ organArea + "&organName="
						+ escape(encodeURIComponent(organName)), "",
				"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if (revalue != "" && revalue != undefined) {
			var list = revalue.split(";");
			document.getElementById("lrdwId").value = list[0];
			document.getElementById("lrdwmc").value = list[1];
		}
	}
	//获取当前时间
	function getCurrent(){
		
		return (new Date()).getTime();
	}
	function exportExcel(){
		var dataset=L5.DatasetMgr.lookup("applyDataSet");	
		if(dataset.getCount()<=0){
			L5.Msg.alert('提示', "无查询结果，不能导出!");
			return false;
		}	
		var pageSize = dataset.pageInfo.pageSize;
		var pageIndex = dataset.pageInfo.pageIndex;
		var startCursor = dataset.pageInfo.startCursor;
		dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
		dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
		dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
		var filename="待办业务列表";
		var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
		var gridObj = L5.getCmp("daiBanGridPanel");
		L5.grid2excel(dataset, gridObj, filename, class_path);
	}
</script>
</head>
<body>

<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryDaiBan" global="true"  >
		<model:record>
			<model:field name="checkFlg"/>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
		<model:params>
			<model:param name="processType" value='reCheckCity'></model:param>
			<model:param name="applyType" value='013'></model:param>
			<model:param name="actDefName" value='<%=name%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="noticePrintDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryNoticePrintData" global="true"  >
    </model:dataset>
    <!-- 变更事项 -->
    <model:dataset id="samChangeItemDs" enumName="SAM_CHANGE_ITEM" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>
			<next:Panel name="form" width="100%" border="0">
				<next:Html>
					<fieldset><legend>查询条件 </legend>
					<div>
					<form class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:10%">地区</td>
							   	<td class="FieldInput" style="width:23%">
							        <input type="text" id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" value="<%=organName%>" style='width:80%'/>
									<input type="text" style="display: none;"  name="lrdwId" id="lrdwId" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
										  <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
							     </td>
							     <td class="FieldLabel" style="width:10%">户主姓名</td>
							     <td class="FieldInput" style="width:23%"><input type="text"  id="familyName" style='width:80%' maxlength="30"/></td>
							     <td class="FieldLabel" style="width:10%">身份证号码</td>
							     <td class="FieldInput" style="width:23%"><input type="text" id="idCard" style="width:79%" maxlength="18"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:10%">登记日期</td>
							    <td class="FieldInput" style="width:23%" colspan="3">
									<input type="text" id="regDateStart"  format="Y-m-d" onclick="LoushangDate(this)" 
							           style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
							           ~<input type="text" id="regDateEnd" format="Y-m-d" onclick="LoushangDate(this)" 
							               		style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
							    </td>
								<td class="FieldButton" style="width:10%"  colspan="2">
								<button style="width:100" id="queryId" onclick="query();">查询</button>
								   &nbsp;&nbsp;&nbsp;&nbsp;
								<button type="reset" style="width:100">重置</button>
							    </td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true"id="daiBanGridPanel" dataset="applyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem id="qrToolbar" text="城市低保复查待办家庭查询信息"></next:ToolBarItem>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<next:ToolBarItem iconCls="detail"  text="办理" handler="handle"/>
						<%
						if(name.contains("审批")){	%>	
						<next:ToolBarItem iconCls="detail"  text="批量审批" handler="batchHandle"/>
						<%
						}else{
						}
						%>
						<next:ToolBarItem text="导出CSV" iconCls="chart" 	handler="exportExcel"></next:ToolBarItem> 
						<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showState"/>
						<next:ToolBarItem iconCls="print"  text="打印公示书" handler="printNotice"/> 	
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		    			<next:CheckBoxColumn></next:CheckBoxColumn>
		    			<next:Column header="状态" field="TASK_STATE" width="40" align="center" renderer="setTaskState">
							<next:TextField allowBlank="false"/>
						</next:Column> 
						<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="200"  ></next:Column>
						<next:Column header="家庭住址" field="ADDRESS" width="150" ></next:Column>						
				        <next:Column header="户主姓名" field="FAMILY_NAME" width="150" ></next:Column>
			        	<next:Column header="身份证号码" field="FAMILY_CARD_NO" width="150" ></next:Column>
			        	<next:Column header="联系电话" field="FAMILY_MOBILE" width="150" ></next:Column>
						<next:Column header="登记日期" field="ACCEPT_DATE" width="150" ></next:Column>
						<next:Column header="当前环节" field="ACT_DEF_NAME" width="140" ></next:Column>
						
						<next:Column header="办理时限" field="ACT_LIMIT_TIME" width="140" align="center" renderer="renderDate"></next:Column> 
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="applyDataSet" />
					</next:BottomBar>
				</next:GridPanel>
</body>
</html>