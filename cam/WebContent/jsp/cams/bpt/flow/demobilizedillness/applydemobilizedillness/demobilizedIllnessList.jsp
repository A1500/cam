<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var struId = '<%=BspUtil.getStruId()%>';
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head>
		<title>带病回乡退伍军人信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="demobilizedIllnessList.js"></script>
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
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedIllnessQueryCommand"  method="queryApplyDemobilizedIllnessPeople" global="true" pageSize="8">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
    <!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否参战 -->
	<model:dataset id="dsIsWar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否涉核 -->
	<model:dataset id="dsIsInnuclear" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" clickToSelectedForChkSM="true" width="100%" stripeRows="true" height="98%" dataset="BaseinfoPeopleDataSet">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="delete" handler="del"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="view" id="submitButton" text="提交" handler="createAndSend"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="view" id="bthSmtBtn" text="批量提交" handler="batchSend"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="编号" width="50"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="familyId" header="familyId" field="FAMILY_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="applyId" header="applyId" field="APPLY_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column id="peopleId" header="peopleId" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="name" header="属地行政区划" field="DOMICILE_NAME" width="220">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="140" >
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column id="sex" header="性别" field="SEX" width="35"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column id="nation" header="民族" field="NATION" width="60" dataset="NationDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="domicileType" header="户籍类别" field="DOMICILE_TYPE" width="60" dataset="DomicileDataset" >
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="是否参战" field="IS_WAR" width="60" dataset="dsIsWar">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="是否参试" field="IS_INNUCLEAR" width="60" dataset="dsIsInnuclear">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="入伍时间" field="CONSCRIPT_DATE" width="90">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="退伍时间" field="DECRUITMENT_DATE" width="90">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="手机" field="TEL_MOBILE" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="NOTE" header="备注" field="NOTE" width="90">
						<next:TextField  />
					</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
