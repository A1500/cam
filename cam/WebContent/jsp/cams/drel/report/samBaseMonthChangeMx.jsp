<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>低保户基本变动情况</title>
		<next:ScriptManager />
		<script type="text/javascript" src="samBaseMonthChangeMx.js"></script>
		<script type="text/javascript" src="../comm/samInfoDetailComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
		<script type="text/javascript">
		  var startmonth='<%=request.getParameter("startMonth")%>';
		    var endmonth='<%=request.getParameter("endMonth")%>';
	         var assistanceType = '<%=request.getParameter("assistanceType") %>';
		    var organCode='<%=request.getParameter("organCode")%>';
		    var changeItem='<%=request.getParameter("changeItem")%>';
		</script>
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
		<!-- 基础信息_家庭信息 -->
			<model:dataset id="baseinfoFamilyDS"
				cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd"
				method="queryBaseChange" pageSize="20">
			</model:dataset>
		<!-- 主要致贫原因 -->
			<model:dataset id="provertyCause" enumName="SAM_CITY_PROVERTY_CAUSE"
				autoLoad="true" global="true"></model:dataset>
		<!-- 属别 -->
		<model:dataset id="belongingDataSet" enumName="SAM_BELONGING" autoLoad="true" global="true">
		</model:dataset>
	</model:datasets>
		<next:GridPanel id="infoQueryGrid" name="baseinfoFamilyResource"
			stripeRows="true" height="100%" width="100%" dataset="baseinfoFamilyDS" clickToSelectedForChkSM="true">
			<next:TopBar>
				<next:ToolBarItem id="qrToolbar" text="低保、五保基本情况变动查询信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="导出CSV" iconCls="chart"
					handler="exportExcel"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
	    		<next:RowNumberColumn width="30"/>
	    		<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column header="地区" field="DOMICILE_NAME" width="200"
					align="center">
					<next:TextField />
				</next:Column>
				<next:Column header="户主姓名" field="FAMILY_NAME" width="80"
					align="center" >
					<next:TextField />
				</next:Column>
				<next:Column header="身份证号" field="FAMILY_CARD_NO" width="135"
					align="center">
					<next:TextField />
				</next:Column>
				<next:Column header="低保证号" field="CARD_NO" width="130" align="center">
					<next:TextField />
				</next:Column>
				<next:Column header="主要致贫原因" field="POVERTY_CAUSE" width="100"
					align="right" dataset="provertyCause">
					<next:TextField />
				</next:Column>
				<next:Column header="家庭人口数" field="PEOPLE_NUM" width="90"
					align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="保障人口数" field="ASSISTANCE_PEOPLE_NUM" width="90"
					align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="保障金额（元）" field="ASSISTANCE_MONEY" width="100"
					align="right" renderer="formatNum">
					<next:TextField />
				</next:Column>
				<next:Column header="属别" field="BELONGING" dataset="belongingDataSet" width="100" align="center">
					<next:TextField />
				</next:Column>
				<next:Column header="起始保障年月" field="BEGIN_DATE" width="100"
					align="center">
					<next:TextField />
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="baseinfoFamilyDS" />
			</next:BottomBar>
		</next:GridPanel>		
	</body>
</html>