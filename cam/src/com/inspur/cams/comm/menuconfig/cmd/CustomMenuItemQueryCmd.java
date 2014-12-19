package com.inspur.cams.comm.menuconfig.cmd;

import org.loushang.bsp.organization.dao.StruDao;
import org.loushang.bsp.permit.menu.domain.IMenuItemDomain;
import org.loushang.bsp.permit.menu.domain.IMenuStruDomain;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.menuconfig.dao.IMenuConfigSearchDao;

/**
 * @Path com.inspur.cams.comm.menuconfig.cmd.CustomMenuItemQueryCmd  
 * @Description: TODO 查询指定模块下不规则（最大号）主键的菜单项
 * @author xuexzh
 * @date 2012-3-31
 */
public class CustomMenuItemQueryCmd extends BaseQueryCommand {
	private IMenuItemDomain imenuItemDomain = null;
	private IMenuStruDomain imenuStruDomain = null;

	public CustomMenuItemQueryCmd() {
		this.imenuItemDomain = ((IMenuItemDomain) ScaComponentFactory
				.getService(IMenuItemDomain.class,
						"MenuItemDomain/MenuItemDomain"));
		this.imenuStruDomain = ((IMenuStruDomain) ScaComponentFactory
				.getService(IMenuStruDomain.class,
						"MenuStruDomain/MenuStruDomain"));
	}

	public DataSet queryMenuItem() {
		DataSet ds = imenuItemDomain.query(getParameterSet());
		return ds;
	}

	public DataSet queryMenuStru() {
		DataSet ds = imenuStruDomain.query(getParameterSet());
		return ds;
	}
}
