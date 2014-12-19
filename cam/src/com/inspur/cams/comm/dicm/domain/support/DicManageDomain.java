package com.inspur.cams.comm.dicm.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.dicm.dao.IDicManageDao;
import com.inspur.cams.comm.dicm.data.DicManage;
import com.inspur.cams.comm.dicm.domain.IDicManageDomain;

public class DicManageDomain implements IDicManageDomain {

	@Reference
	private IDicManageDao dicManageDao;
	
	public void insert(DicManage dicManage) {
		dicManageDao.insert(dicManage);
	}

	public DataSet query(ParameterSet pset) {
		return dicManageDao.query(pset);
	}

	public void save(List<DicManage> list) {
		dicManageDao.save(list);
	}

	public void update(DicManage dicManage) {
		dicManageDao.update(dicManage);
	}
	
}
