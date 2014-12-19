package com.inspur.cams.comm.menuconfig.cmd;

import java.util.HashMap;
import java.util.List;

import org.loushang.bsp.permit.menu.domain.IGetMenuTypeByRule;
import org.loushang.next.dao.DaoFactory;

import com.inspur.cams.comm.menuconfig.dao.PubMenuConfigDao;
import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;
import com.inspur.cams.comm.util.BspUtil;

public class GetMenuTypeByRule implements IGetMenuTypeByRule{
	private PubMenuConfigDao dao = (PubMenuConfigDao) DaoFactory
	.getDao("com.inspur.cams.comm.menuconfig.dao.PubMenuConfigDao");

	public String getMenuType() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getMenuType(String arg0) {
		String organCode = BspUtil.getEmpOrgan().getOrganCode();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("ORGAN_CODE", organCode);
		List list = dao.queryNoPage(map);
		String menuType ="1";
		if(list.size()>0){
			PubMenuConfig pubmenuconfig = (PubMenuConfig)list.get(0);
			menuType=pubmenuconfig.getMenuTypeId();
		}
		return menuType;
	}
	
}
