package com.inspur.cams.drel.esurey.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.esurey.dao.ISamEsureyFamilySumDao;
import com.inspur.cams.drel.esurey.data.SamEsureyFamilySum;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFamilySumDomain;
/**
 * @title:ISamEsureyFamilySumDomain
 * @description:经济核对_家庭经济状况审核汇总domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyFamilySumDomain implements ISamEsureyFamilySumDomain {
	@Reference(name = "samEsureyFamilySumDao")
	private ISamEsureyFamilySumDao samEsureyFamilySumDao ;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureyFamilySumDao.batchDelete(delIds);
	}

	public void insert(SamEsureyFamilySum dataBean) {
		// TODO Auto-generated method stub
		samEsureyFamilySumDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyFamilySumDao.query(pset);
	}

	public void save(List<SamEsureyFamilySum> list) {
		// TODO Auto-generated method stub
		samEsureyFamilySumDao.save(list);
	}

	public void update(SamEsureyFamilySum dataBean) {
		// TODO Auto-generated method stub
		samEsureyFamilySumDao.update(dataBean);
	}
}
