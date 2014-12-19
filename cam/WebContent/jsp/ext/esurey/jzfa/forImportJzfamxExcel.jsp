<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%
	String organType = ExtBspInfo.getUserInfo(request).getOrganType();
%>
<script language="javascript">
	var organType = "<%=organType%>";
</script>
<html>
<head>
<title>导入救助方案明细</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="jzfamxUpLoadDataSet"
		cmd="com.inspur.sdmz.jzfa.cmd.DetailExcelImportCmd">
		<model:record
			fromBean="com.inspur.sdmz.jzfa.data.DetailModel"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="导入救助方案明细"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="导入" handler="importJzfamxExcel" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="backToPre" />
	</next:TopBar>
	<next:Html>
		<form id="upLoadFileForm" method="post" dataset="jzfamxUpLoadDataSet"
			onsubmit="return false"  class="L5form">
		<table width="100%" border="1">
			<tr>
				<td class="FieldLabel" width="20%">请选择要导入的Excel文件:</td>
				<td class="FieldInput" width="80%"><input type="file" maxlength="100"
					id="uploadFile" name="uploadFile" style ="width:300"/></td>
			</tr>
		</table>
		<input type="hidden" name="planId" value='<%=request.getParameter("planId")%>'>
		</form>
	</next:Html>
</next:Panel>
</body>
<script language="javascript">
function init(){
	var jzfamxUpLoadDataSet = L5.DatasetMgr.lookup("jzfamxUpLoadDataSet");
	jzfamxUpLoadDataSet.newRecord();
}
//导入救助方案明细Excel
function importJzfamxExcel() {
	//首先校验选择文件
	var files = document.forms[0].uploadFile;
	if(files.value == " " || files.value == ""){
		L5.MessageBox.alert("提示", "请选择要导入的用户文件!");
		return;
	}
	if(files.value.lastIndexOf(".xls") == -1){
		L5.MessageBox.alert("提示", "请选择文件格式为*.xls的文件！");
		return;
	}
	var jzfamxUpLoadDataSet = L5.DatasetMgr.lookup("jzfamxUpLoadDataSet");
	var record = jzfamxUpLoadDataSet.getCurrent();
	if(organType=='100'){
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.DetailExcelImportCmdCL");	
	}else{
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.DetailExcelImportCmd");	
	}
	command.setForm(L5.getDom("upLoadFileForm"));
    command.setParameter("upLoadViewRecord", record);
    var planId = document.all.planId.value;
    command.setParameter("planId", planId);//设置救助方案ID参数
    command.afterExecute=function(){
            	  if (!command.error) {
            		L5.Msg.alert("提示", "导入成功!", function(){
            			//转向查询页面
              			//var url="/jsp/sdmz/jzfa/jzfamxQuery.jsp?jzfaid="+jzfaid;
              			var url="jsp/ext/esurey/jzfa/jzfaQuery.jsp";
              			L5.forward(url, "救助方案明细查询");
                		});
          		}else{
          			L5.Msg.alert("错误:", command.error);
          		}
    }
    command.execute("importJzfamxExcel");
}
function backToPre() {
	var returnJsp='<%=request.getParameter("returnJsp")%>'
	var planId = document.all.planId.value;
	var text = "救助方案明细查询";
	var url = "jsp/ext/esurey/jzfa/"+returnJsp+"?planId="+planId+"&returnJsp="+""+"&planBegin="+""+"&planEnd="+"";
	L5.forward(url, text);
}
</script>
</html>