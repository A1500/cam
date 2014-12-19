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
<next:ScriptManager />
<script type="text/javascript">
    var deptCode=<%=request.getParameter("deptCode")%>;
    var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	function uploadFiles(){
		var width = 600;
	    var height = 177;
		var url="mrmRegisUpload.jsp?deptCode=<%=request.getParameter("deptCode")%>";		
		var w=window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		if(w=='w'){
			init();
		}
	}
	function init(){
		var ds=L5.DatasetMgr.lookup("ds");
		ds.setParameter("dept_code",deptCode);
		ds.load();
	}
	//下载申请证明材料
   function downloadFile(value,cellmeta,record,rowindex,colindex,dataset){
	   var paths = document.location.pathname.split("/");
	   var id = record.get("deptCode");
	   if(record.get("fileName")){
	       var url0=rootPath+"download?table=MRM_REGIS_ORGAN_INFO&column=REGULATION&pk=DEPT_CODE&filename=FILE_NAME&DEPT_CODE='"+id+"'";
		   return '<a id="download"  href='+url0+'>'+record.get("fileName")+'</a>';
	   }else{
		   return '';
	   }
    }
	function removeFiles(){
		var grid = L5.getCmp('filesPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
				if(sta=="yes"){
					var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamApplyFilesCmd");
					var delId=records[0].get("applyFileId");
					command.setParameter("delId", delId);
					command.execute("delete");				
					ds.remove(records[0]);
				}
				else{
					return;
				}
			});	
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	function preview(){
		var url="mrmRegisPreview.jsp?deptCode=<%=request.getParameter("deptCode")%>";
		window.open(url);
	}
</script>
<body>
<model:datasets>
	<!-- 申请材料 -->
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
		</model:record>
	</model:dataset>
</model:datasets>

<next:GridPanel id="filesPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  height="100%" dataset="ds" title="管理制度" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem id="filesAdd" disabled=""  iconCls="add" text="本地磁盘附件" handler="uploadFiles" />
					<next:ToolBarItem id="preview" iconCls="print" text="预览" handler="preview"></next:ToolBarItem>
					<next:ToolBarItem iconCls="remove" text="删除" handler="removeFiles" />
			</next:TopBar>
			<next:Columns>
			     <next:RowNumberColumn width="45"/>
			     <next:Column field="fileName" header="管理制度下载" renderer="downloadFile" width="200"></next:Column>
			</next:Columns>
			<next:BottomBar>
			   <next:PagingToolBar dataset="ds"></next:PagingToolBar>
			</next:BottomBar>
</next:GridPanel>
</body>
</html>