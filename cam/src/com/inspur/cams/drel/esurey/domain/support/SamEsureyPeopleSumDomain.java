package com.inspur.cams.drel.esurey.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.esurey.dao.ISamEsureyPeopleSumDao;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleSum;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleSumDomain;

public class SamEsureyPeopleSumDomain implements ISamEsureyPeopleSumDomain{
    @Reference(name="samEsureyPeopleSumDao")
	private ISamEsureyPeopleSumDao samEsureyPeopleSumDao;
	public DataSet query(ParameterSet ps) {
		return samEsureyPeopleSumDao.query(ps);
	}

	public void save(List<SamEsureyPeopleSum> list) {
		samEsureyPeopleSumDao.save(list);
		
	}

	public void batchDelete(String[] ids) {
		samEsureyPeopleSumDao.batchDelete(ids);
		
	}

	public void insert(SamEsureyPeopleSum dataBean) {
		samEsureyPeopleSumDao.insert(dataBean);
		
	}

	public void update(SamEsureyPeopleSum dataBean) {
		samEsureyPeopleSumDao.update(dataBean);
	}

}
