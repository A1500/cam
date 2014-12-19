package com.inspur.cams.drel.esurey.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.esurey.dao.ISamEsureyOrganConfigDao;
import com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig;
import com.inspur.cams.drel.esurey.domain.ISamEsureyOrganConfigDomain;

public class SamEsureyOrganConfigDomain implements ISamEsureyOrganConfigDomain{
	@Reference(name="samEsureyOrganConfigDao")
	private ISamEsureyOrganConfigDao samEsureyOrganConfigDao ;

	public DataSet query(ParameterSet pst) {
		return samEsureyOrganConfigDao.query(pst);
	}

	
	public void save(List<SamEsureyOrganConfig> list) {
		samEsureyOrganConfigDao.save(list);
	}

}
