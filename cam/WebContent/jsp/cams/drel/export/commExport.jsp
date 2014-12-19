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
	String name="";
	if("accept".equals(nameValue)){
		name="受理";
	}else if("check".equals(nameValue)){
		name="审核";
	}else if("audit".equals(nameValue)){
		name="审批";
	}
%>
<title>新申请待办</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../../print/samApplyPrint.js"></script>
<script type="text/javascript">
    <%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
	var nameValue='<%=nameValue%>';
	var flag='<%=flag%>';
	var assistanceType="01";
	var applyIds ='';
	var assignmentIds='';
	function init(){
		query();
		document.getElementById("lrdwmc").value=organName;
		document.getElementById("lrdwId").value=organArea;
	}
	
	//测试
	function exportTest(){
		/*var grid=L5.getCmp("grid");
		var records=grid.getSelectionModel().getSelections();
		if(records.length==0){
			L5.Msg.alert("提示","请先选中一行!");
			return;
		}*/
		var url = "../../../export/commExport.jsp";
		var width = "800";
	    var height = "200";
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue) {
			//reQuery();
		}
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
	
	//导出数据
	function exportExcel(){
		
		  var dataset = L5.DatasetMgr.lookup("applyDataSet");
		    if(dataset.getCount()<1){
		        L5.Msg.alert("提示","没有要导出的信息！");
		        return;
		    }
		    
	        var startCursor = dataset.pageInfo.startCursor;
	        dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	        dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	        dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()

		    var filename="城市低保_新申请_待办_"+"<%=name%>";
		    var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
		    var gridObj = L5.getCmp("daiBanGridPanel");
		    L5.grid2excel(dataset,gridObj,filename,class_path);
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
	<model:dataset id="printDS" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryDaiBan" global="true"  >
		<model:params>
			<model:param name="processType" value='samCity'></model:param>
			<model:param name="actDefName" value='<%=name%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryDaiBan" global="true"  pageSize="20" >
		<model:record>
			<model:field name="checkFlg"/>
		</model:record>
		<model:params>
			<model:param name="processType" value='samCity'></model:param>
			<model:param name="actDefName" value='<%=name%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
			<next:Panel width="100%" height="100%">
				<next:Panel title="导出业务查询" width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html>			
							<form class="L5form">
								<table  border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">地区</td>
						                <td class="FieldInput" style="width:20%">
						                 <input type="text" id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" value="<%=organName%>" style='width:80%'/>
									  <input type="text" style="display: none;"  name="lrdwId" id="lrdwId" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
									  <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
						               
						               </td>
						                <td class="FieldLabel" style="width:10%">业务类别</td>
						                <td class="FieldInput" style="width:20%"><input type="text" id="applyType" style="width:79%"/>
						                </td>
						                <td class="FieldButton" style="width:10%"><button style="width:100" id="queryId" onclick="query();">查询</button></td>
									</tr>
									<tr>
									 	<td class="FieldLabel" style="width:10%">办理环节</td>
						                <td class="FieldInput" style="width:10%"><input type="text"  id = "applyStep" style="width:79%"/></td>
						                <td class="FieldLabel" style="width:10%">户主姓名</td>
						                <td class="FieldInput" style="width:10%"><input type="text" id="idCard" style="width:79%" maxlength="18"/></td>
						                 <td class="FieldButton" style="width:10%"><button type="reset" style="width:100">重置</button></td>
									</tr>
								</table>
							</form>
					</next:Html>
				</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true"id="daiBanGridPanel" title="导出列表" dataset="applyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
                        <next:ToolBarItem iconCls="export"  text="导出" handler="exportExcel"/>    
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:CheckBoxColumn></next:CheckBoxColumn>
		   				<next:Column  header="申请唯一号" field="APPLY_ID"  width="200"  ></next:Column>	
		   				<next:Column header="主申请人姓名" field="FAMILY_NAME" width="150" ></next:Column>
		   				<next:Column header="主申请人证件号码" field="FAMILY_CARD_NO" width="150" ></next:Column>
		   				<next:Column header="成员一姓名" field="ACT_DEF_NAME" width="140" ></next:Column>
		   				<next:Column header="性别" field="ACT_DEF_NAME" width="140" ></next:Column>
		   				<next:Column header="出生年月" field="ACT_DEF_NAME" width="140" ></next:Column>
		   				<next:Column header="证件号码" field="ACT_DEF_NAME" width="140" ></next:Column>
		   				<next:Column header="与主申请人关系" field="ACT_DEF_NAME" width="140" ></next:Column>
		   				<next:Column header="曾用名" field="ACT_DEF_NAME" width="140" ></next:Column>
		   				<next:Column header="当前环节" field="ACT_DEF_NAME" width="140" ></next:Column>
		   				<next:Column  header="街道（乡镇）" field="TOWM_NAME"  width="200" hidden ='true'  ></next:Column>	
						<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="200" hidden ='true'  ></next:Column>							
						<next:Column header="登记日期" field="APPLY_DATE" width="150" hidden ='true' ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="applyDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>

</body>

</html>