package com.inspur.cams.comm.menuconfig.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.permit.menu.domain.IMenuItemDomain;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.menuconfig.dao.PubMenuConfigDao;
import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;
import com.inspur.cams.comm.menuconfig.domain.ICustomMenuDomain;
import com.inspur.cams.comm.menuconfig.domain.IPubMenuConfigDomain;

/**
 * @Path com.inspur.cams.comm.menuconfig.cmd.CustomMenuCommand
 * @Description: TODO 变更菜单主键（针对与最大号主键的问题）
 * @author xuexzh
 * @date 2012-3-31
 */
public class CustomMenuCommand extends BaseAjaxCommand {

	private ICustomMenuDomain customMenuDomain;

	public CustomMenuCommand() {
		this.customMenuDomain = ((ICustomMenuDomain) ScaComponentFactory
				.getService(ICustomMenuDomain.class,
						"CustomMenuDomain/CustomMenuDomain"));
	}

	public void updatePk() {
		String moduleCode = (String) getParameter("moduleCode");
		String menuConfig = (String) getParameter("menuConfig");
		Map<String,String> map = new HashMap<String,String>();
		map.put("OLD_CODE", moduleCode);
		map.put("CODE", moduleCode);
		map.put("CONFIG", menuConfig);
		customMenuDomain.updatePk(map);
	}
}
