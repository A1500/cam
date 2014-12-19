<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>农村五保县（区）内变更</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript">
<%
String organArea=BspUtil.getCorpOrgan().getOrganCode();
String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
%>
var organArea='<%=organArea%>';
var organName='<%=organName%>';
var assistanceType="03";
var currentDate="<%=DateUtil.getMonth() %>";
function init(){
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
}
function resetQ(){
	document.getElementById("queryForm").reset();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
}
//办理						
function handle(){
	var grid = L5.getCmp('familyPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = screen.width-100;
	    var height = 500;
	    var treatmentId=records[0].get("TREATMENT_ID");
	    var applyId=records[0].get("APPLY_ID");
	    var beginDate=records[0].get("BEGIN_DATE");
	  	var url="samFiveInChangeInsert.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId+"&hrefFlg="+getCurrent()+"&beginDate="+beginDate;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//查询
function query(){
   var domicileCode=_$("domicileCode");
    if(""==domicileCode){
    	domicileCode=organArea;
    }    
	baseinfoFamilyDS.setParameter("domicileCode",domicileCode);
	baseinfoFamilyDS.setParameter("cardNo",_$("cardNo"));
	baseinfoFamilyDS.setParameter("familyName",_$("familyName"));
	baseinfoFamilyDS.setParameter("familyCardNo",_$("familyCardNo"));
	baseinfoFamilyDS.setParameter("assistanceType",assistanceType);
	baseinfoFamilyDS.setParameter("queryDate","3000-12");
	baseinfoFamilyDS.load();
	noReclick(baseinfoFamilyDS,"queryId");
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
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}
//获得当前日期 2011-05
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	return year+"-"+month;
}
//获取当前时间
function getCurrent(){		
	return (new Date()).getTime();
}
</script>
</head>
<body>

<model:datasets>
	<!-- 基础信息_家庭信息 -->
	<model:dataset id="baseinfoFamilyDS" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" method="querySamFamilyList" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:Panel title="查询条件" width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
		<next:Html>			
				<form class="L5form" id="queryForm">
					<table  border="1" width="100%">
						<tr>
						 	<td class="FieldLabel" style="width:10%">地区</td>
			                <td class="FieldInput" style="width:10%">
			                	<input type="text" readonly id="domicileName" style='width:60%'/>
							  	<input type="text" style="display: none;"  id="domicileCode" />
							  	<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
			               </td>
							<td class="FieldLabel" style="width:10%">低保证号</td>
							<td class="FieldInput" style="width:10%">
								<input id="cardNo" style="width:90%"/>
							</td>
			                <td class="FieldButton" style="width:10%"><button style="width:100" id="queryId" onclick="query();">查询</button></td>
						</tr>
						<tr>
						 	<td class="FieldLabel" style="width:10%">户主姓名</td>
			                <td class="FieldInput" style="width:10%"><input type="text"  id="familyName" style='width:60%' maxlength="30"/></td>
			                <td class="FieldLabel" style="width:10%">身份证号码</td>
			                <td class="FieldInput" style="width:10%"><input type="text" id="familyCardNo" style="width:90%" maxlength="18"/></td>
			                 <td class="FieldButton" style="width:10%"><button onclick="resetQ()" style="width:100">重置</button></td>
						</tr>
					</table>
				</form>
		</next:Html>
	</next:Panel>
	 <next:GridPanel  clickToSelectedForChkSM="true"id="familyPanel" title="农村五保家庭列表" dataset="baseinfoFamilyDS" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>	
			<next:ToolBarItem iconCls="detail"  text="办理" handler="handle"/>
		</next:TopBar>
		<next:Columns>
   			<next:RowNumberColumn></next:RowNumberColumn>
		    <next:RadioBoxColumn></next:RadioBoxColumn>
   			
			<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="200" align="center"></next:Column>							
	        <next:Column header="户主姓名" field="FAMILY_NAME" width="150" align="center"></next:Column>
        	<next:Column header="身份证号码" field="FAMILY_CARD_NO" width="150" align="center"></next:Column>
			<next:Column header="低保证号" field="CARD_NO" width="130" align="center"></next:Column>
			<next:Column header="起始保障年月" field="BEGIN_DATE" width="100" align="center"></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="baseinfoFamilyDS" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
</body>
</html>