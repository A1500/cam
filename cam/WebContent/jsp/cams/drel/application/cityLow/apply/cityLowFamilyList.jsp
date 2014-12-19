<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>

<title>城市低收入列表查询(按家庭信息)</title>
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
	var minAveIncome=getParam("minAveIncome");
	var maxAvgIncome=getParam("maxAvgIncome");
	
	if(parseInt(minAveIncome)>parseInt(maxAvgIncome)){
		L5.Msg.alert('提示',"年人均可支配收入区间最小值应小于年人均可支配收入区间最大值!");
		return false;
	}
	
	var ds=  L5.DatasetMgr.lookup("familyDataSet");
	ds.setParameter("FAMILY_NAME@=",getParam("familyName"));		
	ds.setParameter("APANAGE_CODE@rlike",getCode(getParam("apanageCode")));
			
	ds.setParameter("ADDRESS@like",getParam("juzhudi"));		
	ds.setParameter("PEOPLE_NUM",getParam("peopleNum"));		
	ds.setParameter("YEAR_AVERAGE_INCOME@>=",minAveIncome);		
	ds.setParameter("YEAR_AVERAGE_INCOME@<=",maxAvgIncome);
	ds.setParameter("ASSISTANCE_TYPE@=","D2");	
	ds.load();
}
function getCode(code){
	if(code==undefined){
		return code;
	}
	else{
		var leve=getParam("apanageleve");
		if(leve==0){
			code=code.substr(0,2);
		}
		if(leve==1){
			code=code.substr(0,4);
		}
		if(leve==2){
			code=code.substr(0,6);
		}
		if(leve==3){
			code=code.substr(0,9);
		}
		return code;
	}
}
function newApply(){
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='/jsp/cams/drel/application/cityLow/apply/cityLowfamilyConfirm.jsp';
	var text = '新增城市低收入家庭信息';
	L5.forward(url,text,data);
	
}
function editApply(){
	var editGrid=L5.getCmp('daiBanGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("familyId",selected[0].get('familyId'));
	var url='/jsp/cams/drel/application/cityLow/apply/cityLowfamilyConfirm.jsp';
	var text = '修改城市低收入家庭信息';
	L5.forward(url,text,data);
}
function delApply(){
	var editGrid=L5.getCmp('daiBanGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("familyId");
			}
			var command=new L5.Command("com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmCmd");
			command.setParameter("delIds", delIds);
			command.execute("batchDelete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	familyDataSet.remove(selected[i]);
				}
				familyDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
function showApply(){

	var editGrid=L5.getCmp('daiBanGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("familyId",selected[0].get('familyId'));
	var url='/jsp/cams/drel/application/cityLow/apply/cityLowfamilyConfirmDetail.jsp';
	var text = '城市低收入家庭信息明细';
	L5.forward(url,text,data);
}
function gotoPeople(){
	var data = new L5.Map();
	
	var url='/jsp/cams/drel/application/cityLow/apply/cityLowFamilyListByPeople.jsp';
	var text = '城市低收入列表查询(按家庭成员)';
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
			document.getElementById("apanageleve").value = list[2];
			//document.getElementById("juzhudi").value = list[4];
			
		}
	}

	
</script>
</head>
<body>

<model:datasets>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
		</model:record>
	</model:dataset>
</model:datasets>
			<next:Panel width="100%" height="100%">
				<next:Panel title="低收入家庭查询" width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html>			
							<form class="L5form">
								<table  border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">户主姓名</td>
						                <td class="FieldInput" style="width:10%"><input type="text"  id="familyName" style='width:80%' maxlength="30"/></td>
						                <td class="FieldLabel" style="width:10%">户口所在地</td>
						                <td class="FieldInput" style="width:10%">
						               	<input type="text" readonly title="户口所在地" name="apanageName" id="apanageName"  />
										<input type="text" style="display: none;"  name="apanageCode" id="apanageCode"  />
										<input type="text" style="display: none;"  name="apanageleve" id="apanageleve"  />
										<img src=" <%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
										</td>
						                <td class="FieldLabel" style="width:10%">现居住地</td>
						                <td class="FieldInput" style="width:10%">
						               <input type="text" id="juzhudi" name="juzhudi" title="现居住地" style="width: 80%"  /></td>
						            	
						             </tr><tr> 
						               <td class="FieldLabel" style="width:10%">家庭人口数</td>
						                <td class="FieldInput" style="width:10%">
						                <input type="text"  id="peopleNum" style='width:80%' maxlength="2"
						                 onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"/></td>
						                 <td class="FieldLabel" style="width:10%">年人均可支配收入区间</td>
						                <td class="FieldInput" style="width:10%" colspan="2">
						                <input type="text"  id="minAveIncome" title="年人均可支配收入区间最小值"
						                onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"/>
						              ~<input type="text"  id="maxAvgIncome" title="年人均可支配收入区间最大值"
						              onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"/></td>
						                
						                 <td class="FieldButton" style="width:10%">
						                  <button style="width:100" id="queryId" onclick="query();">查询</button>
						                  <button type="reset" style="width:100">重置</button>
						                 </td>
									</tr>
								</table>
							</form>
					</next:Html>
				</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true" id="daiBanGridPanel" title="低收入家庭列表" dataset="familyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						
						<next:ToolBarItem iconCls="detail"  text="明细" handler="showApply"/>	
						<next:ToolBarItem iconCls="undo"  text="按家庭成员查询" handler="gotoPeople"/>
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:CheckBoxColumn></next:CheckBoxColumn>
				        <next:Column header="户主姓名" field="familyName" width="120" ></next:Column>
				        <next:Column header="身份证号" field="familyCardNo" width="150" ></next:Column>
				        <next:Column header="户口所在地" field="apanageName" width="120" ></next:Column>
				        <next:Column header="现居住地址" field="address" width="250" ></next:Column>
				        <next:Column header="年人均可支配收入（元）" field="yearAverageIncome" width="150" ></next:Column>
				        <next:Column header="家庭人口数" field="peopleNum" width="80" ></next:Column>
				        <next:Column header="住房面积" field="buildArea" width="120" ></next:Column>				        
				        <next:Column header="联系电话" field="familyMobile" width="120" ></next:Column>
				       
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="familyDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>

</body>
<script type="text/javascript">
	function init(){
		document.getElementById("apanageName").value=organName;
		document.getElementById("apanageCode").value=organCode;
		document.getElementById("apanageleve").value="0";	
	}
</script>

</html>