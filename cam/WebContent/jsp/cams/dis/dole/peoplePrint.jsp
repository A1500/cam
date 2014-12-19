<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@page import="org.loushang.workflow.util.bsp.BspUtil"%>
<script type="text/javascript">
	var peopleName='<%=BspUtil.getInstance().getLoginUserId()%>';
</script>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head> 
<script type="text/javascript">
	//var photoPath = "<%=SkinUtils.getRootUrl(request)%>download?";
	 var docPath = "<%= request.getParameter("docPath")%>"; // 模板路径
	 var basePath = "<%= basePath%>";// 获得模板在服务器路径
	 var queryData = "<%= request.getParameter("queryData")%>"; // 查询条件
	 var method = "<%= request.getParameter("method")%>";//调用的方法名
</script>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="json.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="peoplePrint.js"></script>
<title>名册打印</title>
</head>
<body >
<model:datasets>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
	<next:Panel  name="form" anchor="100% 100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" >
	<next:Html>
    <form id="Form1" >
				<table  cellspacing="0" width="100%">
                        <tr style="display: none;">
                        	<td class="FieldLabel">
                                <div style="width:130px"><span id="limit"></span></div>
                            </td>
                            <td class="FieldLabel">
                                <div style="width:130px"><span id="evryPrt"></span></div>
                            </td >
				  			<td class="FieldLabel">
				  				<button name="print" onclick="printdoc(false)">打印</button>
				  			</td>
				  			<td class="FieldLabel">
				  				<button name="close" onclick="returnButton()">关闭</button>
				  			</td>
                        </tr>
                    </table>

              <div id="divOjet" width="100%" height="100%" >
                    <object id="webOfficeNt" codebase="OfficeControl.cab#version=4,0,6,0" height="100%"
                        width="100%" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" viewastext>
                        <param name="_ExtentX" value="22728">
                        <param name="_ExtentY" value="17039">
                        <param name="BorderColor" value="-2147483632">
                        <param name="BackColor" value="-2147483643">
                        <param name="ForeColor" value="-2147483640">
                        <param name="TitlebarColor" value="42768">
                        <param name="TitlebarTextColor" value="0">
                        <param name="BorderStyle" value="1">
                        <param name="Titlebar" value="1">
                        <param name="Toolbars" value="1">
                        <param name="Caption" value="正文内容">
                        <param name="ProductCaption" value="浪潮ECGAP">
                        <param name="ProductKey" value="99820CD845CC062ECE8362C16BC825CDCA3B1C41">
                        <param name="MakerCaption" value="山东浪潮齐鲁软件产业股份有限公司">
                        <param name="MakerKey" value="57B3D598DFFAAE2EC83F4E49B6EB14A03769AF82">
                        <param name="IsShowToolMenu" value="1">
                        <param name="IsNoCopy" value="0">
                        <param name="IsHiddenOpenURL" value="0">
                        <param name="MaxUploadSize" value="0">
                        <param name="Menubar" value="1">
                        <param name="Statusbar" value="1">
                        <param name="FileNew" value="-1">
                        <param name="FileOpen" value="-1">
                        <param name="FileClose" value="-1">
                        <param name="FileSave" value="-1">
                        <param name="FileSaveAs" value="-1">
                        <param name="FilePrint" value="-1">
                        <param name="FilePrintPreview" value="-1">
                        <param name="FilePageSetup" value="-1">
                        <param name="FileProperties" value="-1">
                        <param name="IsStrictNoCopy" value="0">
                        <param name="IsUseUTF8URL" value="0">
                        <param name="MenubarColor" value="16777215">
                        <param name="IsUseControlAgent" value="0">
                        <param name="IsUseUTF8Data" value="0">
                        <param name="IsSaveDocExtention" value="0">
                        <param name="IsDirectConnect" value="0">
                        <param name="SignCursorType" value="0">
                        <param name="IsResetToolbarsOnOpen" value="0">
                        <param name="IsSaveDataIfHasVDS" value="0">
                        <param name="MenuButtonStyle" value="0">
                        <param name="MenuButtonColor" value="16180947">
                        <param name="MenuButtonFrameColor" value="14924434">
                        <param name="MenuBarStyle" value="0">
                        <param name="IsGetPicOnlyOnHandSign" value="0">
                        <span >不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置。</span>
                    </object>
 		</div>
    </form>
    </next:Html></next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
	
</html>
