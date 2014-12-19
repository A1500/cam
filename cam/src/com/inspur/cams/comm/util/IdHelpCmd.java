package com.inspur.cams.comm.util;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import com.inspur.cams.comm.util.IdHelp;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-8-16
 */
public class IdHelpCmd extends BaseAjaxCommand{
	public void execute(){
		String sFlag=(String)getParameter("IdHelp");
		String id=IdHelp.getUUID30();
		String sId=IdHelp.getUUID32();
		if(sFlag.equals("Id30")){
			setReturn("id",id);
		}else if(sFlag.equals("Id32")){
			setReturn("id",sId);
		}
	}
}
