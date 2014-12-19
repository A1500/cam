package com.inspur.cams.drel.organ.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.organ.dao.ISamSupportOrganDao;
import com.inspur.cams.drel.organ.date.SamSupportOrgan;
import com.inspur.cams.drel.organ.domain.ISamSupportOrganDomain;
/**
 * @title:SamSupportOrgan
 * @description:孤儿院、敬老院 Domain接口
 * @author douyn
 * @since:2012-05-21
 * @version:1.0
*/
public class SamSupportOrganDomain implements ISamSupportOrganDomain {
	
	@Reference
	private ISamSupportOrganDao samSupportOrganDao;

	@Reference
	public void setSamSupportOrganDao(ISamSupportOrganDao samSupportOrganDao) {
		this.samSupportOrganDao = samSupportOrganDao;
	}


	public DataSet query(ParameterSet pset) {
		return samSupportOrganDao.query(pset);
	}


	public void insert(SamSupportOrgan organ) {
		organ.setOrganId(IdHelp.getUUID32());
		samSupportOrganDao.insert(organ);
	}


	public void update(SamSupportOrgan organ) {
		samSupportOrganDao.update(organ);
	}
	
	public void delete(String organId) {
		samSupportOrganDao.delete(organId);
	}
}
