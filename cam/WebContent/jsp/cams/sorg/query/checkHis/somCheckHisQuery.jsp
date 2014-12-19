<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
function init(){
	L5.getCmp("organGrid").on("rowclick",function(){
		var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
		var record = somOrganDataset.getCurrent();
		var checkDs=L5.DatasetMgr.lookup("checkDs");
		if(record.get("sorgCode")==""){
			return;
		}
		checkDs.setParameter("SORG_CODE",record.get("sorgCode"));
		checkDs.setParameter("SORG_TYPE",record.get("sorgType"));
		checkDs.load();
	});
}
function query(){
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	somOrganDataset.setParameter("IF_BRANCH","0");
	somOrganDataset.setParameter("SORG_STATUS@IN","22,31,32,52");
	somOrganDataset.setParameter("CN_NAME@like",_$("sorgName"));
	somOrganDataset.setParameter("SORG_CODE",_$("sorgCode"));
	somOrganDataset.setParameter("SORG_TYPE",_$("sorgType"));
	somOrganDataset.setParameter("LEGAL_PEOPLE@like",_$("legalPeople"));
	somOrganDataset.load();
}
var sorgType='';
var sorgCode='';
function getIfCheck(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get("taskCode")==""){
		return "<label style='color:red'>"+'否'+"</label>";
	}else{
		return "<label>"+'是'+"</label>";
	}
}
</script>
</head> 
<body>
<model:datasets>
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>	
	<model:dataset id="checkDs" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" method='queryCheckHis' sortField="batchYear">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel >
	<next:Panel >
		<next:Html>
			<form class="L5form">
			<fieldset><legend>查询条件</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>社会组织名称：</label></td>
					<td class="FieldInput" style="width:20%"><input style='width:90%'  type="text" id="sorgName"/></td>
					<td class="FieldLabel" style="width:20%"><label>登记证号：</label></td>
					<td class="FieldInput" style="width:20%"><input style='width:90%'  type="text" id="sorgCode" /></td>
					<td class="FieldButton" style="width:20%">
						<button onclick="query()">查询</button>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%"><label>社会组织种类：</label></td>
					<td class="FieldInput" style="width:17%"><select style='width:90%' id="sorgType"><option dataset="sorgTypeSelect"></option></select></td>
					<td class="FieldLabel"><label>法定代表人：</label></td>
					<td class="FieldInput"><input style='width:90%'  type="text" id="legalPeople" /></td>
					<td class="FieldButton"  >
						<button type="reset">重置</button>
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	
	<next:EditGridPanel title="社会组织列表" id="organGrid" dataset="somOrganDataset" height="200" notSelectFirstRow="true">
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="社会组织种类" field="sorgType" sortable="true" dataset="sorgTypeSelect" width="10%" editable="false"><next:TextField /></next:Column>
			<next:Column header="社会组织名称"  field="cnName" sortable="true" editable="false"width="20%" ><next:TextField></next:TextField></next:Column>
			<next:Column header="登记证号" field="sorgCode" sortable="true" editable="false" width="10%"><next:TextField/></next:Column>
			<next:Column header="社会组织状态" field="sorgStatus" sortable="true" editable="false" width="12%" dataset="sorgStatusSelect"><next:TextField/></next:Column>
			<next:Column header="成立日期" field="buildDate" sortable="true" editable="false" width="10%" ><next:TextField/></next:Column>
			<next:Column header="法定代表人" field="legalPeople" sortable="true" editable="false" width="10%"><next:TextField /></next:Column>
		</next:Columns> 
		<next:BottomBar>
			<next:PagingToolBar dataset="somOrganDataset" />
		</next:BottomBar>
	</next:EditGridPanel>
	
	<next:GridPanel id="checkHisGrid" name="somcheckGrid" stripeRows="true" height="400" dataset="checkDs" title="历年年检情况列表" notSelectFirstRow="true">
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>	     
			<next:Column id="taskCode" header="task_code" field="taskCode" width="90" hidden="true"><next:TextField allowBlank="false" /></next:Column>	
			<next:Column header="社会组织种类" field="sorgType" sortable="true" dataset="sorgTypeSelect" width="10%" editable="false"><next:TextField /></next:Column>
			<next:Column id="cnName" header="社会组织名称" field="cnName" width="250" ><next:TextField  /></next:Column>		
			<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="150" ><next:TextField  /></next:Column>	
			<next:Column id="batchYear" header="年检年份" field="batchYear" width="80" ><next:TextField  /></next:Column>	
			<next:Column id="ifCheck" header="是否参检" field="" width="80" renderer="getIfCheck"><next:TextField  /></next:Column>	
			<next:Column id="commitTime" header="参检时间" field="commitTime" width="150" ><next:TextField  /></next:Column>	
			<next:Column id="checkResult" header="年检结论" field="checkResult" width="80" ><next:ComboBox dataset="checkResultSelect"/></next:Column>		
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="checkDs"/>
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
</body>
</html>