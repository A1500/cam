package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.base.data.WealFitDevice;
import com.inspur.cams.welfare.base.domain.IWealFitDeviceDomain;

/**
 * @title:WealFitDeviceQueryCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitDeviceQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealFitDevice> dao = (EntityDao<WealFitDevice>) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealFitDeviceDao");
		return dao.query(pset);
	}
	private IWealFitDeviceDomain wealFitDeviceDomain = ScaComponentFactory
			.getService(IWealFitDeviceDomain.class, "wealFitDeviceDomain/wealFitDeviceDomain");
	/**
	 * 假矫设施基本情况统计
	 * @param pset
	 * @return
	 */
	public DataSet reportDeviceInfo() {
		ParameterSet pset = getParameterSet();
		return wealFitDeviceDomain.reportDeviceInfo(pset);
	}
}
