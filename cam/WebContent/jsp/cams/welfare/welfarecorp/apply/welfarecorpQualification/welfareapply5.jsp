<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<%@page import="com.inspur.cams.drel.comm.SamConfig"%>
<html>
<head>
<title>福利企业附件录入页面</title>
<next:ScriptManager />
<script type="text/javascript" src="../../../common/js/float.js"></script>
<script type="text/javascript">
	function uploadFiles(){
		var width = 600;
	    var height = 177;
		var url="../../comm/uploadFile.jsp";
		window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
	//下载申请证明材料
	function downloadFile(value,cellmeta,record,rowindex,colindex,dataset){
		var paths = document.location.pathname.split("/");
		var id = record.get("applyFileId");
		if(record.get('fileName')){
		    var url0=rootPath+"download?table=sam_apply_files&column=file_content&pk=apply_file_id&filename=file_name&apply_file_id='"+id+"'";
			return '<a id="download"  href='+url0+'>'+record.get('fileName')+'</a>';
		}else{
			return '';
		}
	}
	function save(){
	}
</script>
<body>
<model:datasets>
	<!-- 申请材料 -->
	<model:dataset id="filesListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage('4')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" />
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backPage();"/>
</div>
<form method="post" onsubmit="return false" >
<TABLE height=100 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<TR>
			<TD class=title1 align=middle height=67>&nbsp;附件证明材料</TD>
		</TR>
</TABLE>
</form>
<next:GridPanel id="filesPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="filesListDataset" title="申请证明材料">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem id="filesAdd" disabled=""  iconCls="add" text="本地磁盘附件" handler="uploadFiles" />
					<next:ToolBarItem iconCls="remove" text="删除"  />
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
			    <next:Column header="证明材料名称" field="fileType" width="200" >
					<next:TextField  />
				</next:Column>
				<next:Column header="文件名" field="applyFileId" width="400" renderer="downloadFile" >
				</next:Column>
				<next:Column header="备注" field="remarks" width="400" >
					<next:TextField  />
				</next:Column>
			</next:Columns>
	
	</next:GridPanel>
</body>
</html>