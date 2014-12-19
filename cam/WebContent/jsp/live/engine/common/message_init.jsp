<%@page import="org.loushang.cms.util.UUIDGenerator"%>
<%@page import="org.loushang.live.engine.util.PropertyUtil"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/live/engine/common/common.js"></script>
<%
	String msgId = request.getParameter("msgId");
	String newMsgId = UUIDGenerator.get32();
	String method = request.getParameter("method");
	//如果是新建的消息则生成新的id
	if("new".equals(method)){
		msgId = UUIDGenerator.get32();
	}
	if(msgId==null || "".equals(msgId)){
		msgId = UUIDGenerator.get32();
	}	
	//获取用户id
//	String userId = GetBspInfo.getBspInfo().getUserId();
	//获取消息类型
	String msgType = request.getParameter("msgType");
	
	//得到是否需要刷新父窗口
	String openerReload = request.getParameter("reload");
	if(openerReload==null || openerReload.equals(""))
		openerReload = "false";
	
	//是否使用消息队列引入不同的发送方式
	String usejms = PropertyUtil.getInstance().get("usejms");
	String sendHandle = "sendCmd";
	if(!"true".equals(usejms)){
		sendHandle = "sendServlet";
	}
%>