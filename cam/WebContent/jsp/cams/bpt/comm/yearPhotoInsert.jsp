<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptYearPhotoCommand"%>
<%@ page import="org.loushang.next.data.DataSet"%>
<%
BptYearPhotoCommand command = new BptYearPhotoCommand();
String peopleId=(String)request.getParameter("peopleId");
DataSet ds  = command.getYearPhotosByPeopleId(peopleId);

%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
</script>
<html>
<head>
<title></title>
<next:ScriptManager/>
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			
		</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<link href="../../comm/diccity/autoComplete.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" >
	function editYearPhoto(){
		editPhoto(1,'photoTemp','RELATIONER_PHOTOC_IMG');
	}
</script>
</head>
<body>
<next:Panel  height="100%" width="100%"  autoScroll="true" id="Panel">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="upload" text="上传" handler="editYearPhoto" />
					<next:ToolBarItem iconCls="save" text="保存" handler="save" />
				</next:TopBar>	
				<next:Html>
					<form id="yearPhotoForm" method="post"  onsubmit="return false" style="padding: 5px;" >
					<table border="0" width="98%" >
						
						<tr align="center">
							<td nowrap >
								图片预览
							</td>
						</tr>
						<tr align="center">
							<td nowrap >
								年度
							<select id="year">
								<option value="2005">2005</option>
								<option value="2006">2006</option>
								<option value="2007">2007</option>
								<option value="2008">2008</option>
								<option value="2009">2009</option>
								<option value="2010">2010</option>
								<option value="2011">2011</option>
								<option value="2012">2012</option>
								<option value="2013">2013</option>
								<option value="2014">2014</option>
								<option value="2015">2015</option>
								<option value="2016">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
								<option value="2022">2022</option>
								<option value="2023">2023</option>
								<option value="2024">2024</option>
								<option value="2025">2025</option>
							</select>
							</td>
						</tr>
					    <tr align="center" > 
							
							<td nowrap valign="center" >
								<div  style="width:0px;">
									<img name="RELATIONER_PHOTOC_IMG" width=280 height=390
										src="" align="top" 
										onerror="javascript:this.src='../dataCollection/comm/default.jpg'" alt="暂无图片" />
								</div>
									<input type="hidden" id="photoTemp" name="photoTemp">
									<input type="hidden" id="photoId" name="photoId">
							</td>
						</tr>
                     </table>
					</form>
					<form id="yearPhoto2Form" method="post" onsubmit="return false" style="padding: 5px;" >
					  <table border="0" width="98%">
					  <tr align="center">
					  <%for( int i= 0;i<ds.getCount();i++){ 
						  String photoId=(String)ds.getRecord(i).get("photoId");
						  String year=(String)ds.getRecord(i).get("year");
					    	 String photoTable = "COM_PHOTO";
					    	 if(photoId!=null && photoId.length()>0){
					    	 	photoTable = photoTable+"_"+photoId.substring(0,6);
					    	 } 
					  %>
							<td nowrap>
							<div id="RELATIONER_PHOTOC_IMG_DIV1" style="width:0px;">
							<img name="RELATIONER_PHOTOC_IMG1" width=170  src="<%=SkinUtils.getRootUrl(request) %>download?table=<%=photoTable %>&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='<%=photoId %>'" style="float:left"
								onerror="javascript:this.src='../dataCollection/comm/default.jpg'" alt="暂无图片" />
							
							<%=year %><a href="javascript:del('<%=photoId %>');" style="text-decoration:none;font-size:14;">删除</a>
							</div>
							</td>
							<%if((i+1)%5==0){%>
							</tr><tr align="center">
							<%} else if(ds.getCount()==i+1){%>		
						 	</tr>
						 	<%} %>
						 <%} %>
                     </table>
					</form>
			</next:Html>
	</next:Panel>
<script type="text/javascript">
function init() {
	var myDate = new Date();
	document.getElementById("year").value=myDate.getYear(); 
}
function save(){
	var img=document.getElementById("photoTemp").value;
	var year=document.getElementById("year").value;
    if(img==null||img=="")
    {
    	L5.Msg.alert("提示", "请选择照片!");
    	return false;
    }
    if(year==null||year=="")
    {
    	L5.Msg.alert("提示", "请选择年度!");
    	return false;
    }
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptYearPhotoCommand");
	
	command.setParameter("photoTemp", img);
	command.setParameter("peopleId", peopleId);
	command.setParameter("year", year);
	command.execute("insertYearPhoto");
	if (!command.error) {
		alert('保存成功！');
		location=location ;
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function del(photoId) {

	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptYearPhotoCommand");
			command.setParameter("photoId", photoId);
			command.execute("deleteYearPhoto");
			if (!command.error) {
				location=location ;
			} else {
				L5.Msg.alert('提示', "删除时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
</script>
</body>

</html>
