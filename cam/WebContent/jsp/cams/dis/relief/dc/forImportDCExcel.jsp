<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>导入冬春生活救助明细</title>
<next:ScriptManager/>
<script type="text/javascript">
	var batchId = '<%=request.getParameter("batchId")%>';
	var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="dcUpLoadDataSet"
		cmd="com.inspur.cams.dis.base.cmd.DisDcExcelImportCmd">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="导入冬春生活救助明细"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="导入" handler="importdcExcel" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="backToPre" />
	</next:TopBar>
	<next:Html>
		<form id="upLoadFileForm" method="post" dataset="dcUpLoadDataSet"
			onsubmit="return false" class="L5form">
		<table width="100%" border="1">
			<tr>
				<td class="FieldLabel" width="20%">请选择要导入的Excel文件:</td>
				<td class="FieldInput" width="80%"><input type="file" maxlength="100"
					id="uploadFile" name="uploadFile" style ="width:500"/></td>
			</tr>
		</table>
		<div>
			<label style="color: red;">注意：请用系统首页论坛里下载的模板文件填充数据后导入或者将Excel所有单元格的格式设置成文本后再填充数据，否则可能导致导入数据错误！</label>
		</div>
		</form>
	</next:Html>
</next:Panel>
</body>
<script language="javascript">
function init(){
	var dcUpLoadDataSet = L5.DatasetMgr.lookup("dcUpLoadDataSet");
	dcUpLoadDataSet.newRecord();
}
//导入冬春生活救助明细Excel
function importdcExcel() {
	//首先校验选择文件
	var files = document.forms[0].uploadFile;
	if(files.value == " " || files.value == ""){
		L5.MessageBox.alert("提示", "请选择要导入的用户文件！");
		return;
	}
	if(files.value.lastIndexOf(".xls") == -1){
		L5.MessageBox.alert("提示", "请选择文件格式为*.xls的文件！");
		return;
	}
	var dcUpLoadDataSet = L5.DatasetMgr.lookup("dcUpLoadDataSet");
	var record = dcUpLoadDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisDcExcelImportCmd");	
	command.setForm(L5.getDom("upLoadFileForm"));
    command.setParameter("upLoadViewRecord", record);
    command.setParameter("batchDetailId", batchDetailId);// 填报期数
	command.setParameter("batchId", batchId);// 业务类型
	command.execute("importDcExcel");
    command.afterExecute=function(){
            	  if (!command.error) {
            		L5.Msg.alert("提示", "导入成功!", function(){
            			//转向查询页面
            			window.returnValue = true;
						window.close();
                		});
          		}else{
          			L5.Msg.alert("错误:", command.error);
          		}
    }
    
}
function backToPre() {
	window.returnValue = true;
	window.close();
}
</script>
</html>