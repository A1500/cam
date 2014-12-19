<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>婚姻登记机关名册</title>
<next:ScriptManager />
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
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
		<script type="text/javascript" src="RegistrationDeptQueryList.js">
		 var organName= decodeURIComponent('<%=request.getParameter("organName")%>');
		</script>
</head>
<body>
<model:datasets>
	<!--	婚姻登记机关信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.query.papers.cmd.RegistrationDeptQueryCmd" pageSize="20"
		method="query" global="true" autoLoad="false">
		<model:record>
			<model:field name="DEPTNAME"/>
			<model:field name="ADDRESS"/>
			<model:field name="DEPTPOST"/>
			<model:field name="DEPTTEL"/>
			<model:field name="MODIFY_ID"/>
			<model:field name="COMPLAIN_TEL"/>
			<model:field name="OFFICE_EMAIL"/>
			<model:field name="TYPES"/>
			<model:field name="DEPT_CODE"/>
			<model:field name="SSLEVEL"/>
			<model:field name="CREAT_DATE"/>
			<model:field name="DEPT_NUM_RY"/>
			<model:field name="DEPT_NUM_RDBZ"/>
			<model:field name="DEPT_NUM_SJ"/>
			<model:field name="TOTALAREA"/>
			<model:field name="HDAREA"/>
			<model:field name="JHAREA"/>
			<model:field name="LHAREA"/>
			<model:field name="BZAREA"/>
			<model:field name="ZXFDAREA"/>
			<model:field name="DASAREA"/>
			<model:field name="ZRSAREA"/>
			<model:field name="QTAREA"/>
			<model:field name="TOTALWIN"/>
			<model:field name="JHWIN"/>
			<model:field name="LHWIN"/>
			<model:field name="TOTALCOM"/>
			<model:field name="JHCOM"/>
			<model:field name="LHCOM"/>
			<model:field name="TOTALCHAIR"/>
			<model:field name="DHCHAIR"/>
			<model:field name="TBCHAIR"/>
			<model:field name="BZCHAIR"/>
			<model:field name="REGION_CODE"/>
			<model:field name="REGION_NAME"/>
			<model:field name="ORGAN_ID"/>
			<model:field name="SKIN_VALUE"/>
		</model:record>
	</model:dataset>
	<model:dataset id="excelDs"
		cmd="com.inspur.cams.marry.query.papers.cmd.RegistrationDeptQueryCmd" pageSize="20"
		method="query" global="true" autoLoad="false">
		<model:record>
			<model:field name="DEPTNAME"/>
			<model:field name="ADDRESS"/>
			<model:field name="DEPTPOST"/>
			<model:field name="DEPTTEL"/>
			<model:field name="MODIFY_ID"/>
			<model:field name="COMPLAIN_TEL"/>
			<model:field name="OFFICE_EMAIL"/>
			<model:field name="DEPT_CODE"/>
			<model:field name="SSLEVEL"/>
			<model:field name="TYPES"/>
			<model:field name="CREAT_DATE"/>
			<model:field name="DEPT_NUM_RY"/>
			<model:field name="DEPT_NUM_RDBZ"/>
			<model:field name="DEPT_NUM_SJ"/>
			<model:field name="TOTALAREA"/>
			<model:field name="HDAREA"/>
			<model:field name="JHAREA"/>
			<model:field name="LHAREA"/>
			<model:field name="BZAREA"/>
			<model:field name="ZXFDAREA"/>
			<model:field name="DASAREA"/>
			<model:field name="ZRSAREA"/>
			<model:field name="QTAREA"/>
			<model:field name="TOTALWIN"/>
			<model:field name="JHWIN"/>
			<model:field name="LHWIN"/>
			<model:field name="TOTALCOM"/>
			<model:field name="JHCOM"/>
			<model:field name="LHCOM"/>
			<model:field name="TOTALCHAIR"/>
			<model:field name="DHCHAIR"/>
			<model:field name="TBCHAIR"/>
			<model:field name="BZCHAIR"/>
			<model:field name="REGION_CODE"/>
			<model:field name="REGION_NAME"/>
			<model:field name="ORGAN_ID"/>
			<model:field name="SKIN_VALUE"/>
		</model:record>
		<model:params>
			<model:param name="flag" value='all'/>
		</model:params>
	</model:dataset>
	<!-- 编制性质 -->
	<model:dataset id="bztypesDs" enumName="MRM.FORMATION.NATURE"
		autoLoad="true"></model:dataset>
	<model:dataset id="sslevelDs" enumName="MRM.LEVEL.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	<model:dataset id="EvaluLevelDataset" enumName="MRM.EVALULEVEL.TYPE" autoLoad="true" global="true" pageSize="-1"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel name="form" width="100%" border="0" 
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 99%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" nowrap>所属民政部门:</td>
					<td class="FieldInput" ><input type="text" id="deptName" onclick="func_ForDomicileSelect()" name="" style="text-align: right;" />
					<input type="hidden" id = "deptId"	/></td>
					<td class="FieldLabel" style="text-align:center;">
					<button onclick="query()">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="initTime()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
<next:GridPanel id="editGridPanel" name="mrmregisorganinfoGrid"
	width="100%"   height="100%" dataset="ds">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="chart"  text="导出" handler="emport"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column  header="名称" field="DEPTNAME"
			width="200" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="登记机关代码" field="DEPT_CODE"
			width="100" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="地址" field="ADDRESS"
			width="200" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="邮编" field="DEPTPOST"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="服务电话" field="DEPTTEL"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="负责人" field="MODIFY_ID"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="手机" field="COMPLAIN_TEL"
			width="100" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="电子邮件" field="OFFICE_EMAIL"
			width="200" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="编制性质" field="TYPES" dataset="bztypesDs"
			width="100" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="级别" field="SSLEVEL" dataset="sslevelDs"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="成立时间" field="CREAT_DATE" 
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="辖区人口" field="DEPT_NUM_RY" align="right"
			width="80" sortable="false"> 
			<next:TextField />
		</next:Column>
		<next:Column  header="拟定编制人数" field="DEPT_NUM_RDBZ" align="right"
			width="80" sortable="false"> 
			<next:TextField />
		</next:Column>
		<next:Column  header="实有人数" field="DEPT_NUM_SJ" align="right"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="合计" field="TOTALAREA" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="候登区" field="HDAREA" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="结婚登记区" field="JHAREA" align="right"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="离婚登记区" field="LHAREA" align="right"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="颁证区" field="BZAREA" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="咨询辅导区" field="ZXFDAREA" align="right"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="档案区" field="DASAREA" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="主任室" field="ZRSAREA" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="其它" field="QTAREA" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="合计" field="TOTALWIN" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="结婚登记" field="JHWIN" align="right"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="离婚登记" field="LHWIN" align="right"
			width="80" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="合计" field="TOTALCOM" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="结婚登记" field="JHCOM" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="离婚登记" field="LHCOM" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="合计" field="TOTALCHAIR" align="right" 
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="等候" field="DHCHAIR" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="填表" field="TBCHAIR" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="颁证" field="BZCHAIR" align="right"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column  header="等级" field="SKIN_VALUE" dataset="EvaluLevelDataset"
			width="60" sortable="false">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
		<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [[{header:'',start:0,colspan:15},{header:'登记机关面积',start:15,colspan:9},{header:'窗口',start:24,colspan:3},
        		{header:'计算机',start:27,colspan:3},{header:'座椅',start:30,colspan:5}]]
    		})
	</next:ExtendConfig>
</next:GridPanel>
</next:ViewPort>
</body>
</html>
