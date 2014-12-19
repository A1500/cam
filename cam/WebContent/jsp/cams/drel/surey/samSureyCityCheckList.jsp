<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>低保低收入家庭信息核对列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="samSureyCityCheckList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
     var organId='<%=BspUtil.getCorpOrganId()%>';
     var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
     var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
     var userId='<%=BspUtil.getEmpOrgan().getOrganId()%>';
     var userName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
     
	     //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){	
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';	
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";				
			element.expand =true;
		}
	}
</script>
</head>
	
<body>
<model:datasets>
	<!-- 已办 -->
	<model:dataset id="SamSureyWfDS" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfQueryCmd" method="initialQuery">
      <model:record fromBean="com.inspur.cams.drel.surey.comm.data.SamSureyWf">
      </model:record>
	</model:dataset>
	<model:dataset id="SamSureyWfHisDS" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfHisQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.surey.comm.data.SamSureyWfHis">
		</model:record>
	</model:dataset>
	<model:dataset id="SamSureyWfAssistanceHisDS" cmd="com.inspur.cams.drel.surey.assistance.cmd.SamSureyWfAssitanceHisQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.surey.assistance.data.SamSureyWfAssistanceHis">
		</model:record>
	</model:dataset>
	<model:dataset id="assistanceTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>	
</model:datasets>
<next:ViewPort>							
				<next:GridPanel id="surey_done_grid" name="surey_done_grid"   dataset="SamSureyWfDS" title="经办任务列表" stripeRows="true" autoScroll="true" collapsible="true"  width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem text="移交" iconCls="edit"  handler="transfer"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
					     <next:RowNumberColumn width="20"/>
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column id="applyTitle" header="申请核对名称" field="applyTitle" width="20%" >
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="name" header="申请人姓名" field="name" width="10%">
							<next:TextField />
						</next:Column>
						<next:Column id="idCard" header="身份证号码" field="idCard" width="20%">
							<next:TextField />
						</next:Column>
						<next:Column id="assistanceType" header="核对项目" field="assistanceType" dataset="assistanceTypeDS" width="10%" >
							<next:TextField />
						</next:Column>
						<next:Column id="preActivityOrganName" header="上一环节单位" field="preActivityOrganName"  width="15%" >
							<next:TextField />
						</next:Column>
						<next:Column id="nextActivityOrganName" header="下一环节单位" field="nextActivityOrganName"  width="15%" >
							<next:TextField />
						</next:Column>
						<next:Column id="curActivitySt" header="接收时间" field="curActivitySt" width="20%" >
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
							<next:PagingToolBar dataset="SamSureyWfDS"  />
					</next:BottomBar>
				</next:GridPanel>							
</next:ViewPort>
</html>