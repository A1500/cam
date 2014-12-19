<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>查询审批通过打证信息</title>
		<next:ScriptManager/>
		<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
		</script>
	</head>
<body>
<model:datasets>

	<!-- 审批通过打证信息 -->
	<model:dataset id="PassApplyDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="queryPrintInfo" global="true">
	</model:dataset>
	
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>

	<!-- 优抚对象类别 -->
	<model:dataset id="ObjectTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
</model:datasets>
<next:Panel  name="form" width="100%" border="0" autoScroll="true" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
	    <legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
						<tr >
								<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
								<td class="FieldInput"><input type="text"  id="domicileName" class="TextEditor" title="属地行政区划" onclick="forHelp()" />
													   <input type="hidden"  id="domicileCode" class="TextEditor" title="属地行政区划"  /></td>	
								
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" style="width:135px;" title="身份证件号码"  /></td>
						</tr>   
						<tr>		
								<td class="FieldLabel" nowrap="nowrap">业务类型：</td>
								<td class="FieldInput">
									<select id="serviceType" title="优抚对象状态"> 
										<option value="">-请选择-</option>
										<option value="11">评残</option> 
										<option value="12">调残</option> 
									</select>
								</td>
								
								<td class="FieldLabel" nowrap="nowrap">是否打证：</td>
								<td class="FieldInput">
									<select id="printFlag"> 
										<option value="0" selected="selected">未打证</option>
										<option value="1">已打证</option>
									</select>
								</td>
								<td colspan="2" align="center"><button onclick="query()">查 询</button>
								&nbsp;<button onclick="reset()">重 置</button></td>
						</tr>		

						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="dependantGrid" width="100%" autoScroll="true" stripeRows="true" height="100%" dataset="PassApplyDataset" title="评残调残人员打证" >
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>print()
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="打证" iconCls="print" handler="print1"/>
				</next:TopBar>
			
				<next:Columns>
				    <next:RowNumberColumn header="序号" width="45"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    		
					<next:Column id="full_name" header="属地行政区划" field="FULL_NAME" width="220" >
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="name" header="姓名" field="NAME" width="60">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="140">
						<next:TextField allowBlank="false" />
					</next:Column>
				
					<next:Column id="sex" header="性别" field="SEX" width="35"  dataset="SexDataset" >
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="nation" header="民族" field="NATION" width="60" dataset="NationDataset" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="disability_state_code" header="优抚对象状态" field="DISABILITY_STATE_CODE" width="90" dataset="ObjectStateDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="disability_type_code" header="优抚对象类别" field="DISABILITY_TYPE_CODE" width="110" dataset="ObjectTypeDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					<next:Column id="service_name" header="业务类型" field="SERVICE_NAME" width="80">
						<next:TextField allowBlank="false" />
					</next:Column>
					<next:Column id="reg_time" header="录入时间" field="REG_TIME" width="130" >
						<next:TextField allowBlank="false" />
					</next:Column>
					<next:Column id="print_flag_name" header="是否打证" field="PRINT_FLAG_NAME" width="80">
						<next:TextField allowBlank="false" />
					</next:Column>
					 
				</next:Columns>
				
				<next:BottomBar>
					<next:PagingToolBar dataset="PassApplyDataset"/>
				</next:BottomBar>
				
			</next:GridPanel>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="reguIdentiApp/reguIdentiAppPrintDao"/>
<input type="hidden" id="objectType" name="printQuery" queryData="queryData" value="" />
<input type="hidden" id="ntkoPrintapplyId" queryData="queryData"  value=""/>
<input type="hidden" id="printYear" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="printMonth" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="changeContent" name="printMark" printMark="printMark" value="" />
<input type="hidden"  id="docPath" printMark="printMark" value="" />
<input type="hidden" id="bptQueryPathServiceType" value=""/>
</body>

<script type="text/javascript"> 
	function init() {
		var PassApplyDataset = L5.DatasetMgr.lookup("PassApplyDataset");
		PassApplyDataset.setParameter("printFlag","0");
		PassApplyDataset.load();
		L5.QuickTips.init(); 
	}
	
	
	function query() {
		var idCard = document.getElementById("idCard").value;
		var name = document.getElementById("name").value;
		var serviceType = document.getElementById("serviceType").value;
		var printFlag = document.getElementById("printFlag").value;
		var domicileCode = document.getElementById("domicileCode").value;
		var PassApplyDataset = L5.DatasetMgr.lookup("PassApplyDataset");
		PassApplyDataset.setParameter("idCard",idCard);
		PassApplyDataset.setParameter("name",name);
		PassApplyDataset.setParameter("serviceType",serviceType);
		PassApplyDataset.setParameter("printFlag",printFlag);
		PassApplyDataset.setParameter("domicileCode",domicileCode);
		PassApplyDataset.load();
		L5.QuickTips.init(); 
	}
	
	function detail() {
		var editGridPanel = L5.getCmp("editGridPanel");
		var selects = editGridPanel.getSelectionModel().getSelections();
		if(selects.length!=1){
			L5.Msg.alert('提示',"请选择一条记录修改!");
			return false;
		}
		var record = selects[0];
		var familyId = record.get('FAMILY_ID');
		var peopleId = record.get('PEOPLE_ID');
		var applyId = record.get('APPLY_ID');
		var width = screen.width-100;   
    	var height = screen.height-140;
		var url='assessdisability/disabilityDetailManage.jsp?familyId='+familyId+'&peopleId='+peopleId+'&applyId='+applyId;
		var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		if (win==null) {
			return;
		}
	}
	
	/**
 * 属地行政区划窗口
 */
function forHelp(){
		var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
function replaceAll(s0,s1,s2) { 
    return s0.replace(new RegExp(s1,"gm"),s2); 
}
	// 打证 还是变更 
function print1(){
	var flag ;
	var path ;
	var changeContent;
	var editGridPanel = L5.getCmp("editGridPanel");
	var selects = editGridPanel.getSelectionModel().getSelections();
	if(selects.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var record = selects[0];
	var objectType = selects[0].get('DISABILITY_TYPE_CODE');
	var peopleId = record.get('PEOPLE_ID');
	var getValue = window.showModalDialog('selectLeftOrRightPrint.jsp?type=disability&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
	if(getValue!=""&&getValue!=undefined){
	var list = getValue.split(";");
	flag = list[1];
	changeContent = decodeURI(list[2]);
	if(flag == "0") { //左边栏
		if(objectType == 11){
				
			changeContent=replaceAll(changeContent," ","&nbsp;");
			changeContent=replaceAll(changeContent,"\r\n","<br/>");
			changeContent=replaceAll(changeContent,"\n","<br/>");
			changeContent = escape(encodeURIComponent(changeContent));
			var url="../../disabilityRenewal/disabilityInfoWrite.jsp?renewalFlag=no&peopleId="+peopleId+"&changeContent="+changeContent;
			var width = 1024;
			var height = 768;
		    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		}else{
			path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc";
			change(path,changeContent);
		}
		
	} else  if(flag == "1") { //右边栏
		path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disright.doc";
		change(path,changeContent);
	} else if (flag == "3") {
		print();
	}
	}
}
function change(path,changeContent) {
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10)
		{month="0"+month;}
	document.getElementById("docPath").value = path;
	document.getElementById("printYear").value = year;
	document.getElementById("printMonth").value = month;
	document.getElementById("changeContent").value = changeContent ;
	
	var url="../../../comm/print/print_noDataSet.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
function print() {
	var url="../../../comm/print/jspcommonprint.jsp?";
	var editGridPanel = L5.getCmp("editGridPanel");
	var selects = editGridPanel.getSelectionModel().getSelections();
	if(selects.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var record = selects[0];
	var peopleId = record.get('PEOPLE_ID');
	var objectType = record.get('DISABILITY_TYPE_CODE');
	var docpath;
	if(objectType == 11){//残疾军人
		url="../../disabilityRenewal/disabilityInfoWrite.jsp?renewalFlag=no&peopleId="+peopleId;
		//docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
	} else if(objectType == 12){//伤残国家机关工作人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityGZ_apptable.doc";
	} else if(objectType == 13){//伤残人民警察
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJC_apptable.doc";
	} else if(objectType == 14){//伤残民兵民工
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
	} else if(objectType == 15){//因战因公伤残人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityZG_apptable.doc";
	}
	document.getElementById("objectType").value = objectType;
	document.getElementById("docpath").value = docpath;
	document.getElementById("peopleId").value = peopleId;
	document.getElementById("ntkoPrintapplyId").value = record.get('APPLY_ID');
	document.getElementById("bptQueryPathServiceType").value=objectType;
	
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}
	
</script>
</html>
