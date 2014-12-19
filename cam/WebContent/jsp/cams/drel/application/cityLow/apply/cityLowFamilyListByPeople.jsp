<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<head>

<title>城市低收入列表查询(按家庭成员)</title>
<next:ScriptManager></next:ScriptManager>

<script type="text/javascript">
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	var ds=  L5.DatasetMgr.lookup("familyDataSet");
	ds.setParameter("PEOPLE_NAME@=",getParam("peopleName"));		
	ds.setParameter("FAMILY_CARD_NO@=",getParam("idCard"));
	ds.setParameter("ASSISTANCE_TYPE@=","D2");	
	ds.load();
}
function newApply(){
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("from","PEOPLE");
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
	data.put("from","PEOPLE");
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
	data.put("from","PEOPLE");
	var url='/jsp/cams/drel/application/cityLow/apply/cityLowfamilyConfirmDetail.jsp';
	var text = '城市低收入家庭信息明细';
	L5.forward(url,text,data);
}
function gotoFamily(){
	var data = new L5.Map();
	
	var url='/jsp/cams/drel/application/cityLow/apply/cityLowFamilyList.jsp';
	var text = '城市低收入列表查询(按家庭信息)';
	L5.forward(url,text,data);
}

	
</script>
</head>
<body>

<model:datasets>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmQueryCmd" global="true" method="lowQuery" >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
		<model:field name="familyId" mapping="FAMILY_ID"/>
		<model:field name="familyName" mapping="FAMILY_NAME"/>
		<model:field name="familyCardNo" mapping="FAMILY_CARD_NO"/>
		<model:field name="apanageName" mapping="APANAGE_NAME"/>
		<model:field name="address" mapping="ADDRESS"/>
		<model:field name="yearAverageIncome" mapping="YEAR_AVERAGE_INCOME"/>
		<model:field name="peopleNum" mapping="PEOPLE_NUM"/>
		<model:field name="buildArea" mapping="BUILD_AREA"/>
		<model:field name="familyMobile" mapping="FAMILY_MOBILE"/>
		
		</model:record>
	</model:dataset>
</model:datasets>
			<next:Panel width="100%" height="100%">
				<next:Panel title="低收入家庭查询" width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html>			
							<form class="L5form">
								<table  border="1" width="100%">
									
									<tr>
									 	<td class="FieldLabel" style="width:10%">家庭成员姓名</td>
						                <td class="FieldInput" style="width:10%"><input type="text"  id="peopleName" style='width:80%' maxlength="30"/></td>						                
						                <td class="FieldLabel" style="width:10%">身份证号码</td>
						                <td class="FieldInput" style="width:10%"><input type="text" id="idCard" style="width:79%" maxlength="18"/></td>
						                 <td class="FieldButton" style="width:10%"><button style="width:100" id="queryId" onclick="query();">查询</button></td>
						                 <td class="FieldButton" style="width:10%"><button type="reset" style="width:100">重置</button></td>
									</tr>
								</table>
							</form>
					</next:Html>
				</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true" id="daiBanGridPanel" title="低收入家庭列表" dataset="familyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						
						<next:ToolBarItem iconCls="detail"  text="明细" handler="showApply"/>	
						<next:ToolBarItem iconCls="undo"  text="按家庭查询" handler="gotoFamily"/>
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

</html>