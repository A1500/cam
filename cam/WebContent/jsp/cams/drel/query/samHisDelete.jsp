<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>

<title>人员数据删除功能</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	function init(){
		baseinfoPeopleDataSet.on('load',function (){
			if(baseinfoPeopleDataSet.getCount() >= 1){
				
				familyDataSet.setParameter("family_id",baseinfoPeopleDataSet.get("familyId"));
				familyDataSet.load();
			}
		});
		familyDataSet.on('load',function (){
			if(familyDataSet.getCount() >= 1){
				
				treatmentDataSet.setParameter("family_id",familyDataSet.get("familyId"));
				treatmentDataSet.setParameter("end_date","3000-12");
				treatmentDataSet.load();
			}
		});
		treatmentDataSet.on('load',function (){
			baseinfoPeopleDataSet1.setParameter("family_id",baseinfoPeopleDataSet.get("familyId"));
			baseinfoPeopleDataSet1.load();
		});
		
		
	}
	//查询
	function query(){
		<!-- 370102196812082128 -->
		var idCard=_$("familyCardNo");
		var familyName=_$("familyName");
		if(idCard == '' && familyName == '' ){
			L5.Msg.alert('提示',"查询条件不能同时为空！");
			return;
		}
		baseinfoPeopleDataSet.setParameter("id_Card",idCard);
		baseinfoPeopleDataSet.setParameter("name",familyName);
		baseinfoPeopleDataSet.load();
		
		
	}
	function deleteApply(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
				if(sta=="yes"){
					if(treatmentDataSet.getCount() > 0 ){
						L5.Msg.alert("提示","待遇表里有数据，正在享受低保！");
						return ;
					}
					var command = new L5.Command("com.inspur.cams.drel.his.city.cmd.SamCityHisCmd");
					command.setParameter("peopleId",records[0].get('peopleId') );
					command.setParameter("familyId",records[0].get('familyId') );
					command.execute("deleteHisPeople");
					if (!command.error) {
						L5.Msg.alert("提示","删除成功！",function(){
							query();
						});			
					}else{
							L5.Msg.alert('提示',"删除时出现错误！"+command.error);
					}
				}else{
					return;
				}
			});
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	
	}
function assistanceTypevalue(value,cellmeta,record,rowindex,colindex,dataset){
	var assistanceType = record.get("assistanceType");
	if(assistanceType=='01'){
		return '城市低保';
	}else if(assistanceType=='02'){
		return '农村低保';
	}else if(assistanceType=='03'){
		return '农村五保';
	}
}
function dataSourcevalue(value,cellmeta,record,rowindex,colindex,dataset){
	var dataSource = record.get("dataSource");
	if(dataSource=='saas'){
		return '太极系统导入';
	}else if(assistanceType=='apply'){
		return '业务流程生成';
	}else if(assistanceType=='his'){
		return '历史数据增加';
	}
}	
</script>
</head>
<body>
<model:datasets>
	<!-- 家庭成员基本信息 -->
	<model:dataset id="baseinfoPeopleDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭成员基本信息 -->
	<model:dataset id="baseinfoPeopleDataSet1" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 人员状态 -->
	<model:dataset id="samPersonalStatsDataSet" enumName="SAM_PERSONAL_STATS_TAG" autoLoad="true" global="true"></model:dataset>
	<!-- 家庭基本信息 -->
	<model:dataset id="treatmentDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyTreatmentQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyTreatment"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true">
	<next:Panel title="数据查询" width="100%" autoHeight="true" titleCollapse="true" >	
		<next:Html>			
				<form class="L5form">
					<table  border="1" width="100%">
						<tr>
						 	<td class="FieldLabel" style="width:10%">姓名</td>
			                <td class="FieldInput" style="width:10%"><input type="text"  id="familyName" style='width:80%'/></td>
			                <td class="FieldLabel" style="width:10%">身份证号码</td>
			                <td class="FieldInput" style="width:10%"><input type="text" id="familyCardNo" style="width:79%"  onchange="checkIDCard(this)"/></td>
			                 <td class="FieldButton" style="width:10%"><button style="width:100" id="queryId" onclick="query();">查询</button></td>
						</tr>
					</table>
				</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel  id="daiBanGridPanel" title="人员列表" dataset="baseinfoPeopleDataSet" width="100%" height="100" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>	
			<next:ToolBarItem iconCls="remove" id="peopleDS" text="删除" handler="deleteApply"/>
		</next:TopBar>
		<next:Columns>
  				<next:RowNumberColumn/>
   			<next:RadioBoxColumn></next:RadioBoxColumn>
   			<next:Column  header="家庭主键" field="familyId"  width="300"  >
   				<next:TextField editable="true"/> 
   			</next:Column>	
			<next:Column  header="社区（村）" field="domicileName"  width="100"  ></next:Column>							
	        <next:Column header="姓名" field="name" width="70" ></next:Column>
        	<next:Column header="身份证号码" field="idCard" width="150" ></next:Column>
        	<next:Column header="人员状态" field="personalStatsTag" width="150" dataset='samPersonalStatsDataSet'></next:Column>
		</next:Columns>
	</next:EditGridPanel >
	
	<next:EditGridPanel  title="家庭列表" dataset="familyDataSet" width="100%" height="100" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>	
		</next:TopBar>
		<next:Columns>
  				<next:RowNumberColumn/>
   			<next:RadioBoxColumn></next:RadioBoxColumn>
   			<next:Column  header="家庭主键" field="familyId"  width="300"  >
   			</next:Column>	
			<next:Column  header="社区（村）" field="domicileName"  width="100"  ></next:Column>							
	        <next:Column header="户主姓名" field="familyName" width="70" ></next:Column>
        	<next:Column header="身份证号码" field="familyCardNo" width="150" ></next:Column>
		</next:Columns>
	</next:EditGridPanel >
	
	<next:EditGridPanel  title="家庭人员列表" dataset="baseinfoPeopleDataSet1" width="100%" height="150" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>	
		</next:TopBar>
		<next:Columns>
  				<next:RowNumberColumn/>
   			<next:RadioBoxColumn></next:RadioBoxColumn>
   			<next:Column  header="家庭主键" field="familyId"  width="300"  >
   				<next:TextField editable="true"/> 
   			</next:Column>	
			<next:Column  header="社区（村）" field="domicileName"  width="100"  ></next:Column>							
	        <next:Column header="姓名" field="name" width="70" ></next:Column>
        	<next:Column header="身份证号码" field="idCard" width="150" ></next:Column>
        	<next:Column header="人员状态" field="personalStatsTag" width="150" dataset='samPersonalStatsDataSet'></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="baseinfoPeopleDataSet1" />
		</next:BottomBar>
	</next:EditGridPanel >
	
		<next:EditGridPanel  title="待遇列表" dataset="treatmentDataSet" width="100%" height="100" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>	
		</next:TopBar>
		<next:Columns>
  				<next:RowNumberColumn/>
   			<next:RadioBoxColumn></next:RadioBoxColumn>
   			<next:Column  header="待遇类别" field="assistanceType"  width="150"  renderer="assistanceTypevalue">
   			</next:Column>	
			<next:Column  header="开始日期" field="beginDate"  width="100"  ></next:Column>							
	        <next:Column header="结束日期" field="endDate" width="70" ></next:Column>
        	<next:Column header="数据来源" field="dataSource" width="150" renderer="dataSourcevalue"></next:Column>
		</next:Columns>
	</next:EditGridPanel >
</next:Panel>
</body>
</html>