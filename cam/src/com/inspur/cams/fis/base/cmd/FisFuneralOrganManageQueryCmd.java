package com.inspur.cams.fis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.dao.*;
import com.inspur.cams.fis.base.domain.IFisFuneralOrganManageDomain;
import com.inspur.cams.fis.base.domain.support.FisFuneralOrganManageDomain;

/**
 * @title:FisFuneralOrganManageQueryCommand
 * @description:
 * @author:
 * @since:2012-04-03
 * @version:1.0
 */
public class FisFuneralOrganManageQueryCmd extends BaseQueryCommand {

	private IFisFuneralOrganManageDomain service = ScaComponentFactory.getService(IFisFuneralOrganManageDomain.class, "FisFuneralOrganManageDomain/FisFuneralOrganManageDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}

	/**
	 * @Title: queryOrganByUnitId
	 * @Description: 殡仪馆树的查询
	 * @author jiangzhaobao
	 */
	public DataSet queryOrganByUnitId() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryOrganByUnitId(pset);
		ds.getMetaData().setIdProperty("ORGAN_CODE");
		return ds;
	}

	public DataSet queryInfoByArea() {
		ParameterSet pset = getParameterSet();
		return service.queryInfoByArea(pset);
	}

	/**
	 * @Description: 馆基本信息统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganSum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFuneralOrganSum(pset);
		return ds;
	}

	/**
	 * @Description: 馆建设情况统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganBuildSum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFuneralOrganBuildSum(pset);
		return ds;
	}

	/**
	 * @Description: 馆设备情况统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganEquSum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFuneralOrganEquSum(pset);
		return ds;
	}
}
