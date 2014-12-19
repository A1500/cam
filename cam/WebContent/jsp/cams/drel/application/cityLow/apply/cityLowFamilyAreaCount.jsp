<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>

<title>城市低收入区域户数统计</title>
<next:ScriptManager></next:ScriptManager>

<script type="text/javascript">

	<%
	    String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
	    %>
	    var organCode="<%=BspUtil.getCorpOrgan().getOrganCode()%>";
		var organArea='<%=organArea%>';
		var organName='<%=organName%>';
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var startTime=getParam("startTime");
	var endTime=getParam("endTime");
	
	if(startTime>endTime){
		L5.Msg.alert('提示',"查询起始时间应小于结束时间!");
		document.getElementById("startTime").value.focus();
		return false;
	}
	
	var ds=  L5.DatasetMgr.lookup("lowFamilyNoCountDataSet");
	ds.setParameter("apanageCode",getParam("apanageCode"));		
	ds.setParameter("apanagelevel", getParam("apanagelevel"));
	ds.setParameter("startTime",startTime);		
	ds.setParameter("endTime",endTime);
	ds.load();
}

function gotoPeople(){
	var data = new L5.Map();
	
	var url='/jsp/cams/drel/application/cityLow/apply/cityLowFamilyWealthCount.jsp';
	var text = '城市低收入区域家庭平均收入和资产统计';
	L5.forward(url,text,data);
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
			document.getElementById("apanageName").value = list[1];
			document.getElementById("apanageCode").value = list[0];
			document.getElementById("apanagelevel").value = list[2];//leve
			//document.getElementById("juzhudi").value = list[4];
			
		}
}
</script>
</head>
<body>

<model:datasets>
	<!-- 家庭基本信息 -->
	<model:dataset id="lowFamilyNoCountDataSet" cmd="com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmQueryCmd" pageSize="10" global="true" method="lowFamilyNoCount">
		<model:record >
			<model:field name="apanageName" mapping="APANAGE"/>
			<model:field name="familyNo" mapping="FAMILYCOUNT"/>
		</model:record>
	</model:dataset>
</model:datasets>
			<next:Panel width="100%" height="100%">
				<next:Panel title="低收入家庭查询" width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html>			
							<form class="L5form">
								<table  border="1" width="100%">
								<tr> 
						               <td class="FieldLabel" >户口所在地</td>
						               <td class="FieldInput">
						              	<input type="text" readonly title="户口所在地" name="apanageName" id="apanageName" field="apanageName" />
										<input type="text" style="display: none;"  name="apanageCode" id="apanageCode" field="apanageCode" />
										<input type="text" style="display: none;"  name="apanagelevel" id="apanagelevel"  />
										<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
						                <td class="FieldLabel" >申请时间区域</td>
						                <td class="FieldInput" >
						                <input type="text"  id="startTime" title="申请起始时间" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
						              ~<input type="text"  id="endTime" title="申请结束时间"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>
						                
						                 <td class="FieldButton" style="width:10%">
						                  <button style="width:100" id="queryId" onclick="query();">查询</button>
						                  <button type="reset" style="width:100">重置</button>
						                 </td>
									</tr>
								</table>
							</form>
					</next:Html>
				</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true" id="daiBanGridPanel" title="低收入家庭列表" dataset="lowFamilyNoCountDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						
						<next:ToolBarItem iconCls="undo"  text="家庭财产查询" handler="gotoPeople"/>
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:CheckBoxColumn></next:CheckBoxColumn>
				        <next:Column header="行政区划" field="apanageName" width="150" ></next:Column>
				        <next:Column header="低收入家庭户数" field="familyNo" width="150" ></next:Column>				       
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="lowFamilyNoCountDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>

</body>
<script type="text/javascript">
function init(){
	
	document.getElementById("apanageName").value=organName;
	document.getElementById("apanageCode").value=organCode;
	document.getElementById("apanagelevel").value="0";
	var ds=  L5.DatasetMgr.lookup("lowFamilyNoCountDataSet");
	ds.setParameter("apanageCode",getParam("apanageCode"));		
	ds.setParameter("apanagelevel", getParam("apanagelevel"));
	ds.setParameter("startTime","0000-00-00");
	ds.setParameter("endTime","9999-99-99");
	ds.load();
}
</script>
</html>

