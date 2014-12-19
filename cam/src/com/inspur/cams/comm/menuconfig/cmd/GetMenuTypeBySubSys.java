package com.inspur.cams.comm.menuconfig.cmd;

import org.loushang.bsp.permit.menu.domain.IGetMenuTypeByRule;
import org.loushang.next.web.cmd.CommandContext;

public class GetMenuTypeBySubSys implements IGetMenuTypeByRule{
	
	public String getMenuType(String arg0) {
		String _menuType =(String) CommandContext.getRequest().getSession().getAttribute("_menuType");
		return _menuType;
	}
	
}
