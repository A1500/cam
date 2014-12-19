<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>审批信息查看</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			
		</script>
<script type="text/javascript" src="applyInfo.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryApplyInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		   <model:field name="applyId" type="string"/>
		   <model:field name="serviceType" type="string"/>
		   <model:field name="approveDate" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 优抚对象申请类型 -->
	<!-- 民族 -->
	<model:dataset id="applyType"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>
<next:Panel title="申请审批信息"  height="100%">
   <next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" dataset="BaseinfoPeopleDataSet" height="25%">
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    <next:Column id="applyId" header="applyId" field="APPLYID" width="120" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="name" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="serviceType" header="审批类型" field="SERVICETYPE" dataset="applyType" width="150" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="approveDate" header="批准日期" field="APPROVEDATE"  width="150" >
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
</next:GridPanel>
<next:Panel   height="100%" id="applyPanel">
   <next:Html>
    <iframe id="peopleInfo" src=""
		frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	</iframe>
   
   </next:Html>
</next:Panel>

</next:Panel>
			
</body>
</html>
