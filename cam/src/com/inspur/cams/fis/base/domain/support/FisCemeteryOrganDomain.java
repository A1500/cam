package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeteryOrganDao;
import com.inspur.cams.fis.base.data.FisCemeteryOrgan;
import com.inspur.cams.fis.base.domain.IFisCemeteryOrganDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.IFisCemeteryOrganDomain
 * @Description: TODO 殡葬业务公墓信息表domain的实现
 * @author muqi
 * @date 2012-04-09
 */
public class FisCemeteryOrganDomain implements IFisCemeteryOrganDomain {

	@Reference
	private IFisCemeteryOrganDao fisCemeteryOrganDao;

	public DataSet query(ParameterSet pset) {
		return fisCemeteryOrganDao.query(pset);
	}

	public void update(FisCemeteryOrgan bean) {
		fisCemeteryOrganDao.update(bean);
	}

	public DataSet queryForExport(ParameterSet pset) {
		return fisCemeteryOrganDao.queryForExport(pset);
	}

	public void insert(FisCemeteryOrgan bean) {
		fisCemeteryOrganDao.insert(bean);
	}
}
